import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';

import '../../app/app_provider.dart';
import '../../strings/enum_manager.dart';

class FilterRequest {
  FilterRequest({
    Map<String, Filter>? filters,
    List<OrderBy>? orderBy,
    this.pageableQuery,
    this.tripId,
    this.memberId,
  })  : filters = filters ?? {},
        orderBy = orderBy ?? [];

  Map<String, Filter> filters = {};
  List<OrderBy> orderBy = [];
  PageableQuery? pageableQuery;
  String? tripId;
  String? memberId;

  void addFilter(Filter f) {
    filters[f.name] = f;
  }

  bool get isSorted => orderBy.isNotEmpty == true;

  int get sortedCount => orderBy.length;

  bool get isFiltered => filters.isNotEmpty == true;

  int get filteredCount => filters.length;

  bool get isSearch =>
      isFiltered &&
      filters.keys.firstWhereOrNull((e) => e.toLowerCase().contains('name')) != null;


  factory FilterRequest.bank({required String bankId}) {
    return FilterRequest(
      filters: {
        'bankId': Filter(
            name: 'bankId', val: bankId.toString(), operation: FilterOperation.equals),
      },
    );
  }

  // factory FilterRequest.fromJson(Map<String, dynamic> json) {
  //   return FilterRequest(
  //     memberId: json['memberId'],
  //     tripId: json['tripId'],
  //     filters: json["filters"] == null
  //         ? []
  //         : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
  //     orderBy: json["orderBy"] == null
  //         ? []
  //         : List<OrderBy>.from(json["orderBy"]!.map((x) => OrderBy.fromJson(x))),
  //     pageableQuery: json["pageableQuery"] == null
  //         ? null
  //         : PageableQuery.fromJson(json["pageableQuery"]),
  //   );
  // }

  Map<String, dynamic> toJson() => {
        "filters": filters.values.map((x) {
          if (x.name.startsWith('_')) {
            x.name = x.name.replaceFirst('_', '');
          }
          return x.toJson();
        }).toList(),
        "orderBy": orderBy.map((x) => x.toJson()).toList(),
        "pageableQuery": pageableQuery?.toJson(),
        "tripId": tripId,
        "memberId": memberId,
      };

  String get getKey {
    var jsonString = jsonEncode(this);
    var bytes = utf8.encode(jsonString);
    var digest = sha1.convert(bytes);

    return '$digest';
  }

  FilterOrderBy? findOrderKey(String id) =>
      orderBy.firstWhereOrNull((e) => e.attribute == id)?.direction;
}

class Filter {
  Filter({
    required this.name,
    required this.val,
    required this.operation,
  });

  String name;
  final String val;
  final FilterOperation operation;

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      name: json["name"] ?? "",
      val: json["val"] ?? "",
      operation: FilterOperation.byName(json["operation"] ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "val": val,
        "operation": operation.realName,
      };
}

class OrderBy {
  OrderBy({
    required this.attribute,
    required this.direction,
  });

  final String attribute;
  final FilterOrderBy direction;

  factory OrderBy.fromJson(Map<String, dynamic> json) {
    return OrderBy(
      attribute: json["attribute"] ?? "",
      direction: FilterOrderBy.values[(json["direction"] ?? 0)],
    );
  }

  Map<String, dynamic> toJson() => {
        "attribute": attribute,
        "direction": direction.name,
      };
}

class PageableQuery {
  PageableQuery({
    required this.pageNumer,
    required this.pageSize,
  });

  final num pageNumer;
  final num pageSize;

  factory PageableQuery.fromJson(Map<String, dynamic> json) {
    return PageableQuery(
      pageNumer: json["pageNumer"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "pageNumer": pageNumer,
        "pageSize": pageSize,
      };
}
