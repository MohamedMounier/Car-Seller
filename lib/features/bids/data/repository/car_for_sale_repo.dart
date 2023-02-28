import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/features/bids/data/datasource/remote_bids_data_source.dart';
import 'package:voomeg/features/bids/data/models/car_for_sale_model.dart';
import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';
import 'package:voomeg/features/bids/domain/repository/base_car_for_sale_repo.dart';

class CarForSaleRepo implements BaseCarForSaleRepo {
  final BaseBidsRemoteDataSource baseBidsRemoteDataSource;

  CarForSaleRepo(this.baseBidsRemoteDataSource);

  @override
  Future<Either<Failure, void>> addCar(CarForSale car) async {
    try {
      var result = await baseBidsRemoteDataSource.addCar(CarForSaleModel(
          saleId: car.saleId,
          userId: car.userId,
          carName: car.carName,
          carModel: car.carModel,
          carKilos: car.carKilos,
          carLocation: car.carLocation,
          saleStatus:car.saleStatus,
          createdAt: car.createdAt,
          soldAt: car.soldAt,
          photosUrls:car. photosUrls));
      return Right(result);
    } on FirebaseException catch (error) {
      return Left(ServerFailure(error.message ?? "error"));
    }
  }



  @override
  Future<Either<Failure, String>> getUploadedImageUrl(
      {required Reference reference}) async {
    try {
      var result = await baseBidsRemoteDataSource.getUploadedImageUrl(
          reference: reference);
      return Right(result);
    } on FirebaseException catch (error) {
      return Left(ServerFailure(error.message ?? "error"));
    }
  }

  @override
  Future<Either<Failure, List<CarForSaleModel>>> getUserCarsForSale() async {
    try {
      var result = await baseBidsRemoteDataSource.getUserCarsForSale();
      return Right(result);
    } on FirebaseException catch (error) {
      return Left(ServerFailure(error.message ?? "error"));
    }
  }

  @override
  Future<Either<Failure, Reference>> savingImageToFireStorage(
      {required XFile image, required String saleId}) async {
    try {
      var result = await baseBidsRemoteDataSource.savingImageToFireStorage(
          image: image, saleId: saleId);
      return Right(result);
    } on FirebaseException catch (error) {
      return Left(ServerFailure(error.message ?? "error"));
    }
  }
}
