import 'package:dartz/dartz.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/auth/domain/entities/login.dart';
import 'package:voomeg/features/auth/domain/repository/base_user_repo.dart';

class LogUserInUseCase extends BaseUseCases<void,LoginEntity>{
  final BaseUserRepo userRepo;

  LogUserInUseCase(this.userRepo);
  @override
  Future<Either<Failure, void>> call(LoginEntity loginEntity)async {
  return await  userRepo.logUserIn(loginEntity: loginEntity);
  }

}