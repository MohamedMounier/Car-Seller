import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/bids/domain/repository/base_car_for_sale_repo.dart';

class GetImageUrlUseCase extends BaseUseCases<String,Reference>{
  final BaseCarForSaleRepo baseCarForSaleRepo;
  GetImageUrlUseCase(this.baseCarForSaleRepo);

  @override
  Future<Either<Failure, String>> call(Reference reference)async {
   return await baseCarForSaleRepo.getUploadedImageUrl(reference: reference);
  }

}