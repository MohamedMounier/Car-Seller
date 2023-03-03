part of 'user_offers_bloc.dart';

@immutable
abstract class UserOffersEvent extends Equatable {

  const UserOffersEvent();

}

class GetCurrentSaleEvent extends UserOffersEvent {
  final CarForSale carForSale;

  GetCurrentSaleEvent(this.carForSale);

  @override
  List<Object> get props => [carForSale];
}

class FetchAllOffersEvent extends UserOffersEvent {
 final String userUid;

 FetchAllOffersEvent(this.userUid);

 @override
 List<Object> get props => [userUid];
}
class FetchOffersForCarEvent extends UserOffersEvent {
 final String userUid;
 final String saleId;

 FetchOffersForCarEvent(this.userUid,this.saleId);

 @override
 List<Object> get props => [userUid,saleId];
}

class AcceptOfferEvent extends UserOffersEvent {
  final Offer currentOffer;

  AcceptOfferEvent(this.currentOffer);

  @override
  List<Object> get props => [currentOffer];
}
