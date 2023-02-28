import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voomeg/features/bids/data/datasource/fire_store_consts.dart';
import 'package:voomeg/features/bids/data/models/car_for_sale_model.dart';

abstract class BaseBidsRemoteDataSource{
  Future<List<CarForSaleModel>>getUserCarsForSale();
  Future<void> addCar(CarForSaleModel car);
  //Future<void> addCarImagesToStorage({required List<File> images,required String saleId});
  Future<void> addCarImagesToStorage({required List<XFile>chosenImages,required String saleId ,required List<dynamic>urls});
  Future<Reference> savingImageToFireStorage({required XFile image,required String saleId});
  Future<String> getUploadedImageUrl({required Reference reference});

}
class BidsRemoteDataSource implements BaseBidsRemoteDataSource{
 final FirebaseFirestore fireStore =FirebaseFirestore.instance;
 final FirebaseStorage firebaseStorage =FirebaseStorage.instance;
 final FirebaseAuth currentUser=FirebaseAuth.instance;
 late final CollectionReference imgRef;
  @override
  Future<void> addCar(CarForSaleModel car)async {
   // final ref= FirebaseStorage.instance.ref().child('userImage').child(_uid!+'.jpg');
   // await ref.putFile(imageFile!);
   return await fireStore.collection(BidsFireStoreConsts.forSale).doc(car.saleId).set(car.toFireStore());
  }

  @override
  Future<List<CarForSaleModel>> getUserCarsForSale()async {

    var result2= await fireStore.collection(BidsFireStoreConsts.forSale).get();
    var result= result2.docs.where((element) {
      return element.get("userId")==currentUser.currentUser!.uid;
    }).toList().map((e) => CarForSaleModel.fromFireBase(e.data())).toList();
    ///Getting all users sales below
    //
    // var ressss2= result2.docs.toList().map((e) => CarForSaleModel.fromFireBase(e.data())).toList();
    // print(ressss2);
    return await result;
  }

  @override
  Future<void> addCarImagesToStorage({required List<XFile>chosenImages,required String saleId ,required List<dynamic>urls}) async {
    // int i = 1;
    //
    // for (var image in chosenImages) {
    //   setState(() {
    //     val= i / images.length ;
    //   });
    //   var ref = firebaseStorage.ref().child('$saleId').child('${image.path}');
    //   await ref.putFile(File(image.path)).whenComplete(() async {
    //     await ref.getDownloadURL().then((value) {
    //       urls.add(value);
    //       i++;
    //     });
    //   });
    // }
  }

  @override
  Future<Reference> savingImageToFireStorage({required XFile image,required String saleId}) async{
    var ref = firebaseStorage.ref().child('$saleId').child('${image.path}');
    await ref.putFile(File(image.path));
    return await ref;
  }

  @override
  Future<String> getUploadedImageUrl({required Reference reference})async {
   return await reference.getDownloadURL();
  }

}