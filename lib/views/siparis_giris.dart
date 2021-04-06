import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:kurtas/model/musteriler_model.dart';
import 'package:kurtas/model/siparis_model.dart';
import 'package:kurtas/services/api_services.dart';
import 'package:kurtas/views/siparis_giris_detay.dart';
import 'package:kurtas/widgets/variables.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiparisGirisPage extends StatefulWidget {
  @override
  _SiparisGirisPageState createState() => _SiparisGirisPageState();
}

class _SiparisGirisPageState extends State<SiparisGirisPage> {
  ArsProgressDialog _progressDialog;
  final _formKey = GlobalKey<State>();
  var _musterilerList = new List<MusterilerModel>();
  String cariSelectedValue;
  DateTime siparisTarihi;
  DateTime teslimTarihi;
  String hesaplama = 'Kantar';
  bool devir = false;
  List<SiparisDetayModel> detayList = new List<SiparisDetayModel>();

  getCart() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get("detayList") != null) {
      var decodeList = json.decode(prefs.get("detayList")) as List<dynamic>;
      detayList = decodeList.map((i) => SiparisDetayModel.fromJson(i)).toList();

      setState(() {});
    } else {
      saveCart();
    }
  }

  saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("detayList", json.encode(detayList));
  }

  addCart(SiparisDetayModel detay) {
    SiparisDetayModel findedItem = detayList.firstWhere(
        (element) => element.urunKodu == detay.urunKodu,
        orElse: () => null);
    if (findedItem == null) {
      detayList.add(new SiparisDetayModel(
        urunKodu: detay.urunKodu,
        paletSayisi: detay.paletSayisi,
        miktari: detay.miktari,
        birimFiyati: detay.birimFiyati,
        toplamTutar: detay.toplamTutar,
        paraBirimi: detay.paraBirimi,
        odeme: detay.odeme,
      ));
    } else {}

    saveCart();
    setState(() {});
  }

  removeCart(SiparisDetayModel detay) {
    detayList.remove(detay);
    saveCart();
    setState(() {});
  }

  Future<void> getMusterilerList() async {
    _progressDialog.show();
    try {
      var data = await ApiServices.fetchMusteriler();
      if (data != null) {
        _musterilerList = data;
        setState(() {});
      }
    } finally {
      _progressDialog.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMusterilerList().then((_) => getCart());
    });
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ArsProgressDialog(context,
        blur: 2,
        dismissable: false,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 800),
        loadingWidget: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Image.asset(
            "assets/images/loader.gif",
            width: 50.0,
            height: 50,
          ),
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Sipariş Girişi'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            formWidget(),
            Divider(),
            detailsWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: Variables.kPrimaryColor,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        color: Variables.kPrimaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Container(
          height: 25.0,
        ),
      ),
    );
  }

  Widget formWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Material(
            color: Colors.white,
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            child: SearchableDropdown(
              items: _musterilerList
                  .map<DropdownMenuItem<String>>((MusterilerModel value) {
                return DropdownMenuItem<String>(
                    value: value.kodu, child: Text(value.adi));
              }).toList(),
              value: cariSelectedValue,
              hint: Text('...Müşteri Seçiniz...'),
              label: Text(''),
              closeButton: 'Kapat',
              isExpanded: true,
              isCaseSensitiveSearch: false,
              displayClearIcon: true,
              searchHint: new Text(
                'Müşteri Seçiniz ',
                style: new TextStyle(fontSize: 20),
              ),
              onChanged: (value) {
                setState(() {
                  cariSelectedValue = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  child: DateTimeField(
                    selectedDate: siparisTarihi,
                    label: 'Sipariş Tarihi',
                    dateFormat: DateFormat('dd.MM.yyyy'),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.date_range_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    onDateSelected: (DateTime date) {
                      setState(() {
                        siparisTarihi = date;
                      });
                    },
                    lastDate: DateTime(2021),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  child: DateTimeField(
                    selectedDate: teslimTarihi,
                    label: 'Teslim Tarihi',
                    dateFormat: DateFormat('dd.MM.yyyy'),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.date_range_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    onDateSelected: (DateTime date) {
                      setState(() {
                        teslimTarihi = date;
                      });
                    },
                    lastDate: DateTime(2021),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Material(
            color: Colors.transparent,
            elevation: 8,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Açıklama",
                hintStyle: new TextStyle(color: Colors.grey[800]),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Material(
            color: Colors.transparent,
            elevation: 8,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Proforma Açıklama",
                hintStyle: new TextStyle(color: Colors.grey[800]),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  child: DropdownButtonFormField<String>(
                    value: hesaplama,
                    decoration: InputDecoration(
                      hintText: "Proforma Açıklama",
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    items: ["Kantar", "Palet"]
                        .map((label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        hesaplama = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Material(
                elevation: 8,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 63.0,
                  width: 120,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Devir:"),
                      Checkbox(
                          value: devir,
                          onChanged: (value) {
                            setState(() {
                              devir = value;
                            });
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detailsWidget() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          height: 40.0,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'KALEMLER',
                    style: TextStyle(
                        color: Variables.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Spacer(),
                  ClipOval(
                    child: Material(
                      color: Variables.kPrimaryColor,
                      child: InkWell(
                        onTap: () async {
                          SiparisDetayModel detay = await Navigator.of(context)
                              .push(new MaterialPageRoute(
                                  builder: (context) => SiparisGirisDetayPage(),
                                  fullscreenDialog: true));
                          if (detay != null) {
                            detayList.add(detay);
                            setState(() {});
                          }
                        },
                        splashColor: Colors.white,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        listViewWidget(),
      ],
    );
  }

  Widget listViewWidget() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 16.0),
      itemCount: detayList.length,
      itemBuilder: (context, index) {
        return itemWidget(detayList[index]);
      },
    );
  }

  Widget itemWidget(SiparisDetayModel item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 8,
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: 150.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        item.urunAdi,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Pl. Say.: ' +
                              item.paletSayisi.toString() +
                              ' ad.'),
                          Text('Br. Fiyat: ' +
                              item.birimFiyati.toStringAsFixed(2) +
                              ' USD'),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Top. Tutar: ' +
                              item.toplamTutar.toStringAsFixed(2) +
                              ' USD'),
                          Text('Ödeme: ' + item.odeme),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () => removeCart(item),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.0))),
                        child: Text(
                          "Sil",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(
                                builder: (context) => SiparisGirisDetayPage(
                                      model: item,
                                    ),
                                fullscreenDialog: true))
                            .then((_) => setState(() {}));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5.0))),
                        child: Text(
                          "Düzenle",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
