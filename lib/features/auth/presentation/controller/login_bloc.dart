import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/utils/services/app_prefrences.dart';
import 'package:voomeg/features/auth/domain/entities/login.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';
import 'package:voomeg/features/auth/domain/usecases/log_user_in_use_case.dart';
import 'package:voomeg/features/auth/domain/usecases/register_user_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterUserUseCase registerUserUseCase;
  final LogUserInUseCase logUserInUseCase;
  final AppPrefrences appPrefrences;

  LoginBloc(this.registerUserUseCase,this.logUserInUseCase,this.appPrefrences) : super(LoginState()) {
    on<LoginEventLogUserIn>(onLogin);
    on<LoginSaveUserCheck>(onSaveLogin);
    on<RememberMeEvent>(onChangeRememberMe);
    on<ShowPasswordEvent>(onShowPassword);
  }

  FutureOr<void> onLogin(LoginEventLogUserIn event, Emitter<LoginState> emit)async {
    emit(state.copyWith(requestState: RequestState.isLoading));
    final result = await logUserInUseCase(event.loginEntity);
    result.fold(
            (l) => emit(state.copyWith(
            loginErrorMessage: l.errorMessage,requestState: RequestState.isError)),
            (r) => emit(state.copyWith(requestState: RequestState.isSucc)));
  }

  FutureOr<void> onSaveLogin(LoginSaveUserCheck event, Emitter<LoginState> emit)async {
    var result = await appPrefrences.saveLogin(event.checkSearch!);
    result.fold((l) {
      emit(state.copyWith(loginErrorMessage: l.errorMessage));
    }, (r) {
      emit(state.copyWith(isUserSaved: event.checkSearch));

    });
  }


  FutureOr<void> onShowPassword(ShowPasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordVisible: event.isPasswordVisible =!event.isPasswordVisible!));
  }

  FutureOr<void> onChangeRememberMe(RememberMeEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isUserSaved: event.isRememberUser));
  }
}



