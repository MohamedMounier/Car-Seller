import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/features/auth/data/models/user_model.dart';
import 'package:voomeg/features/auth/domain/entities/login.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';

abstract class BaseUserRepo {
 Future<Either<Failure,UserEntity>> getUser();
 Future<Either<Failure,UserCredential>>logUserIn({required LoginEntity loginEntity});
  Future<Either<Failure,void>>logUserOut();
 Future<Either<Failure,UserCredential>> createUser({required LoginEntity loginEntity});
 Future<Either<Failure,void>>addUser(UserEntity userEntity);

}