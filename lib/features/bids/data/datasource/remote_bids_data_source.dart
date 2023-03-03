import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voomeg/core/global/resources/strings_manager.dart';
import 'package:voomeg/features/bids/data/datasource/fire_store_consts.dart';
import 'package:voomeg/features/bids/data/models/car_for_sale_model.dart';
import 'package:voomeg/features/bids/data/models/offer_model.dart';

abstract class BaseBidsRemoteDataSource{
  Future<List<CarForSaleModel>>getUserCarsForSale({required String userId});
  Future<void> addCar(CarForSaleModel car);
  //Future<void> addCarImagesToStorage({required List<File> images,required String saleId});
  Future<Reference> savingImageToFireStorage({required XFile image,required String saleId});
  Future<String> getUploadedImageUrl({required Reference reference});
  Future<List<CarForSaleModel>>getAvailableCarsForSale();
  Future<void> addOffer(OfferModel offer);

  Future<List<OfferModel>> fetchAllUserOffers({required String userUid});
  Future<List<OfferModel>> fetchOffersForOneCar({required String userUid,required String saleId});
  Future<void> acceptOffer(OfferModel offer);




}
class BidsRemoteDataSource implements BaseBidsRemoteDataSource{
 final FirebaseFirestore fireStore =FirebaseFirestore.instance;
 final FirebaseStorage firebaseStorage =FirebaseStorage.instance;
 final FirebaseAuth currentUser=FirebaseAuth.instance;

 @override
  Future<void> addCar(CarForSaleModel car)async {
   // final ref= FirebaseStorage.instance.ref().child('userImage').child(_uid!+'.jpg');
   // await ref.putFile(imageFile!);
   return await fireStore.collection(BidsFireStoreConsts.forSale).doc(car.saleId).set(car.toFireStore());
  }

  @override
  Future<List<CarForSaleModel>> getUserCarsForSale({required String userId})async {

    final result = await
        fireStore.collection(BidsFireStoreConsts.forSale)
        .where(AppStrings.userId, isEqualTo: userId).get();


    final carsList = result.docs.map((e) => CarForSaleModel.fromFireBase(e.data()))
        .toList();

    return  carsList;
  }


  @override
  Future<Reference> savingImageToFireStorage({required XFile image,required String saleId}) async{
    var ref = firebaseStorage.ref().child(saleId).child(image.path);
    await ref.putFile(File(image.path));
    return  ref;
  }

  @override
  Future<String> getUploadedImageUrl({required Reference reference})async {
   return await reference.getDownloadURL();
  }

  @override
  Future<List<CarForSaleModel>> getAvailableCarsForSale()async {
   final result = await fireStore.collection(BidsFireStoreConsts.forSale).where(AppStrings.saleStatus,isEqualTo:AppStrings.available ).get();
   final carsList = result.docs.map((document) => CarForSaleModel.fromFireBase(document.data()))
       .toList();

   return carsList;
  }

  @override
  Future<void> addOffer(OfferModel offer)async {
    return await fireStore.collection(BidsFireStoreConsts.offers).doc(offer.traderUid).collection(BidsFireStoreConsts.traderOffers).doc(offer.saleId).set(offer.toFireStore());

  }

  @override
  Future<List<OfferModel>> fetchAllUserOffers({required String userUid})async {
    List<OfferModel>offersList=[];
    await fireStore
        .collection(BidsFireStoreConsts.offers).get().then((value)async {
      for(var doc in value.docs){
        await fireStore.collection(BidsFireStoreConsts.offers)
            .doc(doc.id)
            .collection(BidsFireStoreConsts.traderOffers)
            .where('userUid', isEqualTo: userUid)
            .get().then((value2)async {
          offersList.addAll(List<QueryDocumentSnapshot>.from(value2.docs).map((e) => OfferModel.fromFireBase(e.data())).toList());

        });

      }
    });

    return  offersList;
  }

  @override
  Future<List<OfferModel>> fetchOffersForOneCar({required String userUid,required String saleId})async {
   List<OfferModel>offersForSale=[];


    await fireStore
        .collection(BidsFireStoreConsts.offers).get().then((value)async {
      for(var doc in value.docs){

        await fireStore.collection(BidsFireStoreConsts.offers)
            .doc(doc.id)
            .collection(BidsFireStoreConsts.traderOffers)
            .where('userUid', isEqualTo: userUid ).where('saleId',isEqualTo:saleId)
            .get().then((value2)async {
          var desiredData=value2.docs;
          offersForSale.addAll(List<QueryDocumentSnapshot>.from(desiredData).map((e) => OfferModel.fromFireBase(e.data())).toList());

        });

      }
    });

    return   offersForSale;


  }
  @override
 Future<void> acceptOffer(OfferModel offer)async{
   FirebaseFirestore firestore = FirebaseFirestore.instance;
   await firestore.collection(BidsFireStoreConsts.offers).doc(offer.traderUid).collection(BidsFireStoreConsts.traderOffers).doc(offer.saleId).update({'offerStatus':'Accepted'}).whenComplete(()async {
     await firestore.collection(BidsFireStoreConsts.forSale).doc(offer.saleId).update({'saleStatus':'Not Available','soldAt':Timestamp.now()});
   });

 }




}