import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:project66/core/strings/app_color_manager.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../router/go_router.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        context.pushReplacement(RouteName.home);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.mainColor,
      appBar: const AppBarWidget(
        backgroundColor: AppColorManager.mainColor,
        zeroHeight: true,
      ),
      body: SizedBox(
        width: 1.0.sw,
        height: 1.0.sh,
        child: const Center(
          child: ImageMultiType(url: Assets.imagesLogo),
        ),
      ),
    );
  }
}
