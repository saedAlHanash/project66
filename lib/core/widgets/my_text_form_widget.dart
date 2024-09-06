import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:project66/core/extensions/extensions.dart';

import '../strings/app_color_manager.dart';

class MyTextFormOutLineWidget extends StatefulWidget {
  const MyTextFormOutLineWidget({
    super.key,
    this.label,
    this.hint = '',
    this.helperText = '',
    this.maxLines = 1,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.maxLength = 1000,
    this.onChanged,
    this.controller,
    this.keyBordType,
    this.innerPadding,
    this.enable,
    this.icon,
    this.color = Colors.black,
    this.initialValue,
    this.textDirection,
    this.validator,
    this.iconWidget,
    this.iconWidgetLift,
    this.onChangedFocus,
    this.onTap,
    this.isRequired = false,
    this.autofillHints,
    this.titleLabel,
  });

  final bool? enable;
  final String? label;
  final String? titleLabel;
  final String hint;
  final String? helperText;
  final dynamic icon;
  final Widget? iconWidget;
  final Widget? iconWidgetLift;
  final Color color;
  final int maxLines;
  final int maxLength;
  final bool obscureText;
  final bool isRequired;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final Function(bool)? onChangedFocus;
  final Function()? onTap;

  final List<String>? autofillHints;

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyBordType;
  final EdgeInsets? innerPadding;
  final String? initialValue;
  final TextDirection? textDirection;

  @override
  State<MyTextFormOutLineWidget> createState() => _MyTextFormOutLineWidgetState();
}

class _MyTextFormOutLineWidgetState extends State<MyTextFormOutLineWidget> {
  FocusNode? focusNode;

  @override
  void initState() {
    if (widget.onChangedFocus != null) {
      focusNode = FocusNode()
        ..addListener(() {
          widget.onChangedFocus!.call(focusNode!.hasFocus);
        });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = widget.innerPadding ??
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0).r;

    bool obscureText = widget.obscureText;
    Widget? suffixIcon;
    Widget? eye;
    VoidCallback? onChangeObscure;

    if (widget.iconWidget != null) {
      suffixIcon = widget.iconWidget!;
    } else if (widget.icon != null) {
      suffixIcon = Padding(
        padding: const EdgeInsets.all(15.0).r,
        child: ImageMultiType(
          url: widget.icon!,
          color: AppColorManager.mainColor,
        ),
      );
    }

    if (obscureText) {
      eye = StatefulBuilder(builder: (context, state) {
        return IconButton(
          splashRadius: 0.01,
          onPressed: () {
            state(() => obscureText = !obscureText);
            if (onChangeObscure != null) onChangeObscure!();
          },
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColorManager.mainColor,
          ),
        );
      });
    }

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColorManager.f9),
      borderRadius: BorderRadius.circular(10.0.r),
    );

    final inputDecoration = InputDecoration(
      contentPadding: padding,
      errorBorder: border,
      border: border,
      focusedBorder: border,
      focusedErrorBorder: border,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      enabledBorder: border,
      error: (widget.validator != null) ? null : 0.0.verticalSpace,
      helperText: widget.helperText,
      helperStyle: const TextStyle(color: Colors.grey),
      fillColor: AppColorManager.f9,
      label: widget.label == null
          ? null
          : DrawableText(
              text: widget.label!,
              color: AppColorManager.grey,
              size: 14.0.spMin,
              drawableEnd: widget.isRequired
                  ? const DrawableText(text: ' *', color: Colors.red)
                  : null,
            ),
      counter: 0.0.verticalSpace,
      hintText: widget.hint,
      filled: true,
      hintStyle: TextStyle(
        color: Colors.grey[400],
        fontSize: 14.0.sp,
        fontFamily: FontManager.cairoSemiBold.name,
      ),
      labelStyle: TextStyle(color: widget.color),
      prefixIcon: widget.iconWidget ?? suffixIcon,
      suffixIcon: widget.iconWidgetLift ?? eye,
    );

    final textStyle = TextStyle(
      fontFamily: FontManager.cairoSemiBold.name,
      fontSize: 15.0.spMin,
      color: Colors.black87,
    );

    return StatefulBuilder(builder: (_, state) {
      onChangeObscure = () => state(() {});
      return Column(
        children: [
          if (widget.titleLabel != null)
            DrawableText(
              text: (widget.titleLabel ?? '').capitalizeFirst,
              size: 14.0.sp,
              fontWeight: FontWeight.w500,
              matchParent: true,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0).r,
              drawableEnd: widget.isRequired
                  ? const DrawableText(text: ' *', color: Colors.red)
                  : null,
            ),
          8.0.verticalSpace,
          TextFormField(
            autofillHints: widget.autofillHints,
            onTap: () => widget.onTap?.call(),
            validator: widget.validator,
            decoration: inputDecoration,
            maxLines: widget.maxLines,
            readOnly: !(widget.enable ?? true),
            initialValue: widget.initialValue,
            obscureText: obscureText,
            textAlign: widget.textAlign,
            onChanged: widget.onChanged,
            style: textStyle,
            focusNode: focusNode,
            textDirection: widget.textDirection,
            maxLength: widget.maxLength,
            controller: widget.controller,
            keyboardType: widget.keyBordType,
          ),
        ],
      );
    });
  }
}
