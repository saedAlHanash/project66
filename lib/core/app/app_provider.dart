import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../generated/l10n.dart';
import '../../router/go_router.dart';
import '../strings/enum_manager.dart';
import '../util/shared_preferences.dart';
import '../util/snack_bar_message.dart';
import 'app_widget.dart';

class AppProvider {
  final fcmToken = AppSharedPreference.getFireToken;

  static int get getRemaining =>
      AppSharedPreference.getResendDateTime.difference(DateTime.now()).inSeconds;

  static Future<void> setResendTime(int s) async {
    await AppSharedPreference.setResendDateTime(s);
  }



  static bool get isLogin => AppSharedPreference.getToken.isNotEmpty;

  static bool get isNotLogin => !isLogin;

  static bool get isShowIntro => AppSharedPreference.isShowIntro;

  static bool get needLogin {
    if (isNotLogin) {
      if (ctx != null) {
        NoteMessage.showCheckDialog(
          ctx!,
          text: S.of(ctx!).needLogin,
          textButton: S.of(ctx!).login,
          image: Icons.login,
          onConfirm: () {
            ctx!.pushNamed(RouteName.login);
            // Navigator.pushNamed(ctx!, RouteName.login);
          },
        );
      }
      return true;
    }
    return false;
  }


  static bool? get isSignupCashed {
    if (AppSharedPreference.getStartPage == StartPage.signupOtp) return true;
    if (AppSharedPreference.getStartPage == StartPage.passwordOtp) return false;
    return null;
  }

  static Future<void> logout() async {
    if (AppSharedPreference.getToken.isEmpty) return;
    await AppSharedPreference.logout();
    if (ctx == null) return;
    ctx!.goNamed(RouteName.login);
  }

  static Future<void> cachePhone({required String phone, required StartPage type}) async {
    await AppSharedPreference.cashPhone(phone);
    await AppSharedPreference.cashStartPage(type);
  }

  static String get getPhoneCached => AppSharedPreference.getPhone;
}

StartPage get getStartPage {
  if (AppProvider.isLogin) return StartPage.home;

  return AppSharedPreference.getStartPage;
}
