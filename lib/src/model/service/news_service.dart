import 'package:news_app/src/model/data_model/error_model.dart';
import 'package:news_app/src/model/data_model/headlines_response.dart';
import 'package:news_app/src/model/service/api_service.dart';

class NewsService {
  ApiService _service = ApiService();

  Future<dynamic> topHeadlines({String? query}) async {
    String path = 'top-headlines?q=$query';
    try {
      String resp = await _service.get(path: path);
      return headlinesResponseFromJson(resp);
    } on Exception catch (e) {
      return Error(
        exception: '${e.toString()}',
        message: 'Something went wrong',
      );
    }
  }
}
