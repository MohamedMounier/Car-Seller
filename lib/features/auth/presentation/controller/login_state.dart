part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final RequestState requestState;
  final String loginErrorMessage;
  final bool isUserSaved;
  final bool isPasswordVisible;
   final UserCredential? user;

  const LoginState({
    this.requestState = RequestState.isNone,
    this.loginErrorMessage = '',
    this.isUserSaved=false,
    this.isPasswordVisible=false,
    this.user
  });

  LoginState copyWith({
    RequestState? requestState,
    String? loginErrorMessage,
    bool? isUserSaved,
    UserCredential? user,
    bool? isPasswordVisible,
  }) =>
      LoginState(requestState: requestState ?? this.requestState,
          loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
        isUserSaved: isUserSaved??this.isUserSaved,
          user: user??this.user,
        isPasswordVisible: isPasswordVisible??this.isPasswordVisible,
      );

  @override
  List<Object> get props => [requestState, loginErrorMessage,isUserSaved,isPasswordVisible];
}

class LoginInitial extends LoginState {}
