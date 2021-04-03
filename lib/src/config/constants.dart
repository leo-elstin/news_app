import 'package:intl/intl.dart';

class Constants {
  // singleton class
  Constants._();

  static Constants _instance = Constants._();

  // returns back the existing instance
  factory Constants() => _instance;

  String get key => _apiKey;

  String _apiKey = 'c9230c1bef5b4c5187348725897833cf';

  var dateFormat = DateFormat('YYYY-MM-dd');
}
