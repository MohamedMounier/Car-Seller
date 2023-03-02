import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';
import 'package:voomeg/features/bids/domain/usecases/add_car_to_database_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/get_image_url_use_case.dart';
import 'package:voomeg/features/bids/domain/usecases/upload_images_use_case.dart';

part 'add_car_for_sale_event.dart';
part 'add_car_for_sale_state.dart';

class AddCarForSaleBloc extends Bloc<AddCarForSaleEvent, AddCarForSaleState> {
  final AddCarToDatabaseUseCase addCarToDatabaseUseCase;
  final GetImageUrlUseCase getImageUrlUseCase;
  final UploadImagesUSeCase uploadImagesUSeCase;

  AddCarForSaleBloc(this.addCarToDatabaseUseCase, this.getImageUrlUseCase,
      this.uploadImagesUSeCase)
      : super(AddCarForSaleState()) {
    on<ChoosePicturesEvent>(onChoosePics);
    on<AddCarEvent>(onAddCarForSale);
    on<AddCatToDbEvent>(onAddCarToDB);
  }
/*

 */
  FutureOr<void> onAddCarForSale(
      AddCarEvent event, Emitter<AddCarForSaleState> emit) async {
    List<dynamic> list = [];
    for (var image in state.imagesList) {

      emit(state.copyWith(
          circularColorValue: state.uploadedPercent / state.imagesList.length,
          isUploading: true));
      await uploadImagesUSeCase(UploadImageParameters(event.saleId, image))
          .then((value) {
        value.fold(
                (l) => emit(state.copyWith(
                requestState: RequestState.isError,
                requestStep: AddCarRequestSteps.isUploadedPicError,
                uploadingErrorMessage: l.errorMessage,
                isUploading: false)), (r) async {
          emit(state.copyWith(
            requestStep: AddCarRequestSteps.isUploadedPicSucc,
            reference: r,
            requestState: RequestState.isSucc,
          ));
        });
      }).whenComplete(()async =>  await getImageUrlUseCase(state.reference!).then((value) {
        value.fold(
                (l) => emit(state.copyWith(
                requestState: RequestState.isError,
                requestStep: AddCarRequestSteps.isFetchedUrlError,
                getUrlErrorMessage: l.errorMessage,
                isUploading: false)), (r){
          list.add(r);
          print('list items are ${list}');
          emit(state.copyWith(
              requestState: RequestState.isSucc,
              requestStep: AddCarRequestSteps.isFetchedUrlSucc,
              photosUrls: list,
              isUploading: true));


          });
      })
      );
    }
    emit(state.copyWith(isUploading: false));
  }



  FutureOr<void> onChoosePics(
      ChoosePicturesEvent event, Emitter<AddCarForSaleState> emit) async {
    emit(state.copyWith(imagesList: event.chosenImages));
  }


  FutureOr<void> onAddCarToDB(AddCatToDbEvent event, Emitter<AddCarForSaleState> emit)async {
    emit(state.copyWith(requestState: RequestState.isLoading));
    await addCarToDatabaseUseCase(event.carForSale).then((value) {
      value.fold(
              (l) => emit(state.copyWith(
              addPicDbErrorMessage: l.errorMessage,
              requestState: RequestState.isError,
              isUploading: false,
              requestStep: AddCarRequestSteps.isAddedPicToDBError)),
              (r) => emit(state.copyWith(
              requestState: RequestState.isSucc,
              isUploading: false,
              requestStep: AddCarRequestSteps.isAddedPicToDBSucc)));
    });
    emit(state.copyWith(isUploading: false, requestState: RequestState.isSucc,requestStep: AddCarRequestSteps.isAddedPicToDBSucc));

  }
}
