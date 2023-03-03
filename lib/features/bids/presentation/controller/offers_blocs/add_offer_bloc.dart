import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';
import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';
import 'package:voomeg/features/bids/domain/entities/offer.dart';
import 'package:voomeg/features/bids/domain/usecases/get_user_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/offers_user_cases/add_offer_use_case.dart';

part 'add_offer_event.dart';

part 'add_offer_state.dart';

class AddOfferBloc extends Bloc<AddOfferEvent, AddOfferState> {
  AddOfferBloc(this.addOfferUSeCase, this.getUserUseCase)
      : super(AddOfferState()) {
    on<GetCurrentCarForSaleEvent>(onGetCurrentCarForSale);
    on<SendOfferEvent>(sendOfferEvent);
    on<GetSaleUserEvent>(onGetSaleUSer);
    on<GetCurrentTrader>(onGetCurrentTrader);
  }

  final AddOfferUSeCase addOfferUSeCase;
  final GetUserUseCase getUserUseCase;

  FutureOr<void> sendOfferEvent(
      SendOfferEvent event, Emitter<AddOfferState> emit) async {
    emit(state.copyWith(addOfferRequest: RequestState.isLoading));
    var result = await addOfferUSeCase(event.offer);
    result.fold(
        (l) => emit(state.copyWith(
            addOfferRequest: RequestState.isError,
            addOfferRequestErrorMessage: l.errorMessage)),
        (r) => emit(state.copyWith(
              addOfferRequest: RequestState.isSucc,
            )));
  }

  FutureOr<void> onGetCurrentCarForSale(
      GetCurrentCarForSaleEvent event, Emitter<AddOfferState> emit) {
    emit(state.copyWith(
        getCurrentCarState: RequestState.isLoading,
        carForSale: event.carForSale));
    if (state.carForSale != null) {
      emit(state.copyWith(
        getCurrentCarState: RequestState.isSucc,
      ));
    } else {
      emit(state.copyWith(
          getCurrentCarState: RequestState.isError,
          getCurrentCarErrorMessage: 'Sale is not currently available'));
    }
  }

  FutureOr<void> onGetSaleUSer(
      GetSaleUserEvent event, Emitter<AddOfferState> emit) async {
    print('Fetching User');
    emit (state.copyWith(getSaleUserState: RequestState.isLoading));
    var result = await getUserUseCase(GetUserUseCaseParameters(
        userId: event.userId, isTrader: false));
    result.fold(
        (l) => emit(state.copyWith(
            getSaleUserState: RequestState.isError,
            getSaleUserStateErrorMessage: l.errorMessage)),
        (r) =>  emit(state.copyWith(
            getSaleUserState: RequestState.isSucc,
            saleUser: r)));
  }

  FutureOr<void> onGetCurrentTrader(GetCurrentTrader event, Emitter<AddOfferState> emit) {

    emit(state.copyWith(currentTrader: event.currentTrader));
    print('Saved Trader is ${event.currentTrader}');
  }
}
