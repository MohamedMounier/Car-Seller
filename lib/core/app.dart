import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/global/resources/theme_manager.dart';
import 'package:voomeg/core/global/routes/app_router.dart';
import 'package:voomeg/core/global/routes/app_routes_names.dart';
import 'package:voomeg/core/utils/services/app_prefrences.dart';
import 'package:voomeg/features/auth/presentation/controller/login_bloc.dart';
import 'package:voomeg/features/auth/presentation/controller/register_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/add_car_for_sale_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/home_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/offers_blocs/add_offer_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/offers_blocs/user_offers_bloc.dart';

import 'utils/services/service_locator.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
        create: (_)=>RegisterBloc(sl(), sl())),

        BlocProvider<LoginBloc>(
            create: (_)=>LoginBloc(sl(),sl(),sl(),sl())..add(SaveUserTypeEvent(false))),
        BlocProvider<HomeBloc>(
            create: (_)=>HomeBloc(sl(),sl(),sl(),sl(),sl())),
        BlocProvider<AddCarForSaleBloc>(
            create: (_)=>AddCarForSaleBloc(sl(),sl(),sl())),
        BlocProvider<AddOfferBloc>(
            create: (_)=>AddOfferBloc(sl(),sl())),
        BlocProvider<UserOffersBloc>(
            create: (_)=>UserOffersBloc(sl(),sl(),sl())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getAppTheme(),

        onGenerateRoute: AppRouter.onGenerateRoutes,
        initialRoute:fetchInitialRoute(),
      ),
    );
  }
  String fetchInitialRoute(){
    if(sl<AppPreferences>().isLoginSaved()&&sl<AppPreferences>().isTypeTrader()){
      return AppRoutesName.traderHome;
    }else if (sl<AppPreferences>().isLoginSaved()&&! sl<AppPreferences>().isTypeTrader()){
      return AppRoutesName.home;
    }else{
      return AppRoutesName.login;
    }
  }
}
