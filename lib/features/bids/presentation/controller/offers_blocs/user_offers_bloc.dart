import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';
import 'package:voomeg/features/bids/domain/entities/offer.dart';
import 'package:voomeg/features/bids/domain/usecases/offers_user_cases/accept_offer_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/offers_user_cases/get_all_offers_for_user_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/offers_user_cases/get_offers_for_car_use_case.dart';

part 'user_offers_event.dart';
part 'user_offers_state.dart';

class UserOffersBloc extends Bloc<UserOffersEvent, UserOffersState> {

  UserOffersBloc(this.getOffersForCarUseCase, this.getAllOffersForUserUseCase, this.acceptOfferUseCase) : super(UserOffersState()) {
    on<FetchOffersForCarEvent>(onFetchOffersForCar);
    on<GetCurrentSaleEvent>(onGetCurrentSale);
    on<AcceptOfferEvent>(onAcceptOffer);
  }
  final GetOffersForCarUseCase getOffersForCarUseCase;
  final GetAllOffersForUserUseCase getAllOffersForUserUseCase;
  final AcceptOfferUseCase acceptOfferUseCase;


  FutureOr<void> onFetchOffersForCar(FetchOffersForCarEvent event, Emitter<UserOffersState> emit)async {
    emit(state.copyWith(getOffersForCarRequestState: RequestState.isLoading));
    var result = await getOffersForCarUseCase(GetOffersForCarUseCaseParameters(event.userUid, event.saleId));
    result.fold((l) => emit(state.copyWith(getOffersForCarRequestState:RequestState.isError,
    getOffersForCarErrorMessage: l.errorMessage,
    )), (r) => emit(state.copyWith(getOffersForCarRequestState:RequestState.isSucc,
      carOffers: r,
    )));
  }



  FutureOr<void> onGetCurrentSale(GetCurrentSaleEvent event, Emitter<UserOffersState> emit) {
    state.carForSale= event.carForSale;
    state.userUid= event.carForSale.userId;
//    emit(state.copyWith(userUid: event.carForSale.userId,carForSale: event.carForSale));
  }

  FutureOr<void> onAcceptOffer(AcceptOfferEvent event, Emitter<UserOffersState> emit)async {
    emit (state.copyWith(acceptOfferRequestState: RequestState.isLoading));
    var result = await acceptOfferUseCase(event.currentOffer);
    result.fold((l) => emit(state.copyWith(acceptOfferRequestState: RequestState.isError,acceptOfferErrorMessage: l.errorMessage)), (r) => emit(state.copyWith(acceptOfferRequestState: RequestState.isSucc)));
  }
}
