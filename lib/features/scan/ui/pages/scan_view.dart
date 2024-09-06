import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:project66/core/extensions/extensions.dart';
import 'package:project66/core/util/snack_bar_message.dart';
import 'package:project66/core/widgets/app_bar/app_bar_widget.dart';
import 'package:project66/core/widgets/my_button.dart';
import 'package:project66/core/widgets/my_button.dart';
import 'package:project66/core/widgets/my_button.dart';
import 'package:project66/core/widgets/saed_taple_widget.dart';
import 'package:project66/features/reports/export_report_cubit/export_file_cubit.dart';
import 'package:project66/features/scan/bloc/scan_image_bloc/scan_image_bloc.dart';

import '../../../../core/app/app_widget.dart';
import '../../../../generated/assets.dart';
import '../../bloc/scan_bloc/scan_cubit.dart';
import '../widget/search_dialog.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: 'السندات المخزنة',
        actions: [
          10.0.horizontalSpace,
          IconButton(
              onPressed: () {
                NoteMessage.showMyDialog(context, child: const SearchDialog());
              },
              icon: const ImageMultiType(url: Icons.search)),
          10.0.horizontalSpace,
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            10.0.horizontalSpace,
            Expanded(
              child: MyButton(
                onTap: () => context.read<ScanImageCubit>().getImage(),
                text: 'استيراد',
                iconStart: Icons.image,
              ),
            ),
            10.0.horizontalSpace,
            Expanded(
              child: MyButton(
                onTap: () => context.read<ScanImageCubit>().tackImage(),
                text: 'كاميرا',
                iconStart: Icons.camera_alt,
              ),
            ),
            10.0.horizontalSpace,
            Expanded(
              child: MyButton(
                onTap: () => context
                    .read<ExportReportCubit>()
                    .export(list: context.read<ScanCubit>().state.result),
                text: 'تصدير',
                iconStart: Icons.import_export,
              ),
            ),
            10.0.horizontalSpace,
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0).r,
        child: BlocBuilder<ScanCubit, ScanInitial>(
          builder: (context, state) {
            return SaedTableWidget(
              height: 1.0.sh,
              title: const [
                'رقم',
                'اسم',
                'اسهم',
                '',
              ],
              weights: const [4, 6, 8, 3],
              data: state.result
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
            );
          },
        ),
      ),
    );
  }
}
