import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:news_app/src/config/constants.dart';
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
    ConnectivityResult result = await Connectivity().checkConnectivity();

    if(result == ConnectivityResult.none) {
      yield FetchError(Error(exception: '', message: 'Network connectivity not available'),);
      return;
    }

    yield Fetching();
    dynamic resp = await _service.everything(query: query);
    if (resp is HeadlinesResponse) {
      Set<String?> dates = resp.articles
          .map(
            (e) => Constants().dateFormat.format(e.publishedAt!),
          )
          .toList()
          .toSet();

      List<InterestData> interests = [];
      dates.forEach((element) {
        /// query only the matching items
        List<Article> articles = resp.articles
            .where((article) =>
                Constants().dateFormat.format(article.publishedAt!) == element)
            .toList();
        // add the InterestData to [interests]
        interests.add(
          InterestData(Constants().dateFormat.parse(element!), articles.length),
        );
      });

      int max = 0;
      try {
        List<int> counts = interests.map((e) => e.articlesCount).toList();
        counts.sort();

        max = counts.last;
      } on Exception {}

      yield Fetched(interests, max: max);
    } else if (resp is Error) {
      yield FetchError(
        Error(exception: '', message: 'Something went wrong'),
      );
    }
  }
}
