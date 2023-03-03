import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/bids/domain/entities/offer.dart';
import 'package:voomeg/features/bids/domain/repository/base_offers_repo.dart';

class GetOffersForCarUseCase extends BaseUseCases<List<Offer>, GetOffersForCarUseCaseParameters> {
  final BaseOffersRepo baseOffersRepo;

  GetOffersForCarUseCase(this.baseOffersRepo);

  @override
  Future<Either<Failure, List<Offer>>> call(GetOffersForCarUseCaseParameters parameters)async {
   return await baseOffersRepo.fetchOffersForOneCar(userUid: parameters.userUid, saleId: parameters.saleId);
  }


}

class GetOffersForCarUseCaseParameters extends Equatable {
  final String userUid;
  final String saleId;

  GetOffersForCarUseCaseParameters(this.userUid, this.saleId);

  @override
  List<Object> get props => [userUid, saleId];
}