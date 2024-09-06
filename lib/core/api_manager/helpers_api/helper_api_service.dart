import 'dart:math';

import 'package:http/http.dart' as http;

import '../../../generated/l10n.dart';
import '../../strings/enum_manager.dart';
import '../api_url.dart';
import 'log_api.dart';

DateTime? serverDateTime;

const connectionTimeOut = Duration(seconds: 240);

final anError = http.Response(S().anErrorWithYourNetwork, 481);

final timeOut = http.Response(S().connectionTimeOut, 482);

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
final _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
    Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

void fixQuery(Map<String, dynamic>? query) {
  query?.removeWhere((key, value) {
    if (value == null || value.toString().isEmpty) return true;

    if ((key.toLowerCase() == 'id' || key.contains('Id')) &&
        ((value is int && value == 0) || (value is String && value.isEmpty))) {
      return true;
    }

    return false;
  });

  query?.forEach((key, value) => query[key] = value.toString());
}

Map<String, String> fixFields(Map<String, dynamic>? fields) {
  fields?.removeWhere((key, value) {
    if (value == null || value.toString().isEmpty) return true;

    if ((key.toLowerCase() == 'id' || key.contains('Id')) &&
        ((value is int && value == 0) || (value is String && value.isEmpty))) {
      return true;
    }

    return false;
  });

  final mapStringString = <String, String>{};
  fields?.forEach((key, value) {
    mapStringString[key] = value.toString();
  });
  return mapStringString;
}

void fixBody(Map? body) {
  body?.removeWhere((key, value) {
    if (value == null || value.toString().isEmpty) return true;

    if (value is Map) {
      fixBody(value);
    }

    if (value is List<Map>) {
      for (var e in value) {
        fixBody(e);
      }
    }

    if ((key.toString().toLowerCase() == 'id' || key.toString().contains('Id')) &&
        ((value is int && value == 0) || (value is String && value.isEmpty))) {
      return true;
    }

    return false;
  });
}

void fixPath(String url, String? path) {
  if (path != null) url = '$url/$path';
}

Uri getUri({
  required String url,
  required ApiType type,
  Map<String, dynamic>? query,
  Map<String, dynamic>? body,
  String? path,
}) {
  url = additionalConst + url;

  if (path != null) url = '$url/$path';

  final uri = Uri.https(baseUrl, url, query);

  logRequest(
      type: type,
      url: url,
      q: {}
        ..addAll(query ?? {})
        ..addAll(body ?? {}));
  return uri;
}
