import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/auth/domain/entities/login.dart';
import 'package:voomeg/features/auth/domain/repository/base_user_repo.dart';

class RegisterUserUseCase implements BaseUseCases<UserCredential , LoginEntity>{
  RegisterUserUseCase(this.baseUserRepo);

  final BaseUserRepo baseUserRepo;
  @override
  Future<Either<Failure, UserCredential>> call(loginEntity)async {
  return  await baseUserRepo.createUser(loginEntity: loginEntity);
  }

}