import 'package:dartz/dartz.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';
import 'package:voomeg/features/auth/domain/repository/base_user_repo.dart';

class AddUserUseCase extends BaseUseCases <void,UserEntity>{
  AddUserUseCase(this.userRepo);

  final BaseUserRepo userRepo;
  @override
  Future<Either<Failure, void>> call(UserEntity user)async {
   return await userRepo.addUser(user);
  }

}