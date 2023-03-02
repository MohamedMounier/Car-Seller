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
