import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:project66/core/extensions/extensions.dart';
import 'package:project66/core/util/snack_bar_message.dart';
import 'package:project66/core/widgets/app_bar/app_bar_widget.dart';
import 'package:project66/core/widgets/saed_taple_widget.dart';

import '../../../../generated/assets.dart';
import '../../bloc/natural_numbers/natural_numbers_cubit.dart';
import '../widget/create_number_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(zeroHeight: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NoteMessage.showMyDialog(context, child: const CreateDialog());
        },
        child: const ImageMultiType(
          url: Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<NaturalNumbersCubit, NaturalNumbersInitial>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0).r,
            child: SaedTableWidget(
              height: 1.0.sh,
              title: const [
                'الاسم',
                'الرقم الوطني',
                'عمليات',
              ],
              weights: const [4, 4, 1],
              data: state.result
                  .map(
                    (e) => [
                      e.name,
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: DrawableText(
                          size: 12.0.sp,
                          matchParent: true,
                          maxLines: 2,
                          color: e.id.length < 11 ? Colors.amber : null,
                          textAlign: TextAlign.center,
                          text: e.id.secure,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          NoteMessage.showCheckDialog(
                            context,
                            text: 'تأكيد الحذف',
                            textButton: 'حذف',
                            image: ImageMultiType(
                              url: Icons.delete,
                              height: 80.0.r,
                              width: 80.0.r,
                              color: Colors.red,
                            ),
                            onConfirm: () {
                              context.read<NaturalNumbersCubit>().delete(e.id);
                            },
                          );
                        },
                        child: const ImageMultiType(
                          url: Assets.iconsXCancle,
                        ),
                      ),
                    ],
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
