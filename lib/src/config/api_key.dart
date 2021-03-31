class ApiKey {
  // singleton class
  ApiKey._();

  static ApiKey _instance = ApiKey._();

  // returns back the existing instance
  factory ApiKey() => _instance;

  String get key => _apiKey;

  String _apiKey = 'c9230c1bef5b4c5187348725897833cf';
}
