import 'package:dartz/dartz.dart';
import 'package:voomeg/core/error/failure.dart';
import 'package:voomeg/core/usecases/base_usecases.dart';

import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';
import 'package:voomeg/features/bids/domain/repository/base_car_for_sale_repo.dart';

class GetUserCarsForSalesUseCase extends BaseUseCases<List<CarForSale>,String>{
  final BaseCarForSaleRepo baseCarForSaleRepo;

  GetUserCarsForSalesUseCase(this.baseCarForSaleRepo);

  @override
  Future<Either<Failure, List<CarForSale>>> call(String userId)async {
   return await baseCarForSaleRepo.getUserCarsForSale(userId: userId);
  }

}
