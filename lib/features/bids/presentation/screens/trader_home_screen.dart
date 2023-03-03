import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/core/global/routes/app_routes_names.dart';
import 'package:voomeg/features/auth/presentation/controller/login_bloc.dart';
import 'package:voomeg/features/bids/presentation/components/home_components.dart';
import 'package:voomeg/features/bids/presentation/components/profile_components.dart';
import 'package:voomeg/features/bids/presentation/controller/home_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/offers_blocs/add_offer_bloc.dart';
import 'package:voomeg/reusable/widgets/error_widget.dart';
import 'package:voomeg/reusable/widgets/loading_widget.dart';

class TraderHomeScreen extends StatelessWidget {
  const TraderHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(FetchUserEvent());
    BlocProvider.of<HomeBloc>(context).add(FetchUserCarsForSale());

    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous,current){
       return current.localDataStats!=previous.localDataStats;
      },
      listener: (context, state) {
        if(state.localDataStats==LocalDataStats.isLoggedOutSucc&&state.requestState==RequestState.isSucc){
          BlocProvider.of<HomeBloc>(context).add(ResetUserTypeEvent());
        }

        else if(state.localDataStats==LocalDataStats.isResetingTypeSucc&&state.requestState==RequestState.isSucc) {
          BlocProvider.of<HomeBloc>(context).add(ResetUserUidEvent());
        }else if (state.localDataStats == LocalDataStats.isRemovedUidSucc &&
            state.requestState == RequestState.isSucc&&state.currentNavBarIndex==1) {
          BlocProvider.of<HomeBloc>(context).add(ResetHomeDataEvent());
          BlocProvider.of<LoginBloc>(context).add(ChangeUserTypeEvent(false));
          //  Navigator.pushReplacementNamed(context, AppRoutesName.login);

          Future.delayed(Duration(milliseconds: 100),()=> Navigator.pushReplacementNamed(context, AppRoutesName.login));
        }
      },
      child: WillPopScope(
        onWillPop: ()async=>false,

        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<HomeBloc>(context).add(FetchUserCarsForSale());
          },
          child: Scaffold(


            body:
            BlocBuilder<HomeBloc,HomeState>(builder: (context,state){

                if(state.requestState==RequestState.isLoading){
                  return const Center(child: LoadingJsonWidget(),);
                }else if (state.requestState==RequestState.isError){
                  return Center(child:  ErrorJsonWidget(errorMessage: state.errorMessage));
                }else{
                  if(state.currentNavBarIndex== 0 ){
                    return carsForSaleListWidget(state);
                  }else{
                    return Column(
                      children: [
                        ProfileComponents(userEntity: state.currentUser!),
                        ElevatedButton(onPressed: (){
                          BlocProvider.of<HomeBloc>(context).add(LogOutEvent(state.userUid));
                        }, child: Text('Log out'))
                      ],
                    );
                  }
                }

              }),

            bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return BottomNavigationBarWidget(state, context);
              },
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBar BottomNavigationBarWidget(HomeState state, BuildContext context) {
    return BottomNavigationBar(
              currentIndex: state.currentNavBarIndex,
              onTap: (val) {
                BlocProvider.of<HomeBloc>(context).add(ChangePageEvent(val));
                if(state.currentNavBarIndex==0){
                  BlocProvider.of<HomeBloc>(context).add(FetchUserCarsForSale());
                }else{
                  BlocProvider.of<HomeBloc>(context).add(FetchUserEvent());
                }
              },
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: ColorManager.lightGrey,
              items: [
                BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.person), label: 'Profile'),
              ],
            );
  }

  ListView carsForSaleListWidget(HomeState state) {
    return ListView.builder(
                    itemCount: state.carsForSaleList.length,
                    itemBuilder: (context, index) {
                      return HomeComponents(userUid: state.carsForSaleList[index].userId,
                        car: state.carsForSaleList[index],
                        userFunction: (){},
                        traderFunction: (){
                        BlocProvider.of<AddOfferBloc>(context).add(GetCurrentCarForSaleEvent(carForSale: state.carsForSaleList[index]));
                        BlocProvider.of<AddOfferBloc>(context).add(GetCurrentTrader(state.currentUser!));

                        BlocProvider.of<AddOfferBloc>(context).add(GetSaleUserEvent(state.carsForSaleList[index].userId));
                        Navigator.pushNamed(context, AppRoutesName.addOffer);
                        },
                        isTrader: true,
                        imageUrl: state.carsForSaleList[index].photosUrls[0],
                        imagesList:state.carsForSaleList[index].photosUrls ,
                      );
                    });
  }
}
