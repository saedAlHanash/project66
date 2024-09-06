import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project66/core/util/snack_bar_message.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../natural_numbers/bloc/natural_numbers/natural_numbers_cubit.dart';
import '../../data/scan.dart';

part 'scan_state.dart';

class ScanCubit extends MCubit<ScanInitial> {
  ScanCubit() : super(ScanInitial.initial());

  @override
  String get nameCache => 'scan';

  @override
  String get filter => '';

  Future<void> getScan() async {
    final data = (await getListCached()).map((e) => ScanModel.fromJson(e)).toList();
    data.removeWhere((e) => e.isDeleted);
    final noName = data.where((e) => e.name.isEmpty);
    final names = ctx!.read<NaturalNumbersCubit>().state.result;
    noName.map((e) {
      final name = names.firstWhereOrNull((eName) => e.id == eName.id)?.name ?? '';
      if (name.isNotEmpty) {
        updateName(e.id, name);
      }
    });

    final allScan = data..sort((a, b) => (b.createdAt).compareTo(a.createdAt));

    emit(state.copyWith(result: allScan));

    await Future.delayed(const Duration(seconds: 2));

    _getScan();
  }

  Future<void> delete(String scanNumber) async {
    await FirebaseFirestore.instance.collection('scan').doc(scanNumber).update({
      'isDeleted': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    NoteMessage.showSuccessSnackBar(message: 'تم الحذف', context: ctx!);
  }

  Future<void> updateName(String scanNumber, String name) async {
    await FirebaseFirestore.instance.collection('scan').doc(scanNumber).update({
      'name': name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    NoteMessage.showSuccessSnackBar(message: 'تم الحذف', context: ctx!);
  }

  Future<void> addScan(String idNumber, String amount, String scanNumber) async {
    if (idNumber.isEmpty || amount.isEmpty || scanNumber.isEmpty) return;

    if ((state.result.firstWhereOrNull((e) =>
            (e.amount == amount || e.scanNumber == scanNumber) && e.name.isNotEmpty) !=
        null)) {
      NoteMessage.showErrorSnackBar(message: 'السند موجود مسبقا', context: ctx!);
      return;
    }

    final name = ctx!
            .read<NaturalNumbersCubit>()
            .state
            .result
            .firstWhereOrNull((e) => e.id == idNumber)
            ?.name ??
        '';
    final json = ScanModel(
      name: name,
      scanNumber: scanNumber,
      createdAt: 0,
      updatedAt: 0,
      id: '0',
      idNumber: idNumber,
      amount: amount,
    ).toJson();
    json['createdAt'] = FieldValue.serverTimestamp();
    json['updatedAt'] = FieldValue.serverTimestamp();

    await FirebaseFirestore.instance.collection('scan').doc(scanNumber).set(json);
    NoteMessage.showSuccessSnackBar(message: 'تم الإضافة', context: ctx!);
  }

  Future<void> addOrUpdateScanModelToCache(ScanModel item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => ScanModel.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

//01030218087
  /// Returns a stream of scan from Firebase for a given room.
  Future<void> _getScan() async {
    var query = FirebaseFirestore.instance
        .collection('scan')
        .orderBy('createdAt', descending: true)
        .where(
          'updatedAt',
          isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(
              state.result.firstOrNull?.updatedAt ?? 0),
        );

    loggerObject.i('requested get scan ');

    loggerObject
        .i(DateTime.fromMillisecondsSinceEpoch(state.result.firstOrNull?.updatedAt ?? 0));
    loggerObject
        .i(DateTime.fromMillisecondsSinceEpoch(state.result.lastOrNull?.updatedAt ?? 0));

    await state.stream?.cancel();
    final stream = query.snapshots().listen((snapshot) async {
      final model = snapshot.docs.map((doc) => ScanModel.fromJson(doc.data()));

      if (model.isEmpty) return;

      await storeData(model);

      if (!isClosed) {
        final data = (await getListCached()).map((e) => ScanModel.fromJson(e)).toList();
        data.removeWhere((e) => e.isDeleted);
        final allScan = data..sort((a, b) => (b.createdAt).compareTo(a.createdAt));

        emit(state.copyWith(result: allScan));
      }
    });

    emit(state.copyWith(stream: stream));
  }

  @override
  Future<Function> close() async {
    super.close();
    state.stream?.cancel();
    return () {};
  }
}
