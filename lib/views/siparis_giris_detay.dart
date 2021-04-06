import 'package:flutter/material.dart';
import 'package:kurtas/model/siparis_model.dart';
import 'package:kurtas/model/stoklar_model.dart';
import 'package:kurtas/services/api_services.dart';
import 'package:kurtas/widgets/variables.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';

class SiparisGirisDetayPage extends StatefulWidget {
  final SiparisDetayModel model;

  SiparisGirisDetayPage({this.model});

  @override
  _SiparisGirisDetayPageState createState() => _SiparisGirisDetayPageState();
}

class _SiparisGirisDetayPageState extends State<SiparisGirisDetayPage> {
  ArsProgressDialog _progressDialog;
  final _formKey = GlobalKey<State>();
  var _stoklarList = new List<StoklarModel>();
  StoklarModel stokSelectedValue;
  final txtPaletSayisi = new TextEditingController(text: "0");
  final txtBirimFiyat = new TextEditingController(text: "0");
  final txtMiktar = new TextEditingController(text: "0");
  final txtToplamTutar = new TextEditingController(text: "0");
  String paraBirimi = 'USD';
  String odemeTipi = 'Peşin';

  Future<void> getStoklarList() async {
    _progressDialog.show();

    var data = await ApiServices.fetchStoklar();
    if (data != null) {
      _stoklarList = data;

      setState(() {});
      _progressDialog.dismiss();
    } else {
      _progressDialog.dismiss();
    }
  }

  void save() {
    SiparisDetayModel detay;
    if (widget.model == null) {
      detay = new SiparisDetayModel(
          urunKodu: stokSelectedValue.stokKodu,
          urunAdi: stokSelectedValue.stokAdi,
          paraBirimi: paraBirimi,
          odeme: odemeTipi,
          paletSayisi: int.parse(txtPaletSayisi.text),
          miktari: double.parse(txtMiktar.text),
          birimFiyati: double.parse(txtBirimFiyat.text),
          toplamTutar: double.parse(txtToplamTutar.text));
    } else {
      detay = widget.model;
      detay.urunKodu = stokSelectedValue.stokKodu;
      detay.urunAdi = stokSelectedValue.stokAdi;
      detay.paraBirimi = paraBirimi;
      detay.odeme = odemeTipi;
      detay.paletSayisi = int.parse(txtPaletSayisi.text);
      detay.miktari = double.parse(txtMiktar.text);
      detay.birimFiyati = double.parse(txtBirimFiyat.text);
      detay.toplamTutar = double.parse(txtToplamTutar.text);
    }
    Navigator.of(context).pop(detay);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getStoklarList().then((_) => {
            if (widget.model != null)
              {
                stokSelectedValue = _stoklarList.firstWhere(
                    (element) => element.stokKodu == widget.model.urunKodu,
                    orElse: () => null),
                txtPaletSayisi.text = widget.model.paletSayisi.toString(),
                txtBirimFiyat.text = widget.model.birimFiyati.toString(),
                txtMiktar.text = widget.model.miktari.toString(),
                txtToplamTutar.text = widget.model.toplamTutar.toString(),
                paraBirimi = widget.model.paraBirimi,
                odemeTipi = widget.model.odeme,
              }
          });
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
        title: Text('Ürün Ekle'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: formWidget(),
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
              items: _stoklarList
                  .map<DropdownMenuItem<StoklarModel>>((StoklarModel value) {
                return DropdownMenuItem<StoklarModel>(
                  value: value,
                  child: Text(value.stokAdi),
                );
              }).toList(),
              value: stokSelectedValue,
              hint: Text('...Stok Seçiniz...'),
              label: Text(''),
              closeButton: 'Kapat',
              isExpanded: true,
              isCaseSensitiveSearch: true,
              displayClearIcon: true,
              searchHint: new Text(
                'Stok Seçiniz ',
                style: new TextStyle(fontSize: 20),
              ),
              onChanged: (value) {
                setState(() {
                  stokSelectedValue = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  elevation: 8,
                  child: TextFormField(
                    controller: txtPaletSayisi,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Palet Sayısı",
                      labelStyle: new TextStyle(color: Colors.grey[800]),
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
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  elevation: 8,
                  child: TextFormField(
                    controller: txtBirimFiyat,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Br.Fiyat/Ton",
                      labelStyle: new TextStyle(color: Colors.grey[800]),
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
                    onChanged: (value) {
                      txtToplamTutar.text =
                          (double.parse(value) * double.parse(txtMiktar.text))
                              .toString();
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  elevation: 8,
                  child: TextFormField(
                    controller: txtMiktar,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Miktar/Ton",
                      labelStyle: new TextStyle(color: Colors.grey[800]),
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
                    onChanged: (value) {
                      txtToplamTutar.text = (double.parse(value) *
                              double.parse(txtBirimFiyat.text))
                          .toString();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  elevation: 8,
                  child: TextFormField(
                    controller: txtToplamTutar,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Toplam Tutar",
                      labelStyle: new TextStyle(color: Colors.grey[800]),
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
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  child: DropdownButtonFormField<String>(
                    value: paraBirimi,
                    decoration: InputDecoration(
                      hintText: "Para Birimi",
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
                    items: ["TL", "USD", "EUR", "GBP"]
                        .map((label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        paraBirimi = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Material(
                  elevation: 8,
                  color: Colors.transparent,
                  child: DropdownButtonFormField<String>(
                    value: odemeTipi,
                    decoration: InputDecoration(
                      hintText: "Ödeme Tipi",
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
                    items: ["Peşin", "Vadeli"]
                        .map((label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        odemeTipi = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    color: Variables.kPrimaryColor,
                    onPressed: () => save(),
                    child: Text(
                      "KAYDET",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
