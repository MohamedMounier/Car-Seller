import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';

class CarForSaleModel extends CarForSale {
  CarForSaleModel(
      {required super.saleId,
      required super.userId,
      required super.carName,
      required super.carModel,
      required super.carKilos,
      required super.carLocation,
      required super.saleStatus,
      required super.createdAt,
      required super.soldAt,
      required super.reservePrice,
      required super.photosUrls});

  factory CarForSaleModel.fromFireBase(Map<String, dynamic> data) =>
      CarForSaleModel(
        carName: data['carName'],
        carKilos: data['carKilos'],
        carLocation: data['carLocation'],
        carModel: data['carModel'],
        saleId: data['saleId'],
        saleStatus: data['saleStatus'],
        userId: data['userId'],
        soldAt: data['soldAt'],
        createdAt: data['createdAt'],
        reservePrice: data['reservePrice'],
        photosUrls: data['photosUrls'],
      );

  Map<String,dynamic> toFireStore()=>{
    'carName':this.carName,
    'carKilos':this.carKilos,
    'carLocation':this.carLocation,
    'carModel':this.carModel,
    'saleId':this.saleId,
    'saleStatus':this.saleStatus,
    'userId':this.userId,
    'soldAt':this.soldAt,
    'createdAt':this.createdAt,
    'photosUrls':this.photosUrls,
    'reservePrice':this.reservePrice,
  };
}
