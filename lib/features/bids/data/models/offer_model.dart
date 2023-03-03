import 'package:voomeg/core/global/resources/strings_manager.dart';
import 'package:voomeg/features/bids/domain/entities/offer.dart';

class OfferModel extends Offer {
  OfferModel(
      {required super.saleId,
      required super.offerId,
      required super.userUid,
      required super.userName,
      required super.traderUid,
      required super.traderName,
      required super.offerStatus,
      required super.price});

 factory OfferModel.fromFireBase(dynamic docData)=>OfferModel(
     userUid: docData['userUid'],
     saleId: docData['saleId'],
     offerId: docData['offerId'],
     offerStatus: docData['offerStatus'],
     price: docData['price'],
     traderName: docData['traderName'],
     traderUid: docData['traderUid'],
     userName: docData['userName'],
 );

 toFireStore()=>{
     'saleId':this.saleId,
     'traderUid':this.traderUid,
     'traderName':this.traderName,
     'offerStatus':this.offerStatus,
     'offerId':this.offerId,
     'price':this.price,
     'userName':this.userName,
     'userUid':this.userUid,
 };
}
