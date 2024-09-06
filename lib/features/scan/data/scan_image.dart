class ScanImageModel {
  ScanImageModel({
    required this.sn,
    required this.nn,
    required this.count,
    required this.name,
  });

  final String sn;
  final String nn;
  final String count;
  final String name;

  factory ScanImageModel.fromJson(Map<String, dynamic> json) {
    return ScanImageModel(
      sn: json["sn"] ?? "",
      nn: json["nn"] ?? "",
      count: json["count"] ?? "",
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "sn": sn,
    "nn": nn,
    "count": count,
    "name": name,
  };

  @override
  String toString() {
    return '\n: $sn'
        '\n: $nn'
        '\n: $count'
        '\n: $name';
  }
}