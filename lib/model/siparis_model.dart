class SiparisModel {
  List<SiparisDetayModel> siparisDetayModel;
  int mSID;
  int siparisNo;
  String cariKodu;
  String aciklama;
  String siparisTarihi;
  String teslimTarihi;
  String cDate;
  String p1;
  String p2;
  String p3;
  String hesaplama;
  bool devir;
  bool proformaAciklama;

  SiparisModel(
      {this.siparisDetayModel,
      this.mSID,
      this.siparisNo,
      this.cariKodu,
      this.aciklama,
      this.siparisTarihi,
      this.teslimTarihi,
      this.cDate,
      this.p1,
      this.p2,
      this.p3,
      this.hesaplama,
      this.devir,
      this.proformaAciklama});

  SiparisModel.fromJson(Map<String, dynamic> json) {
    if (json['SiparisDetay'] != null) {
      siparisDetayModel = new List<SiparisDetayModel>();
      json['SiparisDetay'].forEach((v) {
        siparisDetayModel.add(new SiparisDetayModel.fromJson(v));
      });
    }
    mSID = json['MS_ID'];
    siparisNo = json['SiparisNo'];
    cariKodu = json['CariKodu'];
    aciklama = json['Aciklama'];
    siparisTarihi = json['SiparisTarihi'];
    teslimTarihi = json['TeslimTarihi'];
    cDate = json['CDate'];
    p1 = json['P1'];
    p2 = json['P2'];
    p3 = json['P3'];
    hesaplama = json['Hesaplama'];
    devir = json['Devir'];
    proformaAciklama = json['ProformaAciklama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.siparisDetayModel != null) {
      data['SiparisDetay'] =
          this.siparisDetayModel.map((v) => v.toJson()).toList();
    }
    data['MS_ID'] = this.mSID;
    data['SiparisNo'] = this.siparisNo;
    data['CariKodu'] = this.cariKodu;
    data['Aciklama'] = this.aciklama;
    data['SiparisTarihi'] = this.siparisTarihi;
    data['TeslimTarihi'] = this.teslimTarihi;
    data['CDate'] = this.cDate;
    data['P1'] = this.p1;
    data['P2'] = this.p2;
    data['P3'] = this.p3;
    data['Hesaplama'] = this.hesaplama;
    data['Devir'] = this.devir;
    data['ProformaAciklama'] = this.proformaAciklama;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "MS_ID": mSID,
      "SiparisNo": siparisNo,
      "CariKodu": cariKodu,
      "Aciklama": aciklama,
      "SiparisTarihi": siparisTarihi,
      "TeslimTarihi": teslimTarihi,
      "CDate": cDate,
      "P1": p1,
      "P2": p2,
      "P3": p3,
      "Hesaplama": hesaplama,
      "Devir": devir,
      "ProformaAciklama": proformaAciklama,
      "SiparisDetay": this.siparisDetayModel.map((v) => v.toJson()).toList()
    };
  }
}

class SiparisDetayModel {
  int mSDID;
  int mSID;
  String urunKodu;
  String urunAdi;
  int paletSayisi;
  double miktari;
  double birimFiyati;
  double toplamTutar;
  String paraBirimi;
  String odeme;

  SiparisDetayModel(
      {this.mSDID,
      this.mSID,
      this.urunKodu,
      this.urunAdi,
      this.paletSayisi,
      this.miktari,
      this.birimFiyati,
      this.toplamTutar,
      this.paraBirimi,
      this.odeme});

  SiparisDetayModel.fromJson(Map<String, dynamic> json) {
    mSDID = json['MSD_ID'];
    mSID = json['MS_ID'];
    urunKodu = json['UrunKodu'];
    urunAdi = json['UrunAdi'];
    paletSayisi = json['PaletSayisi'];
    miktari = json['Miktari'];
    birimFiyati = json['BirimFiyati'];
    toplamTutar = json['ToplamTutar'];
    paraBirimi = json['ParaBirimi'];
    odeme = json['Odeme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MSD_ID'] = this.mSDID;
    data['MS_ID'] = this.mSID;
    data['UrunKodu'] = this.urunKodu;
    data['UrunAdi'] = this.urunAdi;
    data['PaletSayisi'] = this.paletSayisi;
    data['Miktari'] = this.miktari;
    data['BirimFiyati'] = this.birimFiyati;
    data['ToplamTutar'] = this.toplamTutar;
    data['ParaBirimi'] = this.paraBirimi;
    data['Odeme'] = this.odeme;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "MSD_ID": mSDID,
      "MS_ID": mSID,
      "UrunKodu": urunKodu,
      "UrunAdi": urunAdi,
      "PaletSayisi": paletSayisi,
      "Miktari": miktari,
      "BirimFiyati": birimFiyati,
      "ToplamTutar": toplamTutar,
      "ParaBirimi": paraBirimi,
      "Odeme": odeme,
    };
  }
}
