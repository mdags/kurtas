// To parse this JSON data, do
//
//     final musterilerModel = musterilerModelFromJson(jsonString);

import 'dart:convert';

List<MusterilerModel> musterilerModelFromJson(String str) =>
    List<MusterilerModel>.from(
        json.decode(str).map((x) => MusterilerModel.fromJson(x)));

String musterilerModelToJson(List<MusterilerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MusterilerModel {
  MusterilerModel({
    this.kodu,
    this.adi,
  });

  String kodu;
  String adi;

  factory MusterilerModel.fromJson(Map<String, dynamic> json) =>
      MusterilerModel(
        kodu: json["Kodu"],
        adi: json["Adi"],
      );

  Map<String, dynamic> toJson() => {
        "Kodu": kodu,
        "Adi": adi,
      };
}
