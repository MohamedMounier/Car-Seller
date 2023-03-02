import 'package:voomeg/features/bids/domain/entities/offer.dart';

class OfferModel extends Offer {
  OfferModel(
      {required super.saleId,
      required super.offerId,
      required super.userUid,
      required super.userName,
      required super.traderUid,
      required super.traderName,
      required super.offerStatus,
      required super.price});
}
