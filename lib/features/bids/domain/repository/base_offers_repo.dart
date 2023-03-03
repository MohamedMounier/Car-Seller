import 'package:dartz/dartz.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/features/bids/domain/entities/offer.dart';

abstract class BaseOffersRepo {
  Future<Either<Failure,void>> addOffer(Offer offer);
  Future<Either<Failure,List<Offer>>> fetchAllUserOffers({required String userUid});
  Future<Either<Failure,List<Offer>>> fetchOffersForOneCar({required String userUid,required String saleId});
  Future<Either<Failure,void>> acceptOffer(Offer offer);


  }