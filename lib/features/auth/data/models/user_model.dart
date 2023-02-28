import 'package:voomeg/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id, required super.name, required super.password, required super.email, required super.phone});

  factory UserModel.fromFireBase(dynamic doc)=>
      UserModel(
          id: doc['id'],
          name: doc['name'],
          password: doc['password'],
          email: doc['email'],
          phone: doc['phone']);

   toFireBase()=>{
    'id':this.id,
    'name':this.name,
    'password':this.password,
    'email':this.email,
    'phone':this.phone,
  };
}