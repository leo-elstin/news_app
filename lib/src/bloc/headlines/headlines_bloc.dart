import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:news_app/src/model/data_model/article.dart';
import 'package:news_app/src/model/data_model/error_model.dart';
import 'package:news_app/src/model/data_model/headlines_response.dart';
import 'package:news_app/src/model/service/news_service.dart';

part 'headlines_event.dart';

part 'headlines_state.dart';

class HeadlinesBloc extends Bloc<HeadlinesEvent, HeadlinesState> {
  HeadlinesBloc() : super(HeadlinesInitial());

  NewsService _service = NewsService();

  @override
  Stream<HeadlinesState> mapEventToState(
    HeadlinesEvent event,
  ) async* {
    if (event is Search) {
      yield* _search(event.query!);
    }

    if (event is Reset) {
      yield HeadlinesInitial();
    }
  }

  Stream<HeadlinesState> _search(String query) async* {
    var headlines = await Hive.openBox('headlines');
    if (query.isEmpty) {
      yield SearchError(
        error: Error(message: 'Search text should not be empty!'),
      );
      return;
    }
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      yield SearchError(
        error: Error(message: 'No internet connectivity available!'),
      );
      return;
    }

    yield Searching();
    var resp = await _service.topHeadlines(query: query);
    if (resp is HeadlinesResponse) {
      await headlines.clear();
      await headlines.addAll(resp.articles);

      yield Searched(articles: resp.articles);
    } else if (resp is Error) {
      yield SearchError(error: resp);
    }
  }
}
