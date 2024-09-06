import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../strings/app_color_manager.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.textColor,
    this.width,
    this.shadowColor,
    this.height,
    this.enable = true,
    this.loading = false,
    this.bold = true,
    this.padding,
    this.icon,
    this.iconStart,
    this.borderColor,
    this.overlayColor,
    this.radios,
  });

  final Widget? child;
  final String text;
  final Color? textColor;
  final Color? overlayColor;
  final Color? color;
  final Color? shadowColor;
  final Color? borderColor;
  final double? elevation;
  final double? width;
  final double? height;
  final bool enable;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool loading;
  final bool bold;
  final dynamic icon;
  final dynamic iconStart;
  final double? radios;

  factory MyButton.outline(
      {String text = '',
      dynamic icon,
      dynamic iconStart,
      Function()? onTap,
      Color? borderColor,
      double? width,
      double? height,
      EdgeInsets? padding}) {
    return MyButton(
      text: text,
      onTap: onTap,
      width: width,
      height: height,
      color: Colors.white,
      padding: padding,
      elevation: 0,
      borderColor: borderColor ?? AppColorManager.mainColor,
      textColor: borderColor ?? AppColorManager.mainColor,
      icon: icon,
      bold: false,
      overlayColor: AppColorManager.cardColor,
      iconStart: iconStart,
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text: text,
          color: textColor ?? AppColorManager.whit,
          fontFamily: bold ? FontManager.cairoBold.name : null,
          drawablePadding: 5.0.w,
          drawableEnd: loading
              ? SizedBox(
                  height: 15.0.r,
                  width: 15.0.r,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: color,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      color == Colors.white ? AppColorManager.mainColor : Colors.white,
                    ),
                  ),
                )
              : icon == null
                  ? null
                  : (icon is Widget)
                      ? icon
                      : ImageMultiType(
                          url: icon,
                          color: textColor ?? Colors.white,
                          height: 24.0.r,
                          width: 24.0.r,
                        ),
          drawableStart: iconStart == null
              ? null
              : ImageMultiType(
                  url: iconStart,
                  color: textColor ?? Colors.white,
                ),
          size: 15.0.sp,
        );
    return Container(
      width: width ?? .9.sw,
      height: height,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(radios??8),
      //   gradient: LinearGradient(
      //     begin: Alignment(-1.00, -0.00),
      //     end: Alignment(1, 0),
      //     colors: [Color(0xFFB638E2), Color(0xFF7E3996)],
      //   ),
      // ),
      child: ElevatedButton(
        style: ButtonStyle(
          surfaceTintColor: WidgetStatePropertyAll(color),
          backgroundColor: enable
              ? WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return color?.withOpacity(0.8);
                    }
                    return color; // Use the component's default;
                  },
                )
              : WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    return Colors.grey[500]; // Use the component's default;
                  },
                ),
          overlayColor: WidgetStatePropertyAll(overlayColor),
          elevation: WidgetStatePropertyAll((enable == false) ? 0 : elevation),
          shadowColor: WidgetStatePropertyAll(shadowColor),
          padding: WidgetStatePropertyAll(padding ?? EdgeInsets.zero),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radios ?? 8.0.r),
              side: borderColor == null
                  ? BorderSide.none
                  : BorderSide(
                      color: borderColor!,
                    ),
            ),
          ),
          alignment: Alignment.center,
        ),
        onPressed: loading
            ? null
            : !enable
                ? null
                : onTap,
        child: child,
      ),
    );
  }
}
