import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/src/auth_credential.dart';
import 'package:voomeg/core/error/error_models/error_message_model.dart';
import 'package:voomeg/core/error/exceptions.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/features/auth/data/datasource/user_data_source.dart';
import 'package:voomeg/features/auth/data/models/login_model.dart';
import 'package:voomeg/features/auth/data/models/user_model.dart';
import 'package:voomeg/features/auth/domain/entities/login.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';
import 'package:voomeg/features/auth/domain/repository/base_user_repo.dart';

class UserRepo implements BaseUserRepo {
  UserRepo(this.baseUserRemoteDataSorce);

  final BaseUserRemoteDataSorce baseUserRemoteDataSorce;

  @override
  Future<Either<Failure, void>> addUser(UserEntity user) async {

    try {
      var result = await baseUserRemoteDataSorce.addUser(UserModel(
          id: user.id,
          name: user.name,
          password: user.password,
          email: user.email,
          phone: user.phone));
      return Right(result);
    }  on FirebaseException catch ( error){
      return Left(ServerFailure(error.message??'error')  );
    }
  }

  @override
  Future<Either<Failure, UserCredential>> createUser(
      {required LoginEntity loginEntity}) async {


      try {
        var result = await baseUserRemoteDataSorce.createUser(
            email: loginEntity.email, password: loginEntity.password);

      return  Right( result);
    } on FirebaseException catch (authError) {
        print('Error heeere repo');
      return Left(ServerFailure(authError.message??'error')  );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logUserIn(
      {required LoginEntity loginEntity}) async {
    try {
      return Right(await baseUserRemoteDataSorce.logUserIn(
          loginModel: LoginModel(
              email: loginEntity.email, password: loginEntity.password)));
    } on FirebaseAuthException catch (authError) {
      return Left(ServerFailure(authError.message??'Error'));
    }catch (error){
      return Left(ServerFailure(error.toString()) );
    }
  }

  @override
  Future<Either<Failure, void>> logUserOut() async {
    try {
      return Right(await baseUserRemoteDataSorce.logUserOut());
    } on FirebaseAuthException catch (authError) {
      return Left(ServerFailure(authError.message??'Error'));
    }catch (error){
      return Left(ServerFailure(error.toString()));
    }
  }
}
