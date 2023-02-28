import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String email;

  LoginEntity({required this.email,required this.password});

  final String password;

  @override
  List<Object> get props => [email, password];
}