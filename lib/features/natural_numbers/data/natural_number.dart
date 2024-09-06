import 'package:cloud_firestore/cloud_firestore.dart';

class NaturalNumber {
  NaturalNumber({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.isDeleted = false,
  });

  final String name;
  final int createdAt;
  final int updatedAt;

  final String id;
  final bool isDeleted;

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
      isDeleted: json["isDeleted"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isDeleted": isDeleted,
        "id": id,
      };
}
