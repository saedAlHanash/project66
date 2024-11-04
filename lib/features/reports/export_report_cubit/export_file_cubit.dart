import 'dart:io';

import 'package:collection/collection.dart';
import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project66/core/extensions/extensions.dart';
import 'package:project66/core/util/snack_bar_message.dart';
import 'package:project66/features/scan/data/scan.dart';
import 'package:project66/main.dart';

import 'package:uuid/uuid.dart';

import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import 'package:m_cubit/abstraction.dart';
import '../../../../generated/l10n.dart';
import '../../../core/api_manager/api_service.dart';
import '../../../core/util/shared_preferences.dart';

part 'export_file_state.dart';

class ExportReportCubit extends Cubit<ExportReportInitial> {
  ExportReportCubit() : super(ExportReportInitial.initial());

  Future<void> saveFile(String? name) async {
    await Permission.manageExternalStorage.request();
    await Permission.storage.request();

    var directory = await getApplicationDocumentsDirectory();

    var fName =
        ' تقرير المشروع التنظيمي 66 ${name ?? ''} ${DateTime.now().toIso8601String()}';

    final invalidChars = ['<', '>', ':', '"', '/', '\\', '|', '?', '*'];

    // Replace invalid characters with an empty string

    for (var char in invalidChars) {
      fName = fName.replaceAll(char, '');
    }

    state.excel.delete('Sheet1');
    try {
      File(join('/storage/emulated/0/Documents/Project66/$fName.xlsx'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(state.excel.save() ?? []);
      NoteMessage.showSuccessSnackBar(
          message: 'تم التصدير بنجاح', context: ctx!);
    } catch (e) {
      loggerObject.e(e);
      emit(state.copyWith(statuses: CubitStatuses.error, error: e.toString()));
    }
/*    final file = File(join('${directory?.path}/$fName.xlsx'))
      ..createSync(recursive: true)
      ..writeAsBytesSync(state.excel.save() ?? []);

    // Copy the file to the Downloads directory
    final downloadsFilePath = '/storage/emulated/0/Project66/$fName.xlsx';

    try {
      final directoryProject = Directory('/storage/emulated/0/Project66');

      if (!(await directoryProject.exists())) {
        await directoryProject.create(recursive: true);
      }

      await file.copy(downloadsFilePath);
      NoteMessage.showSuccessSnackBar(message: 'تم التصدير بنجاح', context: ctx!);
    } on Exception catch (e) {
      loggerObject.e(e);
      emit(state.copyWith(statuses: CubitStatuses.error, error: e.toString()));
    }

    Future.delayed(
      const Duration(seconds: 1),
      () {
        emit(state.copyWith(statuses: CubitStatuses.done));
      },
    );*/
  }

  void export({
    required List<ScanModel> listData,
    String? name,
  }) async {
    final list = listData
        .where((e) => e.storeVersion == AppSharedPreference.getStoreEnum.index)
        .toList();
    state.excel = Excel.createExcel();

    if (list.isEmpty) {
      NoteMessage.showAwesomeError(context: ctx!, message: 'لا يوجد تسجيلات');
      return;
    }
    emit(state.copyWith(statuses: CubitStatuses.loading));
    await Permission.manageExternalStorage.request();
    await Permission.storage.request();

    s1(list: list);

    await saveFile(name);
  }

  void s1({
    required List<ScanModel> list,
  }) {
    //توليد
    final uuID = const Uuid().v4();
    //توليد صفحة باسم الاستمارة
    const sheetName = 'name';
    final sheet = state.getSheet(sheetName);
    //جلب جميع معرفات الأسئلة مع مواقعهم في القائمة
    final qIdHeaderAndIndex = [];

    for (var e in list) {
      sheet.appendRow([
        TextCellValue(e.name),
        TextCellValue(e.idNumber),
        TextCellValue(e.scanNumber.toString()),
        TextCellValue(e.amount.toString()),
      ]);
    }
  }
}
