
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/core/global/resources/size_config.dart';
import 'package:voomeg/core/global/routes/app_routes_names.dart';

import 'package:voomeg/features/bids/presentation/controller/offers_blocs/user_offers_bloc.dart';
import 'package:voomeg/reusable/toasts/app_toastss.dart';
import 'package:voomeg/reusable/widgets/car_carouser_slider.dart';
import 'package:voomeg/reusable/widgets/error_widget.dart';
import 'package:voomeg/reusable/widgets/loading_widget.dart';
import 'package:voomeg/reusable/widgets/no_data_widget.dart';
import 'package:voomeg/reusable/widgets/price_row.dart';
import 'package:voomeg/reusable/widgets/raw_info_headline.dart';

import '../../../../../core/global/resources/values_manager.dart';

class UserOffersScreen extends StatelessWidget {
   const UserOffersScreen({Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Offers'),
      ),
      body: BlocConsumer<UserOffersBloc,UserOffersState>(
        listenWhen: (previous,current){
          return previous.acceptOfferRequestState!=current.acceptOfferRequestState;
        },
          listener: (context,listenerState){
            if(listenerState.acceptOfferRequestState==RequestState.isSucc){
              ScaffoldMessenger.of(context).showSnackBar(snackBarToast(isError: false,text: 'Congratulations Offer has been accepted !'));
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutesName.home);
            }
          },
          builder: (context, state) {
            if (state.getOffersForCarRequestState == RequestState.isLoading) {
              return const Center(
                child: LoadingJsonWidget(),
              );
            }  else if (state.getOffersForCarRequestState == RequestState.isError){
              return Center(child: ErrorJsonWidget(errorMessage: state.getOffersForCarErrorMessage),);
            }else {
              return Padding(
                padding: const EdgeInsets.all(AppPading.p20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:SizeConfig.screenHeight(context)*.02 ,),
                    CarCarouselSlider(imagesList: state.carForSale!.photosUrls),
                    SizedBox(height:SizeConfig.screenHeight(context)*.04 ,),
                    InfoRowHeadline(title: 'Status',info: state.carForSale!.saleStatus),
                    SizedBox(height:SizeConfig.screenHeight(context)*.05 ,),
                    Text('Traders Offers : ',
                    style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height:SizeConfig.screenHeight(context)*.01 ,),


                  state.carOffers!.isNotEmpty?  Expanded(
                      child: ListView.builder(
                          itemCount: state.carOffers!.length,
                          itemBuilder: (context,index){
                            var offer=state.carOffers![index];
                            return Container(
                              padding: EdgeInsets.all(AppMargin.m20),
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorManager.lightGrey.withOpacity(.4)),
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColor.withOpacity(.1),

                              ),
                              margin: const EdgeInsets.only(top: AppMargin.m20,bottom: AppMargin.m20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InfoRowHeadline(title: 'Trader Name', info: offer.traderName),
                                  SizedBox(height:SizeConfig.screenHeight(context)*.02 ,),

                                  InfoRowHeadline(title: 'Offer Status', info: offer.offerStatus),
                                  SizedBox(height:SizeConfig.screenHeight(context)*.02 ,),

                                  PriceRowWidget(title: 'Offer Price', price:'${offer.price}'),
                                  SizedBox(height:SizeConfig.screenHeight(context)*.02 ,),



                                  state.carForSale!.saleStatus=='Available'? ElevatedButton(onPressed: (){
                                    BlocProvider.of<UserOffersBloc>(context).add(AcceptOfferEvent(offer));
                                    //currentSale!.saleStatus=='Available'?acceptOffer(offer):null;
                                  }, child:state.acceptOfferRequestState==RequestState.isLoading?CircularProgressIndicator(
                                    color: ColorManager.white,

                                  ): Text('Accept offer')):SizedBox()
                                ],
                              ),
                            );
                          }),
                    ):Center(child: Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: NoDataWidget(message: 'No Offers Yet'),
                    ),),
                  ],
                ),
              );
            }


      }),
    );
  }


}
