part of 'add_offer_bloc.dart';

@immutable
class AddOfferState {
  CarForSale? carForSale;
  Offer? currentOffer;
  UserEntity? saleUser;
  UserEntity? currentTrader;
  final RequestState getCurrentCarState;
  final RequestState addOfferRequest;
  final RequestState fetchAddedOfferState;
  final RequestState getSaleUserState;

  final String getCurrentCarErrorMessage;
  final String addOfferRequestErrorMessage;
  final String fetchAddedOfferStateErrorMessage;
  final String getSaleUserStateErrorMessage;


  AddOfferState({
    this.carForSale,
    this.currentTrader,
    this.saleUser,
    this.currentOffer,
    this.getCurrentCarState = RequestState.isNone,
    this.getSaleUserState = RequestState.isNone,
    this.addOfferRequest = RequestState.isNone,
    this.fetchAddedOfferState = RequestState.isNone,
    this.getCurrentCarErrorMessage = '',
    this.addOfferRequestErrorMessage = '',
    this.fetchAddedOfferStateErrorMessage = '',
    this.getSaleUserStateErrorMessage = ''
  });

  AddOfferState copyWith({
    CarForSale? carForSale,
    Offer? currentOffer,
    RequestState? getCurrentCarState,
    RequestState? addOfferRequest,
    RequestState? fetchAddedOfferState,
    RequestState? getSaleUserState,
    UserEntity? currentTrader,
    UserEntity? saleUser,

    String? getCurrentCarErrorMessage,
    String? addOfferRequestErrorMessage,
    String? fetchAddedOfferStateErrorMessage,
    String? getSaleUserStateErrorMessage,
  }) =>
      AddOfferState(
        carForSale: carForSale ?? this.carForSale,
        currentOffer: currentOffer ?? this.currentOffer,
        getCurrentCarState: getCurrentCarState ?? this.getCurrentCarState,
        addOfferRequest: addOfferRequest ?? this.addOfferRequest,
        fetchAddedOfferState: fetchAddedOfferState ?? this.fetchAddedOfferState,
        getSaleUserState: getSaleUserState ?? this.getSaleUserState,
        getCurrentCarErrorMessage: getCurrentCarErrorMessage ??
            this.getCurrentCarErrorMessage,
        saleUser: saleUser ?? this.saleUser,
        currentTrader: currentTrader ?? this.currentTrader,
        addOfferRequestErrorMessage: addOfferRequestErrorMessage ??
            this.addOfferRequestErrorMessage,
        getSaleUserStateErrorMessage:getSaleUserStateErrorMessage??this.getSaleUserStateErrorMessage,
        fetchAddedOfferStateErrorMessage: fetchAddedOfferStateErrorMessage ??
            this.fetchAddedOfferStateErrorMessage,);

  @override
  List<Object> get props =>
      [
        getCurrentCarState,
        addOfferRequest,
        fetchAddedOfferState,
        getSaleUserState,
        getCurrentCarErrorMessage,
        addOfferRequestErrorMessage,
        fetchAddedOfferStateErrorMessage,
        getSaleUserStateErrorMessage,
      ];
}
