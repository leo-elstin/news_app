import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
    yield Searching();
    var resp = await _service.topHeadlines(query: query);
    if (resp is HeadlinesResponse) {
      yield Searched(articles: resp.articles);
    } else if (resp is Error) {
      yield SearchError(error: resp);
    }
  }
}
