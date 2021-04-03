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

  // last searched query
  String _query = '';

  // for autoRefreshTimer
  StreamSubscription? _periodicSub;

  // default time duration
  static const _defaultAutoRefreshTime = 30;

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

    if (event is AutoRefresh) {
      if (!event.refresh) {
        // if event is not refresh cancel the subscription
        _periodicSub?.cancel();
      } else {
        // if event is  refresh start the subscription
        yield* _autoRefresh();
      }
    }

    if (event is Initial) {
      yield* _search('', true);
      yield* _autoRefresh();
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

      // notify the UI
      yield Searched(articles: articles, initial: true);

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

    // updates the UI to show shimmer
    yield Searching();

    // keep the query to do autoRefresh
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

  Stream<HeadlinesState> _autoRefresh() async* {
    bool refresh = Hive.box('settings').get('refresh', defaultValue: true);
    if (refresh) {
      _periodicSub = new Stream.periodic(
          const Duration(seconds: _defaultAutoRefreshTime), (v) => v).listen(
        (count) {
          if (_query.isNotEmpty) {
            add(Search(query: _query));
          }
        },
      );
    }
  }

  @override
  Future<void> close() {
    // close the subscription on dispose
    _periodicSub?.cancel();
    return super.close();
  }
}
