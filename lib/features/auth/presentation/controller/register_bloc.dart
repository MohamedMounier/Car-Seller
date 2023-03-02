import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/features/auth/domain/entities/login.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';
import 'package:voomeg/features/auth/domain/usecases/add_user_use_case.dart';
import 'package:voomeg/features/auth/domain/usecases/register_user_use_case.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUseCase registerUserUseCase;
  final AddUserUseCase addUserUseCase;


  RegisterBloc(this.registerUserUseCase,this.addUserUseCase) : super(RegisterState()) {
    on<RegisterUserEvent>(onRegisterUSer);
    on<AddUserEvent>(onAddUser);
    on<ChangeUserTypeEvent>(onChangeUserType);
  }


  FutureOr<void> onRegisterUSer(
      RegisterUserEvent event, Emitter<RegisterState> emit) async {
   emit(state.copyWith(requestState: RequestState.isLoading));
    final result = await registerUserUseCase(event.loginEntity);
    result.fold(
            (l) => emit(state.copyWith(
            registerErrorMessage: l.errorMessage,requestState: RequestState.isError,registerStep: RegisterSteps.isNotRegistered)),
            (r) => emit(state.copyWith(requestState: RequestState.isSucc,user: r,registerStep: RegisterSteps.isRegistered)));
  }

  FutureOr<void> onAddUser(AddUserEvent event, Emitter<RegisterState> emit)async {
   emit(state.copyWith(requestState: RequestState.isLoading));
    final result = await addUserUseCase(event.user);
    result.fold(
            (l) => emit(state.copyWith(
            registerErrorMessage: l.errorMessage,requestState: RequestState.isError,registerStep: RegisterSteps.isNotAddedUser)),
            (r) => emit(state.copyWith(requestState: RequestState.isSucc,registerStep: RegisterSteps.isAddedUser)));
  }
  FutureOr<void> onChangeUserType(ChangeUserTypeEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isTrader: event.isTrader,requestState: RequestState.isNone));
  }
}
