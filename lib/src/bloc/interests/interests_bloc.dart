import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/src/model/data_model/article.dart';
import 'package:news_app/src/model/data_model/error_model.dart';
import 'package:news_app/src/model/data_model/headlines_response.dart';
import 'package:news_app/src/model/data_model/interest_data.dart';
import 'package:news_app/src/model/service/news_service.dart';

part 'interests_event.dart';

part 'interests_state.dart';

class InterestsBloc extends Bloc<InterestsEvent, InterestsState> {
  InterestsBloc() : super(InterestsInitial());

  NewsService _service = NewsService();

  @override
  Stream<InterestsState> mapEventToState(
    InterestsEvent event,
  ) async* {
    if (event is Fetch) {
      yield* _fetch(event.query);
    }
  }

  Stream<InterestsState> _fetch(String? query) async* {
    yield Fetching();
    dynamic resp = await _service.everything(query: query);
    if (resp is HeadlinesResponse) {
      Set<DateTime?> dates =
          resp.articles.map((e) => e.publishedAt).toList().toSet();

      List<InterestData> interests = [];
      dates.forEach((element) {
        /// query only the matching items
        List<Article> articles = resp.articles
            .where((article) => article.publishedAt == element)
            .toList();
        // add the InterestData to [interests]
        interests.add(InterestData(element!, articles.length));
      });

      yield Fetched(interests);
    } else if (resp is Error) {
      yield FetchError();
    }
  }
}
