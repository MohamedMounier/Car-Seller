import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/global/id_generator.dart';

import 'package:voomeg/features/bids/data/models/car_for_sale_model.dart';
import 'package:voomeg/features/bids/presentation/controller/add_car_for_sale_bloc.dart';

class AddCarScreen extends StatefulWidget {
  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  // List<XFile> images = [];
  // final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  // List<String> urls = [];
  // final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  // bool uploading=false;
  // double val =0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCarForSaleBloc, AddCarForSaleState>(
  listener: (context, state) {
    if(state.isUploading==false&&state.requestState==RequestState.isSucc&&state.requestStep==AddCarRequestSteps.isFetchedUrlSucc){
      BlocProvider.of<AddCarForSaleBloc>(context).add(AddCatToDbEvent( CarForSaleModel(
          saleId:GUIDGen.generate(),
          userId: FirebaseAuth.instance.currentUser!.uid,
          carName: "Toyota",
          carModel: "2019",
          carKilos: "51550",
          carLocation: "Cairo",
          saleStatus: "Available",
          createdAt: Timestamp.now(),
          soldAt: Timestamp.now(),
          photosUrls:state.photosUrls!)));
    }
  },
  builder: (context, state) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
                onPressed: () {

                  BlocProvider.of<AddCarForSaleBloc>(context).add(AddCarEvent(
                      state.circularColorValue, state.uploadedPercent, GUIDGen.generate() ));



                },
                child: Text('Upload'))
          ],
        ),
        body: Stack(
          children: [
            GridView.builder(
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemCount: state.imagesList.length + 1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? Center(
                          child: IconButton(
                              onPressed: () {
                                state.isUploading?null:chooseImage(context,state.imagesList);
                              },
                              icon: Icon(Icons.add)),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(state.imagesList[index - 1].path)))),
                        );
                }),
            state.isUploading?Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(child: Text('Uploading'),),
                CircularProgressIndicator(
                  value: state.circularColorValue,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                )
              ],
            ),):SizedBox()
          ],
        ));
  },
);
  }

  Future<void> chooseImage(BuildContext context,List<XFile>images) async {
    final picker = await ImagePicker().pickMultiImage(imageQuality: 100);
    // ImagePicker().pickMultiImage()

    print('Images list length ${images.length}');
    //images.clear();

    if (picker.isNotEmpty) {
      if (picker.length > 5 || images.length == 5) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Maximum pictures count is 5 pictures ')));
      } else {
       BlocProvider.of<AddCarForSaleBloc>(context).add(ChoosePicturesEvent(picker));
      }
    } else {
      print(picker);
    }

  }

  // Future<void> addCar(CarForSaleModel car) async {
  //   // final ref= FirebaseStorage.instance.ref().child('userImage').child(_uid!+'.jpg');
  //   // await ref.putFile(imageFile!);
  //   return await fireStore
  //       .collection(BidsFireStoreConsts.forSale)
  //       .doc(car.saleId)
  //       .set(car.toFireStore());
  // }
  //
  // Future<void> addCarImagesToStorage({required List<XFile>chosenImages,required String saleId ,required List<dynamic>urls}) async {
  //   int i = 1;
  //
  //   for (var image in chosenImages) {
  //     setState(() {
  //       val= i / images.length ;
  //     });
  //     var ref = firebaseStorage.ref().child('$saleId').child('${image.path}');
  //     await ref.putFile(File(image.path)).whenComplete(() async {
  //       await ref.getDownloadURL().then((value) {
  //         urls.add(value);
  //         i++;
  //       });
  //     });
  //   }
  // }
  //
  // Future<void> addCarToStorageAndFirebase(
  // {required CarForSaleModel carForSaleModel,required List<dynamic> urls,required List<XFile> images}) async {
  //   await addCarImagesToStorage(saleId: carForSaleModel.saleId,urls: urls,chosenImages: images)
  //       .whenComplete(() async {
  //     await addCar(carForSaleModel);
  //   });
  // }
}
