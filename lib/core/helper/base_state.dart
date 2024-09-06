import '../../features/z_temp/data/response/temp_response.dart';
import '../strings/enum_manager.dart';
import '../util/abstraction.dart';

class BaseInitial extends AbstractState<Temp> {
  final String tempId;

  const BaseInitial({
    required super.result,
    super.error,
    required this.tempId,
    // required this.tempParam,
    super.statuses,
  });

  factory BaseInitial.initial() {
    return BaseInitial(
      result: Temp.fromJson({}),
      error: '',
      // tempParam: false,
      tempId: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
        if (filterRequest != null) filterRequest!
      ];

  BaseInitial copyWith({
    CubitStatuses? statuses,
    Temp? result,
    String? error,
    String? tempId,
    // bool? tempParam,
  }) {
    return BaseInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      tempId: tempId ?? this.tempId,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
