import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/auth/domain/entities/login.dart';
import 'package:voomeg/features/auth/domain/repository/base_user_repo.dart';

class LogUserInUseCase extends BaseUseCases<UserCredential,LoginEntity>{
  final BaseUserRepo userRepo;

  LogUserInUseCase(this.userRepo);
  @override
  Future<Either<Failure, UserCredential>> call(LoginEntity loginEntity)async {
  return await  userRepo.logUserIn(loginEntity: loginEntity);
  }

}