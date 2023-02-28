import 'package:dartz/dartz.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';
import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';
import 'package:voomeg/features/bids/domain/repository/base_car_for_sale_repo.dart';

class AddCarToDatabaseUseCase extends BaseUseCases<void,CarForSale>{
  final BaseCarForSaleRepo baseCarForSaleRepo;

  AddCarToDatabaseUseCase(this.baseCarForSaleRepo);
  @override
  Future<Either<Failure, void>> call(CarForSale car)async {
   return await baseCarForSaleRepo.addCar(car);
  }

}