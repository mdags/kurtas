import 'package:flutter/material.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:kurtas/model/genel_mevcut_model.dart';
import 'package:kurtas/services/api_services.dart';

class GenelMevcutDetayPage extends StatefulWidget {
  final String stokAdi;
  final int stokId;

  GenelMevcutDetayPage({this.stokAdi, this.stokId});

  @override
  _GenelMevcutDetayPageState createState() => _GenelMevcutDetayPageState();
}

class _GenelMevcutDetayPageState extends State<GenelMevcutDetayPage> {
  ArsProgressDialog _progressDialog;
  var _list = new List<GenelMevcutModel>();

  Future<void> getList() async {
    _progressDialog.show();

    try {
      var data = await ApiServices.fetchGenelMevcutDetay(" ", widget.stokId);
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
        title: Text(
          widget.stokAdi ?? '',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            dataTableWidget(),
          ],
        ),
      ),
    );
  }

  Widget dataTableWidget() {
    return DataTable(
      showBottomBorder: true,
      columnSpacing: 10,
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Dosya No',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Kontrat',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Pl.Say.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Evr.Kg',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Br.Fiyat',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: _list
          .map(
            (model) => DataRow(cells: <DataCell>[
              DataCell(Text(model.dosyaNo)),
              DataCell(Text(model.kontratNo)),
              DataCell(Text(model.paletSayisi.toString())),
              DataCell(Text(model.evrakNet.toStringAsFixed(0))),
              DataCell(Text(model.fiyat.toStringAsFixed(0))),
            ]),
          )
          .toList(),
    );
  }
}
