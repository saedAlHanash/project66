// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_multi_type/image_multi_type.dart';
// import 'package:project66/core/extensions/extensions.dart';
// import 'package:project66/services/firebase/firebase_service.dart';
//
// import '../../generated/assets.dart';
// import '../../services/caching_service/caching_service.dart';
// import '../api_manager/api_service.dart';
// import '../api_manager/request_models/command.dart';
// import '../error/error_manager.dart';
// import '../strings/enum_manager.dart';
//
// abstract class AbstractState<T> {
//   final CubitStatuses statuses;
//   final String error;
//   final T result;
//   final FilterRequest? filterRequest;
//   final dynamic request;
//
//   const AbstractState({
//     this.statuses = CubitStatuses.init,
//     this.error = '',
//     this.filterRequest,
//     this.request,
//     required this.result,
//   });
//
//   bool get loading => statuses == CubitStatuses.loading;
//
//   bool get isDataEmpty =>
//       (statuses != CubitStatuses.loading) &&
//       (result is List) &&
//       ((result as List).isEmpty);
//
//   Widget get emptyWidget => Center(
//         child: ImageMultiType(
//           url: Assets.imagesNoFolders,
//           height: 0.9.sw,
//           width: 0.9.sw,
//         ),
//       );
// }
//
// abstract class AbstractState1<T> extends Equatable {
//   final CubitStatuses statuses;
//   final StateControl control;
//   final T result;
//
//   const AbstractState1({
//     required this.control,
//     this.statuses = CubitStatuses.init,
//     required this.result,
//   });
// }
//
// class StateControl {
//   String? error;
//   FilterRequest? filterRequest;
//   dynamic request;
//
//   StateControl();
// }
//
// abstract class MCubit<AbstractState> extends Cubit<AbstractState> {
//   MCubit(super.initialState);
//
//   String get nameCache => '';
//
//   String get filter => '';
//
//   int? get timeInterval => null;
//
//   Future<NeedUpdateEnum> needGetData() async {
//     if (nameCache.isEmpty) return NeedUpdateEnum.withLoading;
//     return await CachingService.needGetData(
//       nameCache,
//       filter: filter,
//       timeInterval: timeInterval,
//     );
//   }
//
//   Future<void> storeData(dynamic data) async {
//     await CachingService.sortData(data: data, name: nameCache, filter: filter);
//   }
//
//   Future<Iterable<dynamic>?> addOrUpdateDate(List<dynamic> data) async {
//     return await CachingService.addOrUpdate(
//       data: data,
//       name: nameCache,
//       filter: filter,
//     );
//   }
//
//   Future<Iterable<dynamic>?>  deleteDate(List<String> data) async {
//     return await CachingService.delete(data: data, name: nameCache, filter: filter);
//   }
//
//   Future<Iterable<dynamic>> getListCached() async {
//     final data = await CachingService.getList(nameCache, filter: filter);
//     return data;
//   }
//
//   Future<dynamic> getDataCached() async {
//     return (await CachingService.getData(nameCache, filter: filter)) ??
//         <String, dynamic>{};
//   }
//
//   Future<bool> checkCashed1<T>({
//     required dynamic state,
//     required T Function(Map<String, dynamic>) fromJson,
//     bool newData = false,
//     void Function(dynamic data, CubitStatuses emitState)? onSuccess,
//   }) async {
//     if (newData) {
//       emit(state.copyWith(statuses: CubitStatuses.loading));
//       return false;
//     }
//
//     try {
//       final cacheType = await needGetData();
//       final emitState = cacheType.getState;
//       dynamic data;
//
//       if (state.result is List) {
//         data = (await getListCached()).map((e) {
//           try {
//             return fromJson(e);
//           } catch (e) {
//             FirebaseService.logFromJsonError(
//                 e as Exception, '$nameCache  ${T.runtimeType}');
//             return fromJson({});
//           }
//         }).toList();
//       } else {
//         data = fromJson(await getDataCached());
//       }
//
//       if (onSuccess != null) {
//         onSuccess.call(data, emitState);
//       } else {
//         emit(
//           state.copyWith(
//             result: data,
//             statuses: emitState,
//           ),
//         );
//       }
//
//       if (cacheType == NeedUpdateEnum.no) return true;
//
//       return false;
//     } catch (e) {
//       loggerObject.e('checkCashed1$nameCache: $e');
//
//       return false;
//     }
//   }
//
//   Future<void> getDataAbstract<T>({
//     required T Function(Map<String, dynamic>) fromJson,
//     required dynamic state,
//     required Function getDataApi,
//     bool newData = false,
//     void Function()? onError,
//     void Function(dynamic data, CubitStatuses emitState)? onSuccess,
//   }) async {
//     final checkData = await checkCashed1(
//       state: state,
//       fromJson: fromJson,
//       newData: newData,
//       onSuccess: onSuccess,
//     );
//
//     if (checkData) {
//       loggerObject.f('$nameCache stopped on cache');
//       return;
//     }
//
//     final pair = await getDataApi.call();
//
//     if (pair.first == null) {
//       if (isClosed) return;
//
//       final s = state.copyWith(statuses: CubitStatuses.error, error: pair.second);
//
//       emit(s);
//
//       onError?.call();
//     } else {
//       await storeData(pair.first);
//
//       if (onSuccess != null) {
//         onSuccess.call(pair.first, CubitStatuses.done);
//       } else {
//         if (isClosed) return;
//         emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
//       }
//     }
//   }
// }
