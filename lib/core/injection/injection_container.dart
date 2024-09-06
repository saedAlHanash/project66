import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


import 'package:shared_preferences/shared_preferences.dart';


import '../../features/natural_numbers/bloc/natural_numbers/natural_numbers_cubit.dart';
import '../../features/reports/export_report_cubit/export_file_cubit.dart';
import '../../features/scan/bloc/scan_bloc/scan_cubit.dart';
import '../../features/scan/bloc/scan_image_bloc/scan_image_bloc.dart';
import '../app/bloc/loading_cubit.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => LoadingCubit());
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  //endregion
  sl.registerFactory(() => NaturalNumbersCubit());
  sl.registerFactory(() => ScanCubit());
  sl.registerFactory(() => ExportReportCubit());
  sl.registerFactory(() => ScanImageCubit());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
