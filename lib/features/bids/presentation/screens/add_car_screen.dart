import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/global/id_generator.dart';
import 'package:voomeg/core/global/resources/size_config.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';
import 'package:voomeg/core/global/routes/app_router.dart';
import 'package:voomeg/core/global/routes/app_routes_names.dart';

import 'package:voomeg/features/bids/data/models/car_for_sale_model.dart';
import 'package:voomeg/features/bids/domain/entities/for_sale_cars.dart';
import 'package:voomeg/features/bids/presentation/controller/add_car_for_sale_bloc.dart';
import 'package:voomeg/reusable/widgets/editable_text.dart';

class AddCarScreen extends StatelessWidget {
  final TextEditingController priceCtrl=TextEditingController();
  final TextEditingController carNameCtrl=TextEditingController();
  final TextEditingController carModelCtrl=TextEditingController();
  final TextEditingController carKilosCtrl=TextEditingController();
  final TextEditingController carLocationCtrl=TextEditingController();
  GlobalKey<FormState> addCarKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCarForSaleBloc, AddCarForSaleState>(
      listener: (context, state) {
        if (state.isUploading == false &&
            state.requestState == RequestState.isSucc &&
            state.requestStep == AddCarRequestSteps.isFetchedUrlSucc) {
          BlocProvider.of<AddCarForSaleBloc>(context).add(AddCatToDbEvent(
              CarForSale(
                  saleId: GUIDGen.generate(),
                  userId: FirebaseAuth.instance.currentUser!.uid,
                  carName: carNameCtrl.text,
                  carModel:carModelCtrl.text,
                  carKilos: carKilosCtrl.text,
                  carLocation:carLocationCtrl.text,
                  saleStatus: "Available",
                  reservePrice: num.parse(priceCtrl.text),
                  createdAt: Timestamp.now(),
                  soldAt: Timestamp.now(),
                  photosUrls: state.photosUrls!)));
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AppRoutesName.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Add Car For Sale'),

            ),
            body: Form(
              key: addCarKey,
              child: ListView(
                padding: const EdgeInsets.all(AppPading.p20),
                children: [
                  chosenPhotosWidget(context, state),
                  state.isUploading
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Text('Uploading',
                                ),
                              ),
                              CircularProgressIndicator(
                                value: state.circularColorValue,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),

                  SizedBox(height: SizeConfig.screenHeight(context)*0.03,),
                  Text('Car Name : ',
                    style: Theme.of(context).textTheme.headlineLarge,

                  ),
                  SizedBox(height: SizeConfig.screenHeight(context)*0.01,),
                  EditableInfoField(
                    isPassword: false,
                    isObsecure: false,
                    hint: "Enter Car Name",
                    label: "Car Name",
                    textEditingController: carNameCtrl,
                    keyboardType: TextInputType.text,
                    iconName: Icons.car_rental_rounded,
                  ),
                  SizedBox(height: SizeConfig.screenHeight(context)*0.01,),
                  Text('Reserve Price : ',
                    style: Theme.of(context).textTheme.headlineLarge,

                  ),
                  SizedBox(height: SizeConfig.screenHeight(context)*0.01,),
                  EditableInfoField(
                    isPassword: false,
                    isObsecure: false,
                    hint: "Put your minimum price here",
                    label: "Reserve Price",
                    textEditingController: priceCtrl,
                    keyboardType: TextInputType.number,
                    iconName: Icons.money,
                  ),
                  SizedBox(height: SizeConfig.screenHeight(context)*0.01,),


                  Text('Car Model : ',
                    style: Theme.of(context).textTheme.headlineLarge,

                  ),
                  SizedBox(height: SizeConfig.screenHeight(context)*0.01,),
                  EditableInfoField(
                    isPassword: false,
                    isObsecure: false,
                    hint: "Enter Car Model",
                    label: "Car Model",
                    textEditingController: carModelCtrl,
                    keyboardType: TextInputType.number,
                    iconName: Icons.confirmation_num_outlined,
                  ),
                  SizedBox(height: SizeConfig.screenHeight(context)*0.01,),
                  Text('Car Location : ',
                    style: Theme.of(context).textTheme.headlineLarge,

                  ),
                  SizedBox(height: SizeConfig.screenHeight(context)*0.01,),
                  EditableInfoField(
                    isPassword: false,
                    isObsecure: false,
                    hint: "Enter Car Location ",
                    label: "Location",
                    textEditingController: carLocationCtrl,
                    keyboardType: TextInputType.text,
                    iconName: Icons.location_on_outlined,
                  ),
                  SizedBox(height: SizeConfig.screenHeight(context)*0.01,),
                  Text('Car Consumed Kilos : ',
                    style: Theme.of(context).textTheme.headlineLarge,

                  ),
                  SizedBox(height: SizeConfig.screenHeight(context)*0.01,),

                  EditableInfoField(
                    isPassword: false,
                    isObsecure: false,
                    hint: "Enter Car Consumed Kilos  ",
                    label: "Kilos",
                    textEditingController: carKilosCtrl,
                    keyboardType: TextInputType.number,
                    iconName: Icons.confirmation_number_outlined,
                  ),
                  SizedBox(height: SizeConfig.screenHeight(context)*0.01,),
                  ElevatedButton(
                      onPressed: () {

                          if(addCarKey.currentState!.validate()){
                            BlocProvider.of<AddCarForSaleBloc>(context).add(
                                AddCarEvent(state.circularColorValue,
                                    state.uploadedPercent, GUIDGen.generate()));
                          }


                      },
                      child: Text('Upload Car'))
                ],
              ),
            ));
      },
    );
  }

  Container chosenPhotosWidget(BuildContext context, AddCarForSaleState state) {
    return Container(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                //height: SizeConfig.screenHeight(context) * 0.35,
                child: GridView.builder(
                  shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: state.imagesList.length + 1,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                              child: IconButton(
                                  onPressed: () {
                                    state.isUploading
                                        ? null
                                        : chooseImage(
                                            context, state.imagesList);
                                  },
                                  icon: Icon(Icons.add)),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(File(state
                                          .imagesList[index - 1].path)))),
                            );
                    }),
              );
  }

  Future<void> chooseImage(BuildContext context, List<XFile> images) async {
    final picker = await ImagePicker().pickMultiImage(imageQuality: 100);
    // ImagePicker().pickMultiImage()

    print('Images list length ${images.length}');
    //images.clear();

    if (picker.isNotEmpty) {
      if (picker.length > 5 || images.length == 5) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Maximum pictures count is 5 pictures ')));
      } else {
        BlocProvider.of<AddCarForSaleBloc>(context)
            .add(ChoosePicturesEvent(picker));
      }
    } else {
      print(picker);
    }
  }

}
