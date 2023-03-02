part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final RequestState requestState;
  final LoginSteps loginSteps;
  final String loginErrorMessage;
  final bool isUserSaved;
  final bool isPasswordVisible;
   final UserCredential? user;
    String? userUid;
   bool isTrader;

   LoginState({
    this.requestState = RequestState.isNone,
    this.loginSteps = LoginSteps.isNone,
    this.loginErrorMessage = '',
    this.userUid = '',
    this.isUserSaved=false,
    this.isPasswordVisible=false,
    this.isTrader=false,
    this.user
  });

  LoginState copyWith({
    RequestState? requestState,
    LoginSteps? loginSteps,
    String? loginErrorMessage,
    bool? isUserSaved,
    UserCredential? user,
    bool? isPasswordVisible,
    bool? isTrader,
    String? userUid,
  }) =>
      LoginState(requestState: requestState ?? this.requestState,
        loginSteps: loginSteps ?? this.loginSteps,
          loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
        isUserSaved: isUserSaved??this.isUserSaved,
          user: user??this.user,
        isPasswordVisible: isPasswordVisible??this.isPasswordVisible,
        isTrader: isTrader??this.isTrader,
        userUid: userUid??this.userUid,
      );

  @override
  List<Object> get props => [requestState, loginErrorMessage,isUserSaved,loginSteps,isTrader,isPasswordVisible,userUid!];
}

class LoginInitial extends LoginState {}
