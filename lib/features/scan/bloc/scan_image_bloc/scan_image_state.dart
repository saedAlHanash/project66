part of 'scan_image_bloc.dart';

class ScanImageInitial extends AbstractState<List<ScanImageModel>> {
  const ScanImageInitial({
    required super.result,
    super.statuses,
    super.request,
  });

  factory ScanImageInitial.initial() {
    return const ScanImageInitial(
      result: <ScanImageModel>[],
      statuses: CubitStatuses.init,
    );
  }

  ScanImageInitial copyWith({
    CubitStatuses? statuses,
    List<ScanImageModel>? result,
  }) {
    return ScanImageInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
        statuses,
        error,
        result,
        if (request != null) request,
      ];
}
