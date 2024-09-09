import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:project66/core/app/app_provider.dart';
import 'package:project66/core/strings/enum_manager.dart';

import '../../core/api_manager/api_service.dart';
import '../../core/util/shared_preferences.dart';
import '../../firebase_options.dart';
import '../../main.dart';

class FirebaseService {
  static Future<void> initial() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      refreshToken(AppSharedPreference.getFireToken);
    } catch (e) {
      loggerObject.e('Firebase.initializeApp: $e');
    }
  }



  static String get getFireTokenFromCache {
    final cashedToken = AppSharedPreference.getFireToken;

    if (cashedToken.isNotEmpty) return cashedToken;

    loggerObject.e('FCM Token Empty');

    throw Exception('FCM Token Empty');
  }

  static void logException(Exception e, StackTrace stackTrace) {
    FirebaseFirestore.instance.collection('Exceptions').add(
      {
        'error': e.toString(),
        'stackTrace': stackTrace.toString(),
        'localDate': DateTime.now().toUtc(),
        'createdAt': FieldValue.serverTimestamp(),
      },
    );
  }

  static void logFromJsonError(Exception e, String model) {
    FirebaseFirestore.instance.collection('FromJsonError').add(
      {
        'error': e.toString(),
        'model': model,
        'localDate': DateTime.now().toUtc(),
        'createdAt': FieldValue.serverTimestamp(),
      },
    );
  }

  static Future<void> logCachingServiceError(JsonUnsupportedObjectError e, String model) async {
    var x = FirebaseFirestore.instance.collection('CachingServiceError');
 await x.add(
      {
        'error': e.toString(),
        'model': model,
        'localDate': DateTime.now().toUtc(),
        'createdAt': FieldValue.serverTimestamp(),
      },
    );
    }



  static void refreshToken(String token) {
    if (AppProvider.isNotLogin || token.isEmpty) return;
    APIService().callApi(
        url: 'User/RefreshDeviceToken',
        type: ApiType.patch,
        body: {'deviceToken': token});
  }
}


class FirebaseNotificationModel {
  FirebaseNotificationModel({
    required this.notification,
    required this.type,
    required this.data,
  });

  final Notification notification;
  final String type;
  final Data data;

  factory FirebaseNotificationModel.fromJson(Map<String, dynamic> json) {
    return FirebaseNotificationModel(
      notification: Notification.fromJson(jsonDecode(json["notification"] ?? {})),
      type: json["Type"] ?? "",
      data: Data.fromJson(jsonDecode(json["data"] ?? {})),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "notification": notification.toJson(),
        "Type": type,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.data,
  });

  final dynamic data;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "data": data,
      };
}

class Notification {
  Notification({
    required this.title,
    required this.body,
    required this.sound,
  });

  final String title;
  final String body;
  final String sound;

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json["Title"] ?? "",
      body: json["Body"] ?? "",
      sound: json["Sound"] ?? "",
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "Title": title,
        "Body": body,
        "Sound": sound,
      };
}
