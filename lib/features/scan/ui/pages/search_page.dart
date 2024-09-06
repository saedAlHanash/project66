import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:project66/core/extensions/extensions.dart';
import 'package:project66/core/util/snack_bar_message.dart';
import 'package:project66/core/widgets/app_bar/app_bar_widget.dart';
import 'package:project66/core/widgets/saed_taple_widget.dart';

import '../../../../core/app/app_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../generated/assets.dart';
import '../../../reports/export_report_cubit/export_file_cubit.dart';
import '../../bloc/scan_bloc/scan_cubit.dart';
import '../../data/scan.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key, required this.list, required this.name});

  final List<ScanModel> list;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 20.0, left: 20.0),
        child: MyButton(
          onTap: () => context.read<ExportReportCubit>().export(list: list, name: name),
          text: 'تصدير',
          iconStart: Icons.import_export,
        ),
      ),
      appBar: AppBarWidget(titleText: name),
      body: Padding(
        padding: const EdgeInsets.all(15.0).r,
        child: SaedTableWidget(
          height: 1.0.sh,
          title: const [
            'رقم',
            'اسم',
            'اسهم',
            '',
          ],
          weights: const [4, 6, 8, 3],
          data: list
              .map(
                (e) => [
                  e.scanNumber,
                  e.name,
                  (num.tryParse(e.amount) ?? 0).formatPrice,
                  InkWell(
                    onTap: () {
                      NoteMessage.showCheckDialog(
                        ctx!,
                        text: 'تأكيد الحذف',
                        textButton: 'حذف',
                        image: ImageMultiType(
                          url: Icons.delete,
                          height: 80.0.r,
                          width: 80.0.r,
                          color: Colors.red,
                        ),
                        onConfirm: () {
                          context.read<ScanCubit>().delete(e.scanNumber);
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).r,
                      child: const ImageMultiType(
                        url: Assets.iconsXCancle,
                      ),
                    ),
                  ),
                ],
              )
              .toList(),
        ),
      ),
    );
  }
}
