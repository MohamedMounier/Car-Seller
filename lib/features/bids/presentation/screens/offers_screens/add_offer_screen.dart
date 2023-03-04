import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/global/resources/size_config.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';
import 'package:voomeg/features/bids/domain/entities/offer.dart';
import 'package:voomeg/features/bids/presentation/controller/offers_blocs/add_offer_bloc.dart';
import 'package:voomeg/reusable/toasts/app_toastss.dart';
import 'package:voomeg/reusable/widgets/car_carouser_slider.dart';
import 'package:voomeg/reusable/widgets/editable_text.dart';
import 'package:voomeg/reusable/widgets/info_raw_medium.dart';
import 'package:voomeg/reusable/widgets/loading_widget.dart';
import 'package:voomeg/reusable/widgets/price_row.dart';
import 'package:voomeg/reusable/widgets/raw_info_headline.dart';

class AddOfferScreen extends StatelessWidget {
   AddOfferScreen({Key? key}) : super(key: key);

  final TextEditingController priceCtrl=TextEditingController();
  final GlobalKey<FormState> addOfferKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddOfferBloc, AddOfferState>(
      listenWhen: (previous,current){
        return previous.addOfferRequest!=current.addOfferRequest;
      },
      listener: (context, state) {
        if(state.addOfferRequest ==RequestState.isSucc){
          ScaffoldMessenger.of(context).showSnackBar(snackBarToast(text: 'Your Offer Has been sent to seller', isError: false));
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Offer A Price'),),
        body: BlocBuilder<AddOfferBloc, AddOfferState>(
          builder: (context, state) {
           if(state.getSaleUserState==RequestState.isLoading){
             return Center(child: LoadingJsonWidget(),);
           }else if(state.getSaleUserState==RequestState.isError){
             return Center(child: Text('${state.getSaleUserStateErrorMessage}'),);

           }else{
             return Form(
               key: addOfferKey,
               child: Padding(
                 padding: const EdgeInsets.all(AppPading.p20),
                 child: ListView(
                   children: [
                     SizedBox(
                       height: 50,
                     ),

                     Container(
                       //margin: const EdgeInsets.only(left: AppMargin.m22,right: AppMargin.m20,top: AppMargin.m50,bottom: AppMargin.m22),
                       child: SingleChildScrollView(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [

                             Container(
                               padding: EdgeInsets.all(AppPading.p8),
                               decoration: BoxDecoration(
                                 border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.4)),
                                 borderRadius: BorderRadius.circular(AppSize.s10)
                               ),
                               child: CarCarouselSlider(imagesList: state.carForSale!.photosUrls,
                               carouselHeight: SizeConfig.screenHeight(context)*0.4,
                               ),
                             ),
                             SizedBox(height: SizeConfig.screenHeight(context)*0.008,),

                             PriceRowWidget(
                               title: 'Reserve Price',
                               price:  state.carForSale!.reservePrice.toString(),
                             ),
                             SizedBox(height: SizeConfig.screenHeight(context)*0.02,),
                             InfoRowHeadline(title: 'Seller Name', info:  state.saleUser!.name),

                             SizedBox(height: SizeConfig.screenHeight(context)*0.008,),
                             InfoRowHeadline(title: 'Car Name', info:  state.carForSale!.carName),
                             SizedBox(height: SizeConfig.screenHeight(context)*0.008,),
                             InfoRowMedium(title: 'Model', info: state.carForSale!.carModel),
                             SizedBox(height: SizeConfig.screenHeight(context)*0.008,),

                             InfoRowMedium(title: 'Consumed Kilos', info:  state.carForSale!.carKilos),
                             SizedBox(height: SizeConfig.screenHeight(context)*0.008,),
                          Divider(color: Theme.of(context).primaryColor,)

                          // ElevatedButton(onPressed: (){}, child: Text('Send offer'))
                           ],
                         ),
                       ),
                     ),
                     SizedBox(height: SizeConfig.screenHeight(context)*0.008,),
                     EditableInfoField(
                       isPassword: false,
                       isObsecure: false,
                       hint: "Put your price here",
                       label: "Price",
                       textEditingController: priceCtrl,
                       keyboardType: TextInputType.number,
                       iconName: Icons.money,
                     ),

                     SizedBox(height: SizeConfig.screenHeight(context)*0.008,),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: AppPading.p20,vertical: AppPading.p20),
                       child: ElevatedButton(
                           onPressed: () {
                             validateOffer(
                                 ctx: context,
                                 salePrice: state.carForSale!.reservePrice,
                                 func: (){
                                   BlocProvider.of<AddOfferBloc>(context).add(SendOfferEvent(
                                       Offer(
                                         saleId: state.carForSale!.saleId,
                                         offerId:  state.carForSale!.saleId,
                                         userUid:state.saleUser!.id,
                                         userName: state.saleUser!.name,
                                         traderUid: state.currentTrader!.id,
                                         traderName: state.currentTrader!.name,
                                         offerStatus: 'Sent',
                                         price: num.parse(priceCtrl.text),)));
                                 }
                             );

                           },
                           child: state.addOfferRequest==RequestState.isLoading?CircularProgressIndicator():Text('Send Offer')),
                     )
                   ],
                 ),
               ),
             );
           }
          },
        ),
      ),
    );
  }
  validateOffer({required Function func,num? salePrice,BuildContext? ctx}){
    if(addOfferKey.currentState!.validate()){
     if(num.parse(priceCtrl.text)>salePrice!){
       func();
     }else{
       ScaffoldMessenger.of(ctx!).showSnackBar(snackBarToast(text: 'Your offer price should be more than Minimum sale price',isError: true));
     }
    }
  }


}
