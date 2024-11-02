import 'dart:ffi';

import 'package:go_router/go_router.dart';
import 'package:project66/core/app/app_provider.dart';
import 'package:project66/core/extensions/extensions.dart';
import 'package:project66/core/util/shared_preferences.dart';
import 'package:project66/core/widgets/app_bar/app_bar_widget.dart';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:project66/features/scan/bloc/scan_bloc/scan_cubit.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/util/my_style.dart';
import '../../../../../core/util/snack_bar_message.dart';

import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../services/app_info_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        titleText: 'إعدادات',
      ),
      body: Container(
        height: 1.0.sh,
        width: 1.0.sw,
        margin: const EdgeInsets.symmetric(horizontal: 10.0).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0.r),
          ),
        ),
        child: Column(
          children: [
            10.0.verticalSpace,
            const ImageMultiType(url: Assets.iconsNotch),
            30.0.verticalSpace,
            ItemMenu(
              onTap: () {
                NoteMessage.showMyDialog(
                  context,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0).r,
                    child: Column(
                      children: [
                        const DrawableText(text: 'يرجى اختيار آلية الترتيب'),
                        20.0.verticalSpace,
                        SpinnerWidget(
                          items: SortEnum.values.getSpinnerItems(
                              selectedId: AppSharedPreference.getSortEnum.index),
                          onChanged: (spinnerItem) {
                            AppSharedPreference.cashSortEnum(spinnerItem.item).then(
                              (value) {
                                context.read<ScanCubit>().sort();
                                context.pop();
                              },
                            );
                          },
                          hintText:
                              '${S.of(context).choosing} ${S.of(context).educationalGrade}',
                        ),
                      ],
                    ),
                  ),
                );
              },
              name: 'تغيير آلية الترتيب',
              subTitle: 'اسم,رقم السند,عدد الأسهم,تاريخ الإضافة ',
              image: Assets.iconsSort,
            ),
            ItemMenu(
              onTap: () {
                NoteMessage.showMyDialog(
                  context,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0).r,
                    child: Column(
                      children: [
                        const DrawableText(text: 'إصدار المسح'),
                        20.0.verticalSpace,
                        SpinnerWidget(
                          items: StoreEnum.values.getSpinnerItems(
                              selectedId: AppSharedPreference.getStoreEnum.index),
                          onChanged: (spinnerItem) {
                            AppSharedPreference.cashStoreEnum(spinnerItem.item).then(
                              (value) {
                                context.read<ScanCubit>().sort();
                                setState(() {
                                  context.pop();
                                });
                              },
                            );
                          },
                          hintText:
                              '${S.of(context).choosing} ${S.of(context).educationalGrade}',
                        ),
                      ],
                    ),
                  ),
                );
              },
              name: 'تغيير إصدار المسح( ${AppSharedPreference.getStoreEnum.name})',
              subTitle: 'تنبيه بتغيير اصدار المسح سيتم تغير مكان التخزين ',
              image: Icons.storage,
            ),
            ItemMenu(
              onTap: () {},
              name: S.of(context).notification,
              subTitle: 'إشعارات',
              image: Assets.iconsNotification,
              withD: false,
            ),
            Spacer(),
            ItemMenu(
              onTap: () {},
              name: 'رقم الإصدار',
              subTitle: AppInfoService.fullVersionName,
            ),
            ItemMenu(
              onTap: () {},
              name: 'صمم بواسطة',
              subTitle: 'سعيد الحنش',
              withD: false,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    super.key,
    required this.name,
    required this.subTitle,
    this.image,
    this.trailing,
    this.withD = true,
    this.onTap,
  });

  final String name;

  final String subTitle;

  final dynamic image;
  final Function()? onTap;
  final Widget? trailing;
  final bool withD;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0).w,
      padding: const EdgeInsets.symmetric(vertical: 5.0).r,
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            onTap: () => onTap?.call(),
            leading: image == null
                ? null
                : image is Widget
                    ? image
                    : Container(
                        height: 60.0.r,
                        width: 60.0.r,
                        padding: EdgeInsets.all(15.0).r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColorManager.mainColor,
                        ),
                        child: ImageMultiType(
                          height: 25.0.r,
                          color: Colors.white,
                          width: 25.0.r,
                          url: image,
                        ),
                      ),
            title: DrawableText(
              text: name,
              size: 16.0.sp,
              fontFamily: FontManager.cairoBold.name,
            ),
            subtitle: DrawableText(
              text: subTitle,
              size: 12.0.sp,
              color: Colors.grey,
            ),
            trailing: trailing,
          ),
          if (withD)
            Divider(
              height: 0,
              color: AppColorManager.cardColor,
              endIndent: 20.0.w,
              indent: 20.0.w,
            ),
        ],
      ),
    );
  }
}
