import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../strings/app_color_manager.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.titleText,
    this.elevation,
    this.zeroHeight,
    this.actions,
    this.title,
    this.backgroundColor,
  });

  final String? titleText;
  final Widget? title;
  final Color? backgroundColor;
  final bool? zeroHeight;
  final double? elevation;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColorManager.whit,
      surfaceTintColor: Colors.white,
      toolbarHeight: (zeroHeight ?? false) ? 0 : 80.0.h,
      title: title ??
          DrawableText(
            textAlign: TextAlign.center,
            text: titleText ?? '',
            size: 20.spMin,
          ),
      leading: context.canPop()
          ? BackBtnWidget(backgroundColor: backgroundColor)
          : null,
      actions: actions,
      foregroundColor: backgroundColor,
      scrolledUnderElevation: 0,
      elevation: elevation ?? 0.0,
      shadowColor: AppColorManager.black.withOpacity(0.28),
      iconTheme: const IconThemeData(color: AppColorManager.mainColor),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(1.0.sw, (zeroHeight ?? false) ? 0 : 80.0.h);
}

class BackBtnWidget extends StatelessWidget {
  const BackBtnWidget({
    super.key,
    this.backgroundColor,
  });

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(backgroundColor ?? Colors.white),
      ),
      onPressed: () => context.canPop() ? context.pop() : null,
      icon: const Icon(
        Icons.arrow_back_ios,
        color: AppColorManager.black,
      ),
    );
  }
}
