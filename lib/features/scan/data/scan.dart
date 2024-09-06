import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    required this.id,
  });

  final String scanNumber;
  final String idNumber;
  final String amount;
  String name;
  final String id;
  final bool isDeleted;
  final int createdAt;
  final int updatedAt;

  Color get getColor => (amount.length <= 6)
      ? Colors.black45
      : (amount.length <= 9)
          ? Colors.black
          : Colors.black;

  factory ScanModel.fromJson(Map<String, dynamic> json) {
    return ScanModel(
      id: json["scanNumber"] ?? "",
      isDeleted: json["isDeleted"] ?? false,
      scanNumber: json["scanNumber"] ?? "",
      idNumber: json["idNumber"] ?? "",
      createdAt: (json["createdAt"] is int)
          ? json['createdAt']
          : ((json["createdAt"] ?? Timestamp.fromMillisecondsSinceEpoch(0)) as Timestamp)
              .millisecondsSinceEpoch,
      updatedAt: (json["updatedAt"] is int)
          ? json['updatedAt']
          : ((json["updatedAt"] ?? Timestamp.fromMillisecondsSinceEpoch(0)) as Timestamp)
              .millisecondsSinceEpoch,
      amount: json["amount"] ?? "",
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": scanNumber,
        "isDeleted": isDeleted,
        "scanNumber": scanNumber,
        "idNumber": idNumber,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "amount": amount,
        "name": name,
      };
}
