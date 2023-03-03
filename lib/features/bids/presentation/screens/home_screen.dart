import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/core/global/resources/size_config.dart';
import 'package:voomeg/core/global/resources/theme_manager.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';
import 'package:voomeg/core/global/routes/app_routes_names.dart';
import 'package:voomeg/features/bids/presentation/components/home_components.dart';
import 'package:voomeg/features/bids/presentation/components/profile_components.dart';
import 'package:voomeg/features/bids/presentation/controller/home_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/offers_blocs/user_offers_bloc.dart';
import 'package:voomeg/reusable/widgets/error_widget.dart';
import 'package:voomeg/reusable/widgets/loading_widget.dart';

import '../../../auth/presentation/controller/login_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(FetchUserEvent());
    BlocProvider.of<HomeBloc>(context).add(FetchUserCarsForSale());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) {
        return previous.localDataStats != current.localDataStats;
      },
      listener: (context, state) {
        if (state.localDataStats == LocalDataStats.isLoggedOutSucc &&
            state.requestState == RequestState.isSucc) {
          BlocProvider.of<HomeBloc>(context).add(ResetUserTypeEvent());
        } else if (state.localDataStats == LocalDataStats.isResetingTypeSucc &&
            state.requestState == RequestState.isSucc) {
          BlocProvider.of<HomeBloc>(context).add(ResetUserUidEvent());
        } else if (state.localDataStats == LocalDataStats.isRemovedUidSucc &&
            state.requestState == RequestState.isSucc&&state.currentNavBarIndex==1) {
          BlocProvider.of<HomeBloc>(context).add(ResetHomeDataEvent());
        //  Navigator.pushReplacementNamed(context, AppRoutesName.login);
          BlocProvider.of<LoginBloc>(context).add(ChangeUserTypeEvent(false));

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

            floatingActionButton: floatingActionButtonUser(context),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state.requestState == RequestState.isLoading) {
                return Center(
                  child: LoadingJsonWidget(),
                );
              } else if (state.requestState == RequestState.isError) {
                return Center(
                  child: ErrorJsonWidget(errorMessage: state.errorMessage)
                );
              } else {
                if (state.currentNavBarIndex == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.screenHeight(context)*.08,),
                      Padding(
                        padding: const EdgeInsets.only(left: AppPading.p20),
                        child: Text('Your Cars List : - ',
                        style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      //SizedBox(height: SizeConfig.screenHeight(context)*.005,),

                      Expanded(child: userCarsList(state)),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      ProfileComponents(userEntity: state.currentUser!),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(LogOutEvent(state.userUid));
                          },
                          child: Text('Log out'))
                    ],
                  );
                }
              }
            }),
            bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return buttonNavBar(state, context);
              },
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton floatingActionButtonUser(BuildContext context) {
    return FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutesName.addCar);
            },
            child: Icon(Icons.add),
            backgroundColor: Theme.of(context).primaryColor);
  }

  BottomNavigationBar buttonNavBar(HomeState state, BuildContext context) {
    return BottomNavigationBar(
              currentIndex: state.currentNavBarIndex,
              onTap: (val) {
                BlocProvider.of<HomeBloc>(context).add(ChangePageEvent(val));
              },
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: ColorManager.lightGrey,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            );
  }

  ListView userCarsList(HomeState state) {
    return ListView.builder(
                  itemCount: state.carsForSaleList.length,
                  itemBuilder: (context, index) {
                    return HomeComponents(
                      userUid: state.currentUser!.id,
                      userFunction: () {
                        BlocProvider.of<UserOffersBloc>(context).add(GetCurrentSaleEvent(state.carsForSaleList[index]));

                        BlocProvider.of<UserOffersBloc>(context).add(FetchOffersForCarEvent(state.currentUser!.id,state.carsForSaleList[index].saleId));
                       Navigator.pushNamed(context, AppRoutesName.userOffers);
                      },

                      traderFunction: () {},
                      car: state.carsForSaleList[index],
                      imageUrl: state.carsForSaleList[index].photosUrls[0],
                      imagesList: state.carsForSaleList[index].photosUrls,
                    );
                  });
  }

}
