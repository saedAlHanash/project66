part of 'natural_numbers_cubit.dart';

class NaturalNumbersInitial extends AbstractState<List<NaturalNumber>> {
  final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream;

  const NaturalNumbersInitial({
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

  factory NaturalNumbersInitial.initial() {
    return const NaturalNumbersInitial(
      result: <NaturalNumber>[],
      statuses: CubitStatuses.init,
    );
  }

  NaturalNumbersInitial copyWith({
    CubitStatuses? statuses,
    List<NaturalNumber>? result,
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream,
  }) {
    return NaturalNumbersInitial(
        statuses: statuses ?? this.statuses,
        result: result ?? this.result,
        stream: stream ?? this.stream);
  }
}
