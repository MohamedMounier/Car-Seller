import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voomeg/core/app.dart';
import 'package:voomeg/core/global/routes/app_router.dart';
import 'package:voomeg/core/network/bloc_observer.dart';
import 'package:voomeg/core/utils/services/service_locator.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ServiceLocator().init();
  BlocOverrides.runZoned(
        () async {

          runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );

}



