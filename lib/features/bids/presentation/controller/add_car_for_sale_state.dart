part of 'add_car_for_sale_bloc.dart';

@immutable
class AddCarForSaleState extends Equatable {
  final List<CarForSale> userCarsForSale;
  final RequestState requestState;
  final AddCarRequestSteps requestStep;
   int uploadedPercent;
  final double circularColorValue;
   List<XFile> imagesList;
   List<dynamic>? photosUrls;
  final bool isUploading;
  Reference? reference;
  final String saleId;
  final String uploadingErrorMessage;
  final String getUrlErrorMessage;
  final String addPicDbErrorMessage;
  final String currentPhotoUrl;

  AddCarForSaleState({this.userCarsForSale = const [],
    this.requestState = RequestState.isNone,
    this.requestStep = AddCarRequestSteps.isNone,
    this.uploadedPercent = 1,
    this.circularColorValue = 0,
    this.imagesList=const[] ,
    this.photosUrls,
    this.saleId = '',
    this.uploadingErrorMessage = '',
    this.getUrlErrorMessage = '',
    this.addPicDbErrorMessage = '',
    this.currentPhotoUrl = '',
    this.reference,
    this.isUploading = false});

  AddCarForSaleState copyWith({List<CarForSale>? userCarsForSale,
    RequestState? requestState,
    AddCarRequestSteps? requestStep,
    int? uploadedPercent,
    String? saleId,
    String? currentPhotoUrl,
    String? uploadingErrorMessage,
    String? getUrlErrorMessage,
    String? addPicDbErrorMessage,
    Reference? reference,
    double? circularColorValue,
    List<XFile>? imagesList,
    List<dynamic>? photosUrls,
    bool? isUploading}) =>
      AddCarForSaleState(
          userCarsForSale: userCarsForSale ?? this.userCarsForSale,
          requestState: requestState ?? this.requestState,
          requestStep: requestStep ?? this.requestStep,
          uploadedPercent: uploadedPercent ?? this.uploadedPercent,
          imagesList: imagesList ?? this.imagesList,
          reference: reference ?? this.reference,
          saleId: saleId ?? this.saleId,
          uploadingErrorMessage: saleId ?? this.uploadingErrorMessage,
          addPicDbErrorMessage: addPicDbErrorMessage ??
              this.addPicDbErrorMessage,
          getUrlErrorMessage: saleId ?? this.getUrlErrorMessage,
          circularColorValue: circularColorValue ?? this.circularColorValue,
          photosUrls: photosUrls ?? this.photosUrls,
          currentPhotoUrl: currentPhotoUrl ?? this.currentPhotoUrl,
          isUploading: isUploading ?? this.isUploading);

  @override
  List<Object> get props =>
      [
        userCarsForSale,
        requestState,
        requestStep,
        uploadedPercent,
        circularColorValue,
        imagesList,
        isUploading,
        saleId,
        uploadingErrorMessage,
        getUrlErrorMessage,
        addPicDbErrorMessage,
        currentPhotoUrl,
      ];
}
