import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/bids/domain/repository/base_car_for_sale_repo.dart';

class UploadImagesUSeCase extends BaseUseCases<Reference,UploadImageParameters> {
  final BaseCarForSaleRepo carForSaleRepo;

  UploadImagesUSeCase(this.carForSaleRepo);

  @override
  Future<Either<Failure, Reference>> call(UploadImageParameters parameters)async {
    return await carForSaleRepo.savingImageToFireStorage(image: parameters.image, saleId: parameters.saleId);

  }

}

class UploadImageParameters extends Equatable {
  final String saleId;
  final XFile image;

  UploadImageParameters(this.saleId, this.image);

  @override
  List<Object> get props => [saleId, image];

}