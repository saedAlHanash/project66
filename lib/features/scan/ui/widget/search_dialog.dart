import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:project66/core/api_manager/api_service.dart';
import 'package:project66/core/extensions/extensions.dart';
import 'package:project66/features/scan/bloc/scan_bloc/scan_cubit.dart';
import 'package:project66/router/go_router.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  ScanCubit get cubit => context.read<ScanCubit>();
  var name = '';
  var id = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanCubit, ScanInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) => context.pop(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0).r,
        child: Column(
          children: [
            ImageMultiType(
              url: Assets.iconsSearch,
              height: 70.0.r,
              color: AppColorManager.mainColor,
              width: 70.0.r,
            ),
            5.0.verticalSpace,
            DrawableText(
              text: 'اسم الشخص الذي تبحث عنه',
              fontFamily: FontManager.cairoBold.name,
              size: 20.0.sp,
            ),
            5.0.verticalSpace,
            MyTextFormOutLineWidget(
              titleLabel: "الاسم",
              onChanged: (p0) => name = p0,
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
                BlocBuilder<ScanCubit, ScanInitial>(
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        if (name.length < 3) return;
                        final list = state.result.where((e) {
                          return e.name.contains(name);
                        }).toList();
                        loggerObject.w(list.length);
                        context.pop();
                        context.pushNamed(RouteName.search,
                            extra: list, queryParameters: {'name': name});
                      },
                      child: DrawableText(
                        text: 'بحث',
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
    );
  }
}
