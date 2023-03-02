part of 'register_bloc.dart';

@immutable
class RegisterState extends Equatable {
  final RequestState requestState;
  final RegisterSteps registerStep;
  final String loginErrorMessage;
  final bool isUserSaved;
   bool isTrader;
   UserCredential? user;

   RegisterState({
    this.requestState = RequestState.isNone,
    this.registerStep = RegisterSteps.isNone,
    this.loginErrorMessage = '',
    this.isUserSaved=false,
    this.isTrader=false,
    this.user
  });

  RegisterState copyWith({
    RequestState? requestState,
    RegisterSteps? registerStep,
    String? registerErrorMessage,
    bool? isUserSaved,
    bool? isTrader,
    UserCredential? user
  }) =>
      RegisterState(requestState: requestState ?? this.requestState,
          loginErrorMessage: registerErrorMessage ?? this.loginErrorMessage,
          isUserSaved: isUserSaved??this.isUserSaved,
          registerStep: registerStep??this.registerStep,
          user: user??this.user,
        isTrader: isTrader??this.isTrader,
      );

  @override
  List<Object> get props => [requestState, loginErrorMessage,isUserSaved,registerStep,isTrader];
}

