import 'package:flutter/material.dart';
import 'package:kurtas/views/dashboard.dart';
import 'package:kurtas/views/genel_mevcut.dart';
import 'package:kurtas/views/siparis_giris.dart';
import 'package:kurtas/widgets/side_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        image: DecorationImage(
          image: AssetImage("assets/images/splash.png"),
          //colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Image.asset(
            "assets/images/logo.png",
            color: Colors.white,
            width: 128,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: MySideMenu(),
        body: Padding(
          padding:
              EdgeInsets.only(left: 32.0, top: 48.0, right: 32.0, bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              gridViewWidget(),
              // Container(
              //   height: 160.0,
              //   width: double.infinity,
              //   child: MaterialButton(
              //     elevation: 8.0,
              //     highlightElevation: 1.0,
              //     onPressed: () {},
              //     shape: RoundedRectangleBorder(
              //       side: BorderSide(
              //           color: Colors.white,
              //           width: 1,
              //           style: BorderStyle.solid
              //       ),
              //       borderRadius: BorderRadius.only(
              //           bottomLeft: Radius.circular(10.0),
              //           bottomRight: Radius.circular(10.0)),
              //     ),
              //     color: Colors.transparent.withOpacity(0.2),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         Icon(Icons.file_copy_outlined, color: Colors.white,
              //           size: 40.0,),
              //         SizedBox(height: 5.0),
              //         Text("Cari Ekstre",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 16.0
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget gridViewWidget() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 6.0,
      mainAxisSpacing: 6.0,
      childAspectRatio: 1.2,
      children: <Widget>[
        _buildCategoryItem(
            Icon(
              Icons.dashboard_rounded,
              color: Colors.white,
              size: 40.0,
            ),
            "Dashboard",
            BorderRadius.only(
              topLeft: Radius.circular(10.0),
            ), () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => DashboardPage()));
        }),
        _buildCategoryItem(
            Icon(
              Icons.list_rounded,
              color: Colors.white,
              size: 40.0,
            ),
            "Genel Mevcut",
            BorderRadius.only(
              topRight: Radius.circular(10.0),
            ), () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => GenelMevcutPage()));
        }),
        _buildCategoryItem(
            Icon(
              Icons.insert_drive_file_outlined,
              color: Colors.white,
              size: 40.0,
            ),
            "Dosya İzleme",
            BorderRadius.only(
              topRight: Radius.circular(10.0),
            ),
            () {}),
        _buildCategoryItem(
            Icon(
              Icons.addchart_outlined,
              color: Colors.white,
              size: 40.0,
            ),
            "Aylık Raporlar",
            BorderRadius.all(
              Radius.circular(0.0),
            ),
            () {}),
        _buildCategoryItem(
            Icon(
              Icons.file_present,
              color: Colors.white,
              size: 40.0,
            ),
            "Sipariş İzleme",
            BorderRadius.all(
              Radius.circular(0.0),
            ),
            () {}),
        _buildCategoryItem(
            Icon(
              Icons.all_inbox_outlined,
              color: Colors.white,
              size: 40.0,
            ),
            "Gelecek Mallar",
            BorderRadius.all(
              Radius.circular(0.0),
            ),
            () {}),
        _buildCategoryItem(
            Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 40.0,
            ),
            "Sipariş Girişi",
            BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
            ), () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => SiparisGirisPage()));
        }),
        _buildCategoryItem(
            Icon(
              Icons.file_copy_outlined,
              color: Colors.white,
              size: 40.0,
            ),
            "Cari Ekstre",
            BorderRadius.only(
              bottomRight: Radius.circular(10.0),
            ),
            () {}),
      ],
    );
  }

  Widget _buildCategoryItem(
      Icon icon, String name, BorderRadius radius, Function onpress) {
    return MaterialButton(
      elevation: 8.0,
      highlightElevation: 1.0,
      onPressed: onpress,
      shape: RoundedRectangleBorder(
        side:
            BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
        borderRadius: radius,
      ),
      color: Colors.transparent.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          SizedBox(height: 5.0),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
