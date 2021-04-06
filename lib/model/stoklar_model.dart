// To parse this JSON data, do
//
//     final stoklarModel = stoklarModelFromJson(jsonString);

import 'dart:convert';

List<StoklarModel> stoklarModelFromJson(String str) => List<StoklarModel>.from(
    json.decode(str).map((x) => StoklarModel.fromJson(x)));

String stoklarModelToJson(List<StoklarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoklarModel {
  StoklarModel({
    this.stokKodu,
    this.stokAdi,
  });

  String stokKodu;
  String stokAdi;

  factory StoklarModel.fromJson(Map<String, dynamic> json) => StoklarModel(
        stokKodu: json["StokKodu"],
        stokAdi: json["StokAdi"],
      );

  Map<String, dynamic> toJson() => {
        "StokKodu": stokKodu,
        "StokAdi": stokAdi,
      };
}
