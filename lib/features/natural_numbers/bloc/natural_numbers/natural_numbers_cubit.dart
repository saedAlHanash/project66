import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:project66/core/util/snack_bar_message.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/enum_manager.dart';
import 'package:m_cubit/abstraction.dart';
import '../../data/natural_number.dart';

part 'natural_numbers_state.dart';

class NaturalNumbersCubit extends MCubit<NaturalNumbersInitial> {
  NaturalNumbersCubit() : super(NaturalNumbersInitial.initial());

  @override
  String get nameCache => 'natural_numbers';

  @override
  String get filter => '';

  Future<void> getNumber() async {
    final data = (await getListCached(fromJson: NaturalNumber.fromJson));
    data.removeWhere((e) => e.isDeleted);

    final allNaturalNumbers = data..sort((a, b) => (b.createdAt).compareTo(a.createdAt));

    emit(state.copyWith(result: allNaturalNumbers));

    await Future.delayed(const Duration(seconds: 2));

    _getNaturalNumbers();
  }

  Future<void> addNumber(String id, String name) async {
    if (name.isEmpty || id.isEmpty) return;

    final oldNum = state.result.firstWhereOrNull((e) => e.id == id);
    if (oldNum != null && !oldNum.isDeleted) {
      NoteMessage.showErrorSnackBar(message: 'الرقم الوطني موجود مسبقا', context: ctx!);
      return;
    }

    final json = NaturalNumber(name: name, createdAt: 0, updatedAt: 0, id: id).toJson();
    json['createdAt'] = FieldValue.serverTimestamp();
    json['updatedAt'] = FieldValue.serverTimestamp();

    await FirebaseFirestore.instance.collection('natural_numbers').doc(id).set(json);
  }

  Future<void> delete(String id) async {
    await FirebaseFirestore.instance.collection('natural_numbers').doc(id).update({
      'isDeleted': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    NoteMessage.showSuccessSnackBar(message: 'تم الحذف', context: ctx!);
  }

  bool isFined(String id) {
    final oldNum = state.result.firstWhereOrNull((e) => e.id == id);
    return oldNum != null && !oldNum.isDeleted;
  }

  /// Returns a stream of natural_numbers from Firebase for a given room.
  Future<void> _getNaturalNumbers() async {
    var query = FirebaseFirestore.instance
        .collection('natural_numbers')
        .orderBy('createdAt', descending: true)
        .where(
          'updatedAt',
          isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(
              state.result.firstOrNull?.updatedAt ?? 0),
        );

    loggerObject.i('requested get natural_numbers ');

    loggerObject
        .i(DateTime.fromMillisecondsSinceEpoch(state.result.firstOrNull?.updatedAt ?? 0));
    loggerObject
        .i(DateTime.fromMillisecondsSinceEpoch(state.result.lastOrNull?.updatedAt ?? 0));

    await state.stream?.cancel();
    final stream = query.snapshots().listen((snapshot) async {
      final model = snapshot.docs.map((doc) => NaturalNumber.fromJson(doc.data()));

      if (model.isEmpty) return;

      await saveData(
        model,
        clearId: false,
      );

      if (!isClosed) {
        final data = (await getListCached(fromJson: NaturalNumber.fromJson));
        data.removeWhere((e) => e.isDeleted);

        final allNaturalNumbers = data
          ..sort((a, b) => (b.createdAt).compareTo(a.createdAt));

        emit(state.copyWith(result: allNaturalNumbers));
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
