import 'package:http/http.dart' as http;
import 'package:news_app/src/config/constants.dart';

class ApiService {
  // singleton class
  ApiService._();

  static ApiService _instance = ApiService._();

  // returns back the existing instance
  factory ApiService() => _instance;

  // base url of the service
  String _baseUrl = 'https://newsapi.org/v2/';

  /// method to handle the get api calls
  ///@requires [path]
  Future<String> get({String? path}) async {
    try {
      var response = await http.get(
        Uri.parse('$_baseUrl/$path&apiKey=${Constants().key}'),
      );

      return response.body;
    } catch (e) {
      return '';
    }
  }
}
