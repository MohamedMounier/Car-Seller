part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

}

class LoginEventLogUserIn extends LoginEvent {
  final LoginEntity loginEntity;

  const LoginEventLogUserIn(this.loginEntity);

  @override
  List<Object> get props => [loginEntity];
}

class LoginSaveUserCheck extends LoginEvent {
  bool? checkSearch;

  LoginSaveUserCheck(this.checkSearch);

  @override
  List<Object> get props => [checkSearch!];
}
class ShowPasswordEvent extends LoginEvent {
  bool? isPasswordVisible;

  ShowPasswordEvent(this.isPasswordVisible);

  @override
  List<Object> get props => [isPasswordVisible!];
}
class RememberMeEvent extends LoginEvent {
  bool? isRememberUser;

  RememberMeEvent(this.isRememberUser);

  @override
  List<Object> get props => [isRememberUser!];
}
class RegisterUserEvent extends LoginEvent {
  final LoginEntity loginEntity;

  RegisterUserEvent(this.loginEntity);

  @override
  List<Object> get props => [loginEntity];
}
