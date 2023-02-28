import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';

abstract class BaseCarForSaleRepo {



  Future<Either<Failure,void>> addCar(CarForSale car);
  Future<Either<Failure,Reference>> savingImageToFireStorage({required XFile image,required String saleId});
  Future<Either<Failure,String>> getUploadedImageUrl({required Reference reference});
  Future<Either<Failure,List<CarForSale>>>getUserCarsForSale();

}