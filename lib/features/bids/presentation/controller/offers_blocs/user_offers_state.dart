part of 'user_offers_bloc.dart';

class UserOffersState extends Equatable {
  CarForSale? carForSale;
  List<Offer>? allOffers;
  List<Offer>? carOffers;
  final RequestState getAllOffersRequestState;
  final RequestState getOffersForCarRequestState;
  final RequestState acceptOfferRequestState;
  Offer? CurrentOffer;
  String userUid;
  final String getAllOffersErrorMessage;
  final String getOffersForCarErrorMessage;
  final String acceptOfferErrorMessage;


  UserOffersState({
    this.carForSale, this.allOffers = const[], this.carOffers = const[
    ], this.CurrentOffer, this.userUid = '',
    this.acceptOfferErrorMessage = '',
    this.getAllOffersErrorMessage = '',
    this.getOffersForCarErrorMessage = '',
    this.acceptOfferRequestState = RequestState.isNone,
    this.getAllOffersRequestState = RequestState.isNone,
    this.getOffersForCarRequestState = RequestState.isNone,
  });

  UserOffersState copyWith({
    CarForSale? carForSale,
    List<Offer>? allOffers,
    List<Offer>? carOffers,
    Offer? CurrentOffer,
    String? userUid,
    String? acceptOfferErrorMessage,
    String? getAllOffersErrorMessage,
    String? getOffersForCarErrorMessage,
    RequestState? acceptOfferRequestState,
    RequestState? getAllOffersRequestState,
    RequestState? getOffersForCarRequestState,
  }) =>
      UserOffersState(
        allOffers: allOffers ?? this.allOffers,
        carOffers: carOffers ?? this.carOffers,
        CurrentOffer: CurrentOffer ?? this.CurrentOffer,
        carForSale: carForSale ?? this.carForSale,
        userUid: userUid ?? this.userUid,
        acceptOfferErrorMessage: acceptOfferErrorMessage ?? this.acceptOfferErrorMessage,
        getAllOffersErrorMessage: getAllOffersErrorMessage ?? this.getAllOffersErrorMessage,
        getOffersForCarErrorMessage: getOffersForCarErrorMessage ?? this.getOffersForCarErrorMessage,
        acceptOfferRequestState: acceptOfferRequestState ?? this.acceptOfferRequestState,
        getAllOffersRequestState: getAllOffersRequestState ?? this.getAllOffersRequestState,
        getOffersForCarRequestState: getOffersForCarRequestState ?? this.getOffersForCarRequestState,

      );


  @override
  List<Object> get props =>
      [
        getAllOffersRequestState,
        getOffersForCarRequestState,
        acceptOfferRequestState,
        getAllOffersErrorMessage,
        getOffersForCarErrorMessage,
        acceptOfferErrorMessage,
      ];
}

