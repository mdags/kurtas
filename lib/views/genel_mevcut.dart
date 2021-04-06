import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:kurtas/model/genel_mevcut_model.dart';
import 'package:kurtas/services/api_services.dart';
import 'package:kurtas/views/genel_mevcut_detay.dart';

class GenelMevcutPage extends StatefulWidget {
  @override
  _GenelMevcutPageState createState() => _GenelMevcutPageState();
}

class _GenelMevcutPageState extends State<GenelMevcutPage> {
  ArsProgressDialog _progressDialog;
  var _list = new List<GenelMevcutModel>();

  void getList() async {
    _progressDialog.show();
    try {
      var data = await ApiServices.fetchGenelMevcut(" ");
      if (data != null) {
        _list = data;
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
      getList();
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
        title: Text('Genel Mevcut'),
      ),
      body: listViewWidget(),
    );
  }

  Widget listViewWidget() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        return itemWidget(_list[index]);
      },
    );
  }

  Widget itemWidget(GenelMevcutModel model) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: RaisedButton(
        elevation: 8,
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => GenelMevcutDetayPage(
                    stokAdi: model.stokAdi,
                    stokId: model.stId,
                  ),
              fullscreenDialog: true));
        },
        padding: EdgeInsets.all(0),
        child: Row(
          children: <Widget>[
            Container(
              height: 125,
              width: 8,
              //color: Variables.kPrimaryColor,
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 70, right: 10),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      model.stokAdi ?? '',
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Palet Sayısı:",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        SizedBox(
                          width: 100.0,
                          child: Text(
                            model.paletSayisi.toString(),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Ort.Fiyat:     ",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        SizedBox(
                          width: 100.0,
                          child: Text(
                            model.ortalamaFiyat.toString(),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Toplam Net:",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        SizedBox(
                          width: 100.0,
                          child: Text(
                            model.evrakNet.toStringAsFixed(0),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
