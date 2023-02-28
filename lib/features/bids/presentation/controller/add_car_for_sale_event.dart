part of 'add_car_for_sale_bloc.dart';

@immutable
abstract class AddCarForSaleEvent extends Equatable {
  const AddCarForSaleEvent();
}

class AddCarEvent extends AddCarForSaleEvent {
  final double circularColorValue;
  final int uploadPercent;
  final String saleId;

  AddCarEvent( this.circularColorValue, this.uploadPercent,
      this.saleId, );

  @override
  List<Object> get props =>
      [
        circularColorValue,
        uploadPercent,
        saleId,
      ];
}
// class AddCarEvent extends AddCarForSaleEvent {
//   final CarForSale carForSale;
//   final double circularColorValue;
//   final int uploadPercent;
//
//   const AddCarEvent(this.carForSale,this.circularColorValue,this.uploadPercent);
//
//   @override
//   List<Object> get props => [carForSale,circularColorValue,uploadPercent];
// }

class ChoosePicturesEvent extends AddCarForSaleEvent {
  final List<XFile> chosenImages;


  ChoosePicturesEvent(this.chosenImages);

  @override
  List<Object> get props => [chosenImages];
}
class AddCatToDbEvent extends AddCarForSaleEvent {
  final CarForSale carForSale;


  AddCatToDbEvent(this.carForSale);

  @override
  List<Object> get props => [carForSale];
}

// class UploadPicEvent extends AddCarForSaleEvent {
//   final String saleId;
//   final double circularColorValue;
//   final int uploadPercent;
//   final XFile image;
//
//   const UploadPicEvent(this.saleId,this.circularColorValue,this.uploadPercent,this.image);
//
//   @override
//   List<Object> get props => [saleId,circularColorValue,uploadPercent,image];
// }

// class GetPicUrlEvent extends AddCarForSaleEvent {
//   final CarForSale carForSale;
//   final double circularColorValue;
//   final int uploadPercent;
//   final Reference reference;
//
//   const GetPicUrlEvent(this.carForSale,this.circularColorValue,this.uploadPercent,this.reference);
//
//   @override
//   List<Object> get props => [carForSale,circularColorValue,uploadPercent,reference];
// }
