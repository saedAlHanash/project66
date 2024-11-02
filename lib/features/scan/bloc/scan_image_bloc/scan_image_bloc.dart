import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project66/core/util/snack_bar_message.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/enum_manager.dart';
import 'package:m_cubit/abstraction.dart';
import '../../../natural_numbers/bloc/natural_numbers/natural_numbers_cubit.dart';
import '../../data/scan.dart';
import '../../data/scan_image.dart';
import '../../ui/pages/scan_view.dart';
import '../scan_bloc/scan_cubit.dart';

part 'scan_image_state.dart';

class ScanImageCubit extends Cubit<ScanImageInitial> {
  ScanImageCubit() : super(ScanImageInitial.initial());

  Future<void> getImage() async {
    try {
      final list = <ScanImageModel>[];

      final f = await ImagePicker().pickMultiImage(imageQuality: 10);

      for (var e in f) {
        var recognizer = await getRecognizer(e);

        if (recognizer.length < 3) {
          final model = ScanImageModel(
            sn: recognizer.firstOrNull ?? '-',
            nn: recognizer.lastOrNull ?? '-',
            count: '-',
            name: '-',
          );

          NoteMessage.showErrorDialog(ctx!,
              text: 'صورة السند غير صحيحة يرجى إعادة المحاولة \n'
                  'المعلومات التي استطاع التطبيق الحصول عليها \n'
                  '${model.toString()}');
        } else {
          list.add(
            ScanImageModel(
              sn: recognizer[0],
              nn: recognizer[1],
              count: recognizer[2],
              name: '',
            ),
          );
          ctx!.read<ScanCubit>().addScan(recognizer[1], recognizer[2], recognizer[0]);
        }
      }
    } catch (e) {
      loggerObject.e(e);
    }
  }

  Future<void> tackImage() async {
    try {
      final list = <ScanImageModel>[];

      final pickImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );

      if (pickImage == null) return;

      var recognizer = await getRecognizer(pickImage);

      if (recognizer.length < 3) {
        final model = ScanImageModel(
          sn: recognizer.firstOrNull ?? '-',
          nn: recognizer.lastOrNull ?? '-',
          count: '-',
          name: '-',
        );

        NoteMessage.showErrorDialog(ctx!,
            text: 'صورة السند غير صحيحة يرجى إعادة المحاولة \n'
                'المعلومات التي استطاع التطبيق الحصول عليها \n'
                '${model.toString()}');
      } else {
        list.add(
          ScanImageModel(
            sn: recognizer[0],
            nn: recognizer[1],
            count: recognizer[2],
            name: '',
          ),
        );
        ctx!.read<ScanCubit>().addScan(recognizer[1], recognizer[2], recognizer[0]);
      }
    } catch (e) {
      loggerObject.e(e);
    }
  }

  Future<List<String>> getRecognizer(XFile img) async {
    final selectedImage = InputImage.fromFilePath(img.path);
    final textRecognizer = TextRecognizer();
    final recognizedText = await textRecognizer.processImage(
      selectedImage,
    );
    await textRecognizer.close();

    var scannedText = recognizedText.text;
    final v = extractNumbers(scannedText)
      ..removeWhere(
        (e) => e.length <= 3,
      );

    return v;
  }
}

List<String> extractNumbers(String input) {
  final RegExp regExp = RegExp(r'\d+');
  return regExp.allMatches(input).map((match) => match.group(0)!).toList();
}
