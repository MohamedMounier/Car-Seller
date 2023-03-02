import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/auth/data/repository/user_repo.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';
import 'package:voomeg/features/auth/domain/repository/base_user_repo.dart';

class GetUserUseCase extends BaseUseCases<UserEntity,GetUserUseCaseParameters> {
  final BaseUserRepo userRepo;

  GetUserUseCase(this.userRepo);

  @override
  Future<Either<Failure, UserEntity>> call(GetUserUseCaseParameters parameters)async {
   return await userRepo.getUser(userId: parameters.userId, isTrader: parameters.isTrader);
  }
}

class GetUserUseCaseParameters extends Equatable {
  final String userId;
  final bool isTrader;

  GetUserUseCaseParameters({required this.userId,required this.isTrader});

  @override
  List<Object> get props => [userId, isTrader];
}