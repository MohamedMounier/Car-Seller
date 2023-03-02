import 'package:dartz/dartz.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/auth/domain/repository/base_user_repo.dart';

class LogOutUseCase extends BaseUseCases<void,NoParameters>{
  final BaseUserRepo baseUserRepo;

  LogOutUseCase(this.baseUserRepo);

  @override
  Future<Either<Failure, void>> call(NoParameters parameters) async{
 return  await baseUserRepo.logUserOut();
  }

}