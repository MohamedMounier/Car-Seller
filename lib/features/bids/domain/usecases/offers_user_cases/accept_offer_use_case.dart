import 'package:dartz/dartz.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/bids/domain/entities/offer.dart';
import 'package:voomeg/features/bids/domain/repository/base_offers_repo.dart';

class AcceptOfferUseCase extends BaseUseCases<void,Offer>{
  final BaseOffersRepo baseOffersRepo;

   AcceptOfferUseCase(this.baseOffersRepo);

  @override
  Future<Either<Failure, void>> call(Offer offer)async {
   return await baseOffersRepo.acceptOffer(offer);
  }

}