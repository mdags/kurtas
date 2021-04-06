// To parse this JSON data, do
//
//     final genelMevcutModel = genelMevcutModelFromJson(jsonString);

import 'dart:convert';

List<GenelMevcutModel> genelMevcutModelFromJson(String str) =>
    List<GenelMevcutModel>.from(
        json.decode(str).map((x) => GenelMevcutModel.fromJson(x)));

String genelMevcutModelToJson(List<GenelMevcutModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GenelMevcutModel {
  GenelMevcutModel({
    this.dosyaNo,
    this.kontratNo,
    this.adi,
    this.stId,
    this.stokAdi,
    this.paletSayisi,
    this.net,
    this.ton,
    this.fiyat,
    this.evrakNet,
    this.ortalamaFiyat,
  });

  String dosyaNo;
  String kontratNo;
  String adi;
  int stId;
  String stokAdi;
  int paletSayisi;
  double net;
  double ton;
  double fiyat;
  double evrakNet;
  int ortalamaFiyat;

  factory GenelMevcutModel.fromJson(Map<String, dynamic> json) =>
      GenelMevcutModel(
        dosyaNo: json["DosyaNo"],
        kontratNo: json["KontratNo"],
        adi: json["Adi"],
        stId: json["ST_ID"],
        stokAdi: json["StokAdi"],
        paletSayisi: json["PaletSayisi"],
        net: json["Net"],
        ton: json["Ton"],
        fiyat: json["Fiyat"].toDouble(),
        evrakNet: json["EvrakNet"],
        ortalamaFiyat: json["OrtalamaFiyat"],
      );

  Map<String, dynamic> toJson() => {
        "DosyaNo": dosyaNo,
        "KontratNo": kontratNo,
        "Adi": adi,
        "ST_ID": stId,
        "StokAdi": stokAdi,
        "PaletSayisi": paletSayisi,
        "Net": net,
        "Ton": ton,
        "Fiyat": fiyat,
        "EvrakNet": evrakNet,
        "OrtalamaFiyat": ortalamaFiyat,
      };
}
