import 'package:flutter/material.dart';
import 'package:kurtas/services/api_services.dart';
import 'package:kurtas/widgets/variables.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  ArsProgressDialog _progressDialog;
  final _gsmController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> getSettings() async {
    // final prefs = await SharedPreferences.getInstance();
    // _gsmController.text = prefs.get("gsm") ?? "";
    // _passwordController.text = prefs.get("pass") ?? "";
  }

  Future<void> login() async {
    _progressDialog.show();

    await ApiServices.getToken();
    _progressDialog.dismiss();
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  void initState() {
    getSettings();
    super.initState();
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
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: loginWidget(),
      ),
    );
  }

  final Color backgroundColor1 = Color(0xFF444152);
  final Color backgroundColor2 = Color(0xFF6f6c7d);
  final Color highlightColor = Color(0xFF0067A4);
  final Color foregroundColor = Colors.white;
  final AssetImage logo = new AssetImage("assets/images/logo.png");

  Widget loginWidget() {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
          child: Center(
            child: new Column(
              children: <Widget>[
                Container(
                  height: 152.0,
                  width: 128.0,
                  child: new CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: this.foregroundColor,
                      radius: 100.0,
                      child: new Image(
                        image: this.logo,
                        color: Colors.white,
                        width: 152.0,
                        height: 128.0,
                      )),
                ),
              ],
            ),
          ),
        ),
        new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: this.foregroundColor,
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                child: Icon(
                  Icons.person,
                  color: this.foregroundColor,
                ),
              ),
              new Expanded(
                child: TextField(
                  controller: _gsmController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'kullanıdı adı',
                    hintStyle: TextStyle(color: this.foregroundColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: this.foregroundColor,
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                child: Icon(
                  Icons.lock_open,
                  color: this.foregroundColor,
                ),
              ),
              new Expanded(
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'şifre',
                    hintStyle: TextStyle(color: this.foregroundColor),
                  ),
                ),
              ),
            ],
          ),
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
                  onPressed: () => login(),
                  child: Text(
                    "OTURUM AÇ",
                    style: TextStyle(color: this.foregroundColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//   void login() async {
//     final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//     var tokenUrl = Variables.tokenUrl;
//     var response = await http.post(
//         tokenUrl,
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: {
//           'grant_type': 'password',
//           'username': Variables.tokenUser,
//           'password': Variables.tokenPass
//         }
//     );
//     if (response.statusCode == 200) {
//       var result = TokenModel.fromJson(
//           json.decode(response.body)
//       );
//       Variables.accessToken = result.accessToken;
//
//       var res = await http.get(
//           Variables.url + '/login?username=' + _gsmController.text +
//               '&password=' + _passwordController.text,
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'bearer ' + Variables.accessToken
//           });
//       if (res.statusCode == 200) {
//         var ck, dt, dv;
//
// //        _firebaseMessaging.configure(
// //          onLaunch: (Map<String, dynamic> message) {
// //            print('onLaunch called');
// //          },
// //          onResume: (Map<String, dynamic> message) {
// //            print('onResume called');
// //          },
// //          onMessage: (Map<String, dynamic> message) {
// //            print('onMessage called');
// //          },
// //        );
// //        _firebaseMessaging.subscribeToTopic('all');
// //        _firebaseMessaging.requestNotificationPermissions(
// //            IosNotificationSettings(
// //              sound: true,
// //              badge: true,
// //              alert: true,
// //            ));
// //        _firebaseMessaging.onIosSettingsRegistered
// //            .listen((IosNotificationSettings settings) {
// //          print('token registered');
// //        });
// //        _firebaseMessaging.getToken().then((token) {
// //          dv = token;
// //          print('token:' + token);
// //        });
//
//         if (Platform.isAndroid) {
//           AndroidDeviceInfo android = await deviceInfoPlugin.androidInfo;
//           ck = android.androidId.substring(0, 6);
//           dt = 'android';
//         } else if (Platform.isIOS) {
//           IosDeviceInfo ios = await deviceInfoPlugin.iosInfo;
//           ck = ios.identifierForVendor.substring(0, 6);
//           dt = 'ios';
//         }
//
//         var decodeList = json.decode(res.body) as List<dynamic>;
//         List<KullaniciModel> kullanici = decodeList.map((i) =>
//             KullaniciModel.fromJson(i)).toList();
//
//         if (kullanici.length > 0) {
//           Variables.musid = kullanici[0].mUSID;
//           Variables.kulid = kullanici[0].kULID;
//
//           final prefs = await SharedPreferences.getInstance();
//           prefs.setString("gsm", _gsmController.text);
//           prefs.setString("pass", _passwordController.text);
//
//           Navigator.of(context).pushReplacement(
//               new MaterialPageRoute(
//                   settings: const RouteSettings(name: '/home'),
//                   builder: (context) =>
//                   new HomePage()
//               ));
//         }
//         else {
//
//         }
//       }
//       else {
//
//       }
//     }
//     else {
//
//     }
//   }
}
