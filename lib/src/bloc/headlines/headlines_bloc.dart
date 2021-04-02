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
  String _query = '';
  Timer? timer;

  @override
  Stream<HeadlinesState> mapEventToState(
    HeadlinesEvent event,
  ) async* {
    if (event is Search) {
      yield* _search(event.query!, false);
    }

    if (event is Reset) {
      yield HeadlinesInitial();
    }

    if (event is Initial) {
      yield* _search('', true);
      yield* _timer();
    }
  }

  /// Method to search the headlines
  /// @ [query] and [initial] is required
  /// if [initial] it will show the last saved [headlines] if available
  Stream<HeadlinesState> _search(String query, bool initial) async* {
    var headlines = await Hive.openBox('headlines');

    // if query is empty alert the UI
    if (query.isEmpty && !initial) {
      yield SearchError(
        error: Error(
          message: 'Search text should not be empty!',
        ),
      );
      return;
    }

    if (initial) {
      // notify the ui
      yield Searching();
      // if no internet notify the UI get the local data
      List<Article> articles = headlines.values.toList().cast<Article>();

      if (articles.isNotEmpty) {
        // notify the UI
        yield Searched(articles: articles);
      }
      return;
    }
    // checks it connectivity is available
    ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none && !initial) {
      // show the error
      yield SearchError(
        error: Error(
          message:
              '${initial ? 'Search for news ' : 'Offline content not available'}',
        ),
      );

      return;
    }

    yield Searching();

    _query = query;

    // call the api to get the articles
    var resp = await _service.topHeadlines(query: query);
    // if return type is [HeadlinesResponse]
    if (resp is HeadlinesResponse) {
      // clear the articles to the hive box
      await headlines.clear();
      // write the articles to the hive box
      await headlines.addAll(resp.articles);

      // notify the UI
      yield Searched(articles: resp.articles);
    }
    // if return type is [HeadlinesResponse]
    else if (resp is Error) {
      yield SearchError(error: resp);
    }
  }

  Stream<HeadlinesState> _timer() async* {
    StreamSubscription periodicSub;

    periodicSub =
        new Stream.periodic(const Duration(seconds: 30), (v) => v).listen(
      (count) {
        if (_query.isNotEmpty) {
          add(Search(query: _query));
        }
      },
    );
  }
}
