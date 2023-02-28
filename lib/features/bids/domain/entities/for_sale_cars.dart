import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CarForSale extends Equatable {
  final String saleId;

  CarForSale(
      {required this.saleId,
      required this.userId,
      required this.carName,
      required this.carModel,
      required this.carKilos,
      required this.carLocation,
      required this.saleStatus,
      required this.createdAt,
      required this.soldAt,
      required this.photosUrls});

  final String userId;
  final String carName;
  final String carModel;
  final String carKilos;
  final String carLocation;
  final String saleStatus;
  final Timestamp createdAt;
  final Timestamp soldAt;
  final List<dynamic> photosUrls;

  @override
  List<Object> get props => [
        saleId,
        userId,
        carName,
        carModel,
        carKilos,
        carLocation,
        saleStatus,
        photosUrls,
      ];
}
