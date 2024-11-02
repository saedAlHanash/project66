part of 'scan_cubit.dart';

class ScanInitial extends AbstractState<List<ScanModel>> {
  final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream;

  final int x;
  const ScanInitial({
    required super.result,
    super.statuses,
    super.request,
    this.stream,
    required this.x,
  });

  @override
  List<Object?> get props => [
        statuses,
        error,
        result,
        x,
        if (request != null) request,
        if (stream != null) stream,
      ];

  factory ScanInitial.initial() {
    return const ScanInitial(
      result: <ScanModel>[],
      x: 0,
      statuses: CubitStatuses.init,
    );
  }

  ScanInitial copyWith({
    CubitStatuses? statuses,
    List<ScanModel>? result,
    int? x,
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream,
  }) {
    return ScanInitial(
        statuses: statuses ?? this.statuses,
        result: result ?? this.result,
        x: x ?? this.x,
        stream: stream ?? this.stream);
  }
}
