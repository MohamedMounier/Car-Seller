import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final String saleId;
  final String offerId;
  final String userUid;
  final String userName;
  final String traderUid;
  final String traderName;
  final String offerStatus;
  final num price;

  Offer({
    required this.saleId,
    required this.offerId,
    required this.userUid,
    required this.userName,
    required this.traderUid,
    required this.traderName,
    required this.offerStatus,
    required this.price});

  @override
  List<Object> get props =>
      [
        saleId,
        offerId,
        userUid,
        userName,
        traderUid,
        traderName,
        offerStatus,
        price,
      ];
}
