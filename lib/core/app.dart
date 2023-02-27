import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voomeg/core/global/resources/theme_manager.dart';
import 'package:voomeg/core/global/routes/app_router.dart';
import 'package:voomeg/core/global/routes/app_routes_names.dart';
import 'package:voomeg/core/utils/services/app_prefrences.dart';
import 'package:voomeg/features/auth/presentation/controller/login_bloc.dart';
import 'package:voomeg/features/auth/presentation/controller/register_bloc.dart';

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
            create: (_)=>LoginBloc(sl(),sl(),sl())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getAppTheme(),
        onGenerateRoute: AppRouter.onGenerateRoutes,
        initialRoute:sl<AppPrefrences>().isLoginSaved()?AppRoutesName.home:AppRoutesName.login,
      ),
    );
  }
}
