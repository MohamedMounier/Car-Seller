import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/core/utils/services/app_prefrences.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';
import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';
import 'package:voomeg/features/bids/domain/usecases/get_available_cars_for_sale_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/get_user_cars_for_sale_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/get_user_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/log_out_use_case.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
      this.appPrefrences,
      this.getUserCarsForSalesUseCase,
      this.getAvailableCarsForSaleUseCase,
      this.getUserUseCase,
      this.logOutUseCase)
      : super(HomeState()) {
    on<ChangePageEvent>(onChangePage);
    on<FetchUserUidEvent>(onFetchUserUid);
    on<FetchUserTypeEvent>(onFetchUserType);
    on<FetchUserCarsForSale>(onFetchUserCarsForSale);
    on<FetchUserEvent>(onFetchUser);
    on<LogOutEvent>(onLogOutUser);
    on<ResetUserTypeEvent>(onResetUserType);
    on<ResetUserUidEvent>(onResetUserEvent);
    on<ResetHomeDataEvent>(onResetHomeData);
  }

  final AppPreferences appPrefrences;
  final GetUserCarsForSalesUseCase getUserCarsForSalesUseCase;
  final GetAvailableCarsForSaleUseCase getAvailableCarsForSaleUseCase;
  final GetUserUseCase getUserUseCase;
  final LogOutUseCase logOutUseCase;

  FutureOr<void> onChangePage(ChangePageEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentNavBarIndex: event.pageIndex,requestState: RequestState.isNone,step: HomeScreenDataSteps.isNone));
  }

  FutureOr<void> onFetchUserUid(
      FetchUserUidEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
        requestState: RequestState.isLoading,
        step: HomeScreenDataSteps.isFetchingUserUid));
    var result = await appPrefrences.getUserID();
    result.fold((l) {
      emit(state.copyWith(
          errorMessage: l.errorMessage,
          requestState: RequestState.isLoading,
          step: HomeScreenDataSteps.isFetchingUserUidError));
    }, (r) {
      emit(state.copyWith(
          step: HomeScreenDataSteps.isFetchingUserUidSucc,
          requestState: RequestState.isSucc,
          userUid: r));
    });
  }

  FutureOr<void> onGetTry(
      FetchUserUidEvent event, Emitter<HomeState> emit) async {
    /*

   print('Result by doc  ${list2}');
   var result5= await FirebaseFirestore.instance.collection("sales").get();
   result5.docs.where((element) => element.data()=="1234")
    */
  }

  FutureOr<void> onFetchUserCarsForSale(
      FetchUserCarsForSale event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
        requestState: RequestState.isLoading,
        step: HomeScreenDataSteps.isFetchingCars));
    if (!state.isTrader) {
      var result = await getUserCarsForSalesUseCase(state.userUid);
      result.fold(
          (l) => emit(state.copyWith(
              requestState: RequestState.isError,
              errorMessage: l.errorMessage)),
          (r) => emit(state.copyWith(
              requestState: RequestState.isSucc,
              step: HomeScreenDataSteps.isFetchingCarsSucc,
              carsForSaleList: r)));
    } else {
      var result = await getAvailableCarsForSaleUseCase(const NoParameters());
      result.fold(
          (l) => emit(state.copyWith(
              requestState: RequestState.isError,
              errorMessage: l.errorMessage,
              step: HomeScreenDataSteps.isFetchingCarsError)),
          (r) => emit(state.copyWith(
              requestState: RequestState.isSucc,
              step: HomeScreenDataSteps.isFetchingCarsSucc,
              carsForSaleList: r)));
    }
  }

  FutureOr<void> onFetchUserType(
      FetchUserTypeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      currentNavBarIndex: 0,
        requestState: RequestState.isLoading,
        step: HomeScreenDataSteps.isFetchingUserType));

    var result = await appPrefrences.isTypeTrader();
    if (result != null) {
      emit(state.copyWith(
          requestState: RequestState.isSucc,
          isTrader: false,
          step: HomeScreenDataSteps.isFetchingUserTypeSucc));
    } else {
      emit(state.copyWith(
          requestState: RequestState.isError,
          isTrader: result,
          step: HomeScreenDataSteps.isFetchingUserTypeError));

      //TODO log out the user
    }
  }

  FutureOr<void> onFetchUser(
      FetchUserEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(requestState: RequestState.isLoading,
        step: HomeScreenDataSteps.isFetchingUserInfo,
      isTrader: appPrefrences.isTypeTrader(),
      userUid: appPrefrences.fetchSavedUserUid()
    ));

    final result = await getUserUseCase(GetUserUseCaseParameters(
      userId: state.userUid,
      isTrader: state.isTrader,
    ));
    result.fold(
        (l) => emit(state.copyWith(
            requestState: RequestState.isError, errorMessage: l.errorMessage,
          step: HomeScreenDataSteps.isFetchingUserInfoError
        )),
        (r) {
          print('user uid is ${state.userUid} ');
          print('user type trader?  is ${state.isTrader} ');
          emit(
              state.copyWith(currentUser: r, requestState: RequestState.isSucc,
                  step: HomeScreenDataSteps.isFetchingUserInfoSucc

              ));
        });

  }

  FutureOr<void> onLogOutUser(LogOutEvent event, Emitter<HomeState> emit)async {
    emit(state.copyWith(requestState: RequestState.isLoading,localDataStats: LocalDataStats.isLoggingOut,step:HomeScreenDataSteps.isNone));
    final result=await logOutUseCase(const NoParameters());

    result.fold((l) =>
        emit(state.copyWith(
            requestState: RequestState.isError, errorMessage: l.errorMessage,step:HomeScreenDataSteps.isNone,localDataStats: LocalDataStats.isLoggedOutError)),
            (r) => emit(state.copyWith(
                requestState: RequestState.isSucc,localDataStats: LocalDataStats.isLoggedOutSucc,step:HomeScreenDataSteps.isNone)));

  }

  FutureOr<void> onResetUserType(ResetUserTypeEvent event, Emitter<HomeState> emit)async {
    emit (state.copyWith(localDataStats: LocalDataStats.isResetingType));
    var result = await appPrefrences.saveUserType(false);
    result.fold((l) {
      emit(state.copyWith(requestState:RequestState.isError,errorMessage: l.errorMessage,localDataStats: LocalDataStats.isResetingTypeError));
    }, (r) {
      if(r)
      emit(state.copyWith(isTrader: false,requestState: RequestState.isSucc,localDataStats: LocalDataStats.isResetingTypeSucc));
    });
    print('Saved User Type is Trader?${appPrefrences.isTypeTrader()}');
    print('Saved User Type is Trader?${state.isTrader}');
  }



  FutureOr<void> onResetUserEvent(ResetUserUidEvent event, Emitter<HomeState> emit)async {
    emit(state.copyWith(localDataStats: LocalDataStats.isRemovingUid));
    final resetUserId= await appPrefrences.removeUserUid();
    resetUserId.fold((l) => emit(state.copyWith(
        requestState: RequestState.isError, errorMessage: l.errorMessage,localDataStats: LocalDataStats.isRemovedUidError)),(r) => emit(state.copyWith(
        requestState: RequestState.isSucc,localDataStats: LocalDataStats.isRemovedUidSucc,currentUser: null,step:HomeScreenDataSteps.isNone)));
  }

  FutureOr<void> onResetHomeData(ResetHomeDataEvent event, Emitter<HomeState> emit) {
    //state.currentNavBarIndex=0;
    emit(state.copyWith(requestState: RequestState.isNone,isTrader: false));
  }
}
