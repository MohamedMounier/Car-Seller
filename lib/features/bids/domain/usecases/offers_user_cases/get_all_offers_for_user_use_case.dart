import 'package:dartz/dartz.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/bids/domain/entities/offer.dart';
import 'package:voomeg/features/bids/domain/repository/base_offers_repo.dart';

class GetAllOffersForUserUseCase extends BaseUseCases<List<Offer>,String>{
  final BaseOffersRepo baseOffersRepo;

  GetAllOffersForUserUseCase(this.baseOffersRepo);

  @override
  Future<Either<Failure, List<Offer>>> call(String userUid)async {
    return await baseOffersRepo.fetchAllUserOffers(userUid: userUid);
  }

}