import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/features/bids/data/datasource/fire_store_consts.dart';
import 'package:voomeg/features/bids/data/models/offer_model.dart';
import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';
import 'package:voomeg/features/bids/domain/entities/offer.dart';
import 'package:voomeg/features/bids/presentation/controller/offers_blocs/user_offers_bloc.dart';

import '../../../../../core/global/resources/values_manager.dart';

class UserOffersScreen extends StatelessWidget {
   UserOffersScreen({Key? key, this.userUid,this.saleId,this.currentSale}) : super(key: key);
  final String? userUid;
  final String? saleId;
  List<OfferModel> offersList=[];
  List<OfferModel> offersForSale=[];
   CarForSale? currentSale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserOffersBloc,UserOffersState>(
          listener: (context,listenerState){},
          builder: (context, state) {
            if (state.getOffersForCarRequestState == RequestState.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }  else if (state.getOffersForCarRequestState == RequestState.isError){
              return Center(child: Text('Error is ${state.getOffersForCarErrorMessage}'),);
            }else {
              return ListView.builder(
                  itemCount: state.carOffers!.length,
                  itemBuilder: (context,index){
                    var offer=state.carOffers![index];
                    return Container(
                      margin: const EdgeInsets.only(left: AppMargin.m22,right: AppMargin.m20,top: AppMargin.m50,bottom: AppMargin.m22),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('trader name',style: Theme.of(context).textTheme.headlineLarge,),
                                Text('${offer.traderName}',style: Theme.of(context).textTheme.headlineLarge),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('offer Status ',style: Theme.of(context).textTheme.headlineLarge,),
                                Text('${offer.offerStatus} ',style: Theme.of(context).textTheme.headlineLarge),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Offered Price ',style: Theme.of(context).textTheme.headlineLarge,),
                                Text('${offer.price} EGP',style: Theme.of(context).textTheme.headlineLarge),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sale id  ',style: Theme.of(context).textTheme.headlineLarge,),
                                Text('${offer.saleId} EGP',style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Trader  id  ',style: Theme.of(context).textTheme.headlineLarge,),
                                Text('${offer.traderUid} ',style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                            state.carForSale!.saleStatus=='Available'? ElevatedButton(onPressed: (){
                              BlocProvider.of<UserOffersBloc>(context).add(AcceptOfferEvent(offer));
                              //currentSale!.saleStatus=='Available'?acceptOffer(offer):null;
                            }, child:state.acceptOfferRequestState==RequestState.isLoading?CircularProgressIndicator(): Text('Accept offer')):SizedBox()
                          ],
                        ),
                      ),
                    );
                  });
            }


      }),
    );
  }

  Future<List<Offer>> fetchOffers() async {
    print('user id is $userUid');
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    // var docs2=await firestore
    //     .collection(BidsFireStoreConsts.offers).add({'Offer':'Data'}).then((value) {
    //    value.collection(collectionPath)
    // });

    var docs=await firestore
        .collection(BidsFireStoreConsts.offers).get().then((value)async {
          print('value is ${value.docs}');
      for(var doc in value.docs){

        var result =await firestore.collection(BidsFireStoreConsts.offers)
            .doc(doc.id)
            .collection(BidsFireStoreConsts.traderOffers)
            .where('userUid', isEqualTo: userUid)
            .get().then((value2)async {
          print('Doc valueeeeee ${value2.docs}');
          print('Doc valueeeeee ${value2.docs.map((e) => e.data())}');
         // offersList.add(OfferModel.fromFireBase(value2.docs.map((e) => e.data())));
          offersList.addAll(List<QueryDocumentSnapshot>.from(value2.docs).map((e) => OfferModel.fromFireBase(e.data())).toList());

        });

      }
    });

    // var docsData=docs.docs.where((element) => 'userUid'==userUid);
    // print('DocsData ${docsData}');
    //
    // await firestore
    //     .collection(BidsFireStoreConsts.offers).get().whenComplete(()async {
    //   docs.docs.forEach((element)async {
    //     print('el is ${element.data()}');
    //
    //     await firestore
    //         .collection(BidsFireStoreConsts.offers)
    //         .doc(element.id)
    //         .collection(BidsFireStoreConsts.traderOffers)
    //         .where('userUid', isEqualTo: userUid)
    //         .get()
    //         .then((value) {
    //       value.docs.forEach((element) {
    //         print('element is ${element.data()}');
    //
    //         offersList.add(OfferModel.fromFireBase(element.data()));
    //       });
    //     });
    //
    //   });
    // });

    // var insideDocs=await firestore.collection(BidsFireStoreConsts.traderOffers).where('userUid',isEqualTo:userUid ).get();


   // print('data is ${data}');
    return  await offersList;
  }
  Future<List<Offer>> fetchOffersForASale() async {
    print('user id is $userUid');
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    // var docs2=await firestore
    //     .collection(BidsFireStoreConsts.offers).add({'Offer':'Data'}).then((value) {
    //    value.collection(collectionPath)
    // });

    var docs=await firestore
        .collection(BidsFireStoreConsts.offers).get().then((value)async {
          print('value is ${value.docs}');
      for(var doc in value.docs){

        var result =await firestore.collection(BidsFireStoreConsts.offers)
            .doc(doc.id)
            .collection(BidsFireStoreConsts.traderOffers)
            .where('userUid', isEqualTo: userUid ).where('saleId',isEqualTo:saleId)
            .get().then((value2)async {
          print('Doc valueeeeee ${value2.docs.where((element) => element.data()['saleId']==saleId).map((e) => e.data()).toList()}');
  
          var desiredData=value2.docs;
          offersForSale.addAll(List<QueryDocumentSnapshot>.from(desiredData).map((e) => OfferModel.fromFireBase(e.data())).toList());

        });

      }
    });


    return  await offersForSale;
  }
  Future<void> acceptOffer(Offer offer)async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection(BidsFireStoreConsts.offers).doc(offer.traderUid).collection(BidsFireStoreConsts.traderOffers).doc(saleId).update({'offerStatus':'Accepted'}).whenComplete(()async {
      await firestore.collection(BidsFireStoreConsts.forSale).doc(offer.saleId).update({'saleStatus':'Not Available','soldAt':Timestamp.now()});
    });

  }
}
