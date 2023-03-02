part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();


}

class AddUserEvent extends RegisterEvent {
  final UserEntity user;

  const AddUserEvent(this.user);
  @override
  List<Object> get props => [];
}

class LoginSaveUserCheck extends RegisterEvent {
 final bool? checkSearch;

  const LoginSaveUserCheck(this.checkSearch);

  @override
  List<Object> get props => [checkSearch!];
}
class RegisterUserEvent extends RegisterEvent {
  final LoginEntity loginEntity;

  const RegisterUserEvent(this.loginEntity);

  @override
  List<Object> get props => [loginEntity];
}
class ChangeUserTypeEvent extends RegisterEvent {
  final bool isTrader;

  const ChangeUserTypeEvent(this.isTrader);

  @override
  List<Object> get props => [isTrader];
}
