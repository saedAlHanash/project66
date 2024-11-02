import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/caching_service/caching_service.dart';
import 'package:project66/services/app_info_service.dart';

import 'package:project66/services/caching_service/caching_service.dart';
import 'package:project66/services/firebase/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app/app_widget.dart';
import 'core/app/bloc/loading_cubit.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/util/shared_preferences.dart';

void main() async {
  // runZonedGuarded(() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance().then((value) {
    AppSharedPreference.init(value);
  });

  await CachingService.initial(
    onError: (state) {},
    version: 3,
    timeInterval: 120,
  );

  await FirebaseService.initial();
  await AppInfoService.initial();

  await di.init();

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<LoadingCubit>()),
      ],
      child: const MyApp(),
    ),
  );
  // }, (e, stackTrace) async {
  //   if (e is Exception) {
  //     FirebaseService.logException(e, stackTrace);
  //   }else if (e is JsonUnsupportedObjectError){
  //     FirebaseService.logCachingServiceError(e, stackTrace.toString());
  //   }
  // });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}
