import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/utils/services/app_prefrences.dart';
import 'package:voomeg/core/utils/services/service_locator.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppPrefrences appPrefrences;
  HomeBloc(this.appPrefrences) : super(HomeState()) {
    on<ChangePageEvent>(onChangePage);
    on<FetchUserEvent>(onFetchUserUid);

  }



  FutureOr<void> onChangePage(ChangePageEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith( currentNavBarIndex: event.pageIndex));
  }
  FutureOr<void> onFetchUserUid(FetchUserEvent event, Emitter<HomeState> emit)async {
    var result = await appPrefrences.getUserID();
    result.fold((l) {
      emit(state.copyWith(errorMessage: l.errorMessage,fetchUidRequestState: RequestState.isError));
    }, (r) {
      emit(state.copyWith(fetchUidRequestState:RequestState.isSucc,userUid: r));

    });
  }

}
