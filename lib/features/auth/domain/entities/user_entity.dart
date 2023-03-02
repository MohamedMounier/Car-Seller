import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  UserEntity(
      {required this.id,
      required this.name,
      required this.password,
      required this.email,
      required this.isTrader,
      required this.phone});

  final String id;
  final String name;
  final String password;
  final String email;
  final String phone;
  final bool isTrader;

  @override
  List<Object> get props => [id, name, password, email, phone];
}
