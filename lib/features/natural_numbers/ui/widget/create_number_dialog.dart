import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:project66/core/extensions/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../bloc/natural_numbers/natural_numbers_cubit.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  NaturalNumbersCubit get cubit => context.read<NaturalNumbersCubit>();
  var name = '';
  var id = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<NaturalNumbersCubit, NaturalNumbersInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) => context.pop(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0).r,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ImageMultiType(
                url: Assets.iconsIdNumber,
                height: 70.0.r,
                color: AppColorManager.mainColor,
                width: 70.0.r,
              ),
              5.0.verticalSpace,
              DrawableText(
                text: 'إضافة رقم وطني',
                fontFamily: FontManager.cairoBold.name,
                size: 20.0.sp,
              ),
              5.0.verticalSpace,
              const DrawableText(
                text: 'يرجى التأكد من المعلومات المدخلة بشكل صحيح',
                maxLines: 3,
                textAlign: TextAlign.center,
                color: Colors.grey,
              ),
              20.0.verticalSpace,
              MyTextFormOutLineWidget(
                titleLabel: "الاسم",
                onChanged: (p0) => name = p0,
              ),
              MyTextFormOutLineWidget(
                titleLabel: 'الرقم الوطني',
                onChanged: (p0) => id = p0,
                validator: (p0) {
                  if (context.read<NaturalNumbersCubit>().isFined(p0!)) {
                    return 'الرقم الوطني موجود مسبقا';
                  }

                  if (!p0.isIdNumber) return 'الرقم الوطني غير صحيح';

                  return null;
                },
                keyBordType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: DrawableText(
                      text: 'إلغاء',
                      color: Colors.grey,
                      fontFamily: FontManager.cairoBold.name,
                      size: 14.0.sp,
                    ),
                  ),
                  10.0.horizontalSpace,
                  BlocBuilder<NaturalNumbersCubit, NaturalNumbersInitial>(
                    builder: (context, state) {
                      if (state.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return TextButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          cubit.addNumber(id, name);
                          context.pop();
                        },
                        child: DrawableText(
                          text: 'إضافة',
                          color: AppColorManager.mainColor,
                          fontFamily: FontManager.cairoBold.name,
                          size: 14.0.sp,
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
