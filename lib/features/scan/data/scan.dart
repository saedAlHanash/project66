import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project66/core/api_manager/api_service.dart';

class NaturalNumber {
  NaturalNumber({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  final String name;
  final int createdAt;
  final int updatedAt;

  final String id;

  factory NaturalNumber.fromJson(Map<String, dynamic> json) {
    return NaturalNumber(
      name: json["name"] ?? "",
      createdAt: (json["createdAt"] is int)
          ? json['createdAt']
          : ((json["createdAt"] ?? Timestamp.fromMillisecondsSinceEpoch(0)) as Timestamp)
              .millisecondsSinceEpoch,
      updatedAt: (json["updatedAt"] is int)
          ? json['updatedAt']
          : ((json["updatedAt"] ?? Timestamp.fromMillisecondsSinceEpoch(0)) as Timestamp)
              .millisecondsSinceEpoch,
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
      };
}

class ScanModel {
  ScanModel({
    required this.scanNumber,
    this.isDeleted = false,
    required this.idNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.amount,
    required this.name,
    required this.storeVersion,
    required this.id,
  });

  final num scanNumber;
  final String idNumber;
  final num amount;
  String name;
  final num id;
  final num storeVersion;
  final bool isDeleted;
  final int createdAt;
  final int updatedAt;

  Color get getColor => (amount.toString().length <= 6)
      ? Colors.black45
      : (amount.toString().length <= 9)
          ? Colors.black
          : Colors.black;

  factory ScanModel.fromJson(Map<String, dynamic> json) {
    return ScanModel(
      id: num.tryParse(json["scanNumber"] ?? '0') ?? 0,
      storeVersion: json["storeVersion"] ?? 0,
      isDeleted: json["isDeleted"] ?? false,
      scanNumber: num.tryParse(json["scanNumber"] ?? '0') ?? 0,
      idNumber: json["idNumber"] ?? "",
      createdAt: (json["createdAt"] is int)
          ? json['createdAt']
          : ((json["createdAt"] ?? Timestamp.fromMillisecondsSinceEpoch(0)) as Timestamp)
              .millisecondsSinceEpoch,
      updatedAt: (json["updatedAt"] is int)
          ? json['updatedAt']
          : ((json["updatedAt"] ?? Timestamp.fromMillisecondsSinceEpoch(0)) as Timestamp)
              .millisecondsSinceEpoch,
      amount: num.tryParse(json["amount"] ?? '0') ?? 0,
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": scanNumber.toString(),
        "isDeleted": isDeleted,
        "storeVersion": storeVersion,
        "scanNumber": scanNumber.toString(),
        "idNumber": idNumber,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "amount": amount.toString(),
        "name": name,
      };
}
