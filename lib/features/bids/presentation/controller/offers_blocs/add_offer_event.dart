part of 'add_offer_bloc.dart';

@immutable
abstract class AddOfferEvent extends Equatable {

   AddOfferEvent();

}
 class GetCurrentCarForSaleEvent extends AddOfferEvent {
   CarForSale? carForSale;

   GetCurrentCarForSaleEvent({this.carForSale});

  @override
  List<Object> get props => [];
}

class SendOfferEvent extends AddOfferEvent {
  final Offer offer;

  SendOfferEvent(this.offer);

  @override
  List<Object> get props => [offer];
}
class GetSaleUserEvent extends AddOfferEvent {
  final String userId;

  GetSaleUserEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
class GetCurrentTrader extends AddOfferEvent {
   final UserEntity currentTrader;

  GetCurrentTrader(this.currentTrader);

  @override
  List<Object> get props => [currentTrader];
}
