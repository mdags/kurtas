import 'package:http/http.dart' as http;
import 'package:kurtas/model/genel_mevcut_model.dart';
import 'package:kurtas/model/musteriler_model.dart';
import 'package:kurtas/model/stoklar_model.dart';
import 'package:kurtas/model/token_model.dart';
import 'package:kurtas/widgets/variables.dart';

class ApiServices {
  static String tokenUrl = 'http://85.105.132.212:99/token';
  static String tokenUser = 'ilerleyensa';
  static String tokenPass = 'IlrSa2020..';
  static String url = 'http://85.105.132.212:99/api/v1';
  static var client = http.Client();

  static Future<void> getToken() async {
    var response = await client.post(tokenUrl, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      'grant_type': 'password',
      'username': tokenUser,
      'password': tokenPass
    });
    if (response.statusCode == 200) {
      var token = tokenModelFromJson(response.body);
      Variables.accessToken = token.accessToken;
    }
  }

  static Future<List<GenelMevcutModel>> fetchGenelMevcut(String dosyano) async {
    var response = await client.get(url + '/getGenelMevcut?dosyano=' + dosyano,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer ' + Variables.accessToken
        });
    if (response.statusCode == 200) {
      return genelMevcutModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<List<GenelMevcutModel>> fetchGenelMevcutDetay(
      String dosyano, int stokId) async {
    var response = await client.get(
        url +
            '/getGenelMevcutDetay?dosyano=' +
            dosyano +
            '&stokid=' +
            stokId.toString(),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer ' + Variables.accessToken
        });
    if (response.statusCode == 200) {
      return genelMevcutModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<List<MusterilerModel>> fetchMusteriler() async {
    var response = await client.get(url + '/getSiparisMusteriler', headers: {
      'Accept': 'application/json',
      'Authorization': 'bearer ' + Variables.accessToken
    });
    if (response.statusCode == 200) {
      return musterilerModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<List<StoklarModel>> fetchStoklar() async {
    var response = await client.get(url + '/getSiparisStoklar', headers: {
      'Accept': 'application/json',
      'Authorization': 'bearer ' + Variables.accessToken
    });
    if (response.statusCode == 200) {
      return stoklarModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
