import 'package:http/http.dart';
import 'package:project66/core/api_manager/api_service.dart';
import 'package:project66/core/app/app_provider.dart';
import 'package:project66/core/extensions/extensions.dart';

import '../../generated/l10n.dart';
import '../app/app_widget.dart';
import '../util/abstraction.dart';
import '../util/snack_bar_message.dart';

class ErrorManager {
  static String getApiError(Response response) {
    switch (response.statusCode) {
      case 401:
        AppProvider.logout();
        return '${S().userLogout} ${response.statusCode}';

      case 503:
        return '${S().serverSideError} ${response.statusCode}';
      case 481:
        return '${response.body} ${response.statusCode}';
      case 482:
        return '${S().noInternet} ${response.statusCode}';

      case 404:
      case 500:
      default:
        final errorBody = ErrorBody.fromJson(response.jsonBody);
        return '${errorBody.message}\n ${response.statusCode}';
    }
  }
}

class ErrorBody {
  ErrorBody({
    required this.statusCode,
    required this.handled,
    required this.message,
    required this.detail,
    required this.extensions,
  });

  final num statusCode;
  final bool handled;
  final String message;
  final dynamic detail;
  final Extensions? extensions;

  factory ErrorBody.fromJson(Map<String, dynamic> json) {
    return ErrorBody(
      statusCode: json["statusCode"] ?? 0,
      handled: json["handled"] ?? false,
      message: json["message"] ?? "",
      detail: json["detail"],
      extensions:
          json["extensions"] == null ? null : Extensions.fromJson(json["extensions"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "handled": handled,
        "message": message,
        "detail": detail,
        "extensions": extensions?.toJson(),
      };
}

class Extensions {
  Extensions({
    required this.traceId,
  });

  final String traceId;

  factory Extensions.fromJson(Map<String, dynamic> json) {
    return Extensions(
      traceId: json["traceId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "traceId": traceId,
      };
}

bool _isSnackBarShowing = false;

showErrorFromApi(AbstractState state) {

  if (ctx == null) return;
  if (state.error.contains('482') ||
      state.error.contains('481') ||
      state.error.contains('401')) {
    if (_isSnackBarShowing) return;
    _isSnackBarShowing = true;
    NoteMessage.showErrorSnackBar(
      message: state.error,
      context: ctx!,
      onCancel: () => _isSnackBarShowing = false,
    );
    return;
  }

  NoteMessage.showAwesomeError(context: ctx!, message: state.error);
}
