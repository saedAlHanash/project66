part of 'scan_cubit.dart';

class ScanInitial extends AbstractState<List<ScanModel>> {
  final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream;

  const ScanInitial({
    required super.result,
    super.statuses,
    super.request,
    this.stream,
  });

  @override
  List<Object?> get props => [
        statuses,
        error,
        result,
        if (request != null) request,
        if (stream != null) stream,
      ];

  factory ScanInitial.initial() {
    return const ScanInitial(
      result: <ScanModel>[],
      statuses: CubitStatuses.init,
    );
  }

  ScanInitial copyWith({
    CubitStatuses? statuses,
    List<ScanModel>? result,
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream,
  }) {
    return ScanInitial(
        statuses: statuses ?? this.statuses,
        result: result ?? this.result,
        stream: stream ?? this.stream);
  }
}
