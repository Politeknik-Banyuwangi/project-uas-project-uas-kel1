import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api-kel1-2d.herokuapp.com/api/v1/';
  // static const String _baseUrl = 'http://10.0.2.2:8000/api/v1/';
  var _token;

  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token')!.replaceAll('"', '');
  }

  auth(data, apiURL) async {
    var url = Uri.parse(_baseUrl + apiURL);
    final response = await http.post(url, body: jsonEncode(data), headers: _setHeaders());
    return response;
  }

  getData(apiURL) async {
    var url = Uri.parse(_baseUrl + apiURL);
    await _getToken();
    final response = await http.get(url, headers: _setHeaders());
    return response;
  }

  postData(data, apiURL) async {
    var url = Uri.parse(_baseUrl + apiURL);
    await _getToken();
    final response = await http.post(url, body: jsonEncode(data), headers: _setHeaders());
    return response;
  }

  _setHeaders() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      };
}
