import 'package:flutter/material.dart';
import 'package:kurtas/views/genel_mevcut.dart';
import 'package:kurtas/views/siparis_giris.dart';
import 'package:kurtas/widgets/variables.dart';

class MySideMenu extends StatelessWidget {
  String getShortName(String name) {
    List<String> strings = name.split(" ");
    String shortName;
    if (strings.length == 1) {
      shortName = strings[0].substring(0, 2);
    } else {
      shortName = strings[0].substring(0, 1) + strings[1].substring(0, 1);
    }
    return shortName.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Variables.kPrimaryColor,
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 120,
                      width: 150,
                      child: Image.asset(
                        'assets/images/logo.png',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0.0),
                children: [
                  ListTile(
                    leading: Icon(Icons.home_outlined),
                    title: Text(
                      'Ana Menü',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.list_rounded),
                    title: Text(
                      'Genel Mevcut',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => GenelMevcutPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.insert_drive_file_outlined),
                    title: Text(
                      'Dosya İzleme',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.addchart_outlined),
                    title: Text(
                      'Aylık Raporlar',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.file_present),
                    title: Text(
                      'Sipariş İzleme',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.all_inbox_outlined),
                    title: Text(
                      'Gelecek Mallar',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.edit_outlined),
                    title: Text(
                      'Sipariş Girişi',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => SiparisGirisPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.file_copy_outlined),
                    title: Text(
                      'Cari Ekstre',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
