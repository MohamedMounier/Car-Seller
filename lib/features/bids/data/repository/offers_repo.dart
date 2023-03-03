import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/features/bids/data/datasource/remote_bids_data_source.dart';
import 'package:voomeg/features/bids/data/models/offer_model.dart';
import 'package:voomeg/features/bids/domain/entities/offer.dart';
import 'package:voomeg/features/bids/domain/repository/base_offers_repo.dart';

class OffersRepo implements BaseOffersRepo {
  final BaseBidsRemoteDataSource baseBidsRemoteDataSource;

  OffersRepo(this.baseBidsRemoteDataSource);

  @override
  Future<Either<Failure,void>> addOffer(Offer offer) async {
    try {
      var result = await baseBidsRemoteDataSource.addOffer(OfferModel(
          saleId: offer.saleId,
          offerId: offer.offerId,
          userUid: offer.userUid,
          userName: offer.userName,
          traderUid: offer.traderUid,
          traderName: offer.traderName,
          offerStatus: offer.offerStatus,
          price: offer.price));
      return Right(result);
    } on FirebaseException catch (error) {
      return Left(ServerFailure(error.message ?? "error"));
    }
  }

  @override
  Future<Either<Failure, void>> acceptOffer(Offer offer)async {
    try {
      var result = await baseBidsRemoteDataSource.acceptOffer(OfferModel(
          saleId: offer.saleId,
          offerId: offer.offerId,
          userUid: offer.userUid,
          userName: offer.userName,
          traderUid: offer.traderUid,
          traderName: offer.traderName,
          offerStatus: offer.offerStatus,
          price: offer.price));
      return Right(result);
    } on FirebaseException catch (error) {
      return Left(ServerFailure(error.message ?? "error"));
    }catch (error){
      return Left(ServerFailure(error.toString() ));

    }
  }

  @override
  Future<Either<Failure, List<Offer>>> fetchAllUserOffers({required String userUid})async {
    try {
      var result = await baseBidsRemoteDataSource.fetchAllUserOffers(userUid: userUid);
      return Right(result);
    } on FirebaseException catch (error) {
      return Left(ServerFailure(error.message ?? "error"));
    }catch (error){
      return Left(ServerFailure(error.toString() ));

    }
  }

  @override
  Future<Either<Failure, List<Offer>>> fetchOffersForOneCar({required String userUid, required String saleId})async {
    try {
      var result = await baseBidsRemoteDataSource.fetchOffersForOneCar(userUid: userUid, saleId: saleId);
      return Right(result);
    } on FirebaseException catch (error) {
      return Left(ServerFailure(error.message ?? "error"));
    }catch (error){
      return Left(ServerFailure(error.toString()));

    }
  }




}
