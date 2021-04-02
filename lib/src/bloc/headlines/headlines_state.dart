part of 'headlines_bloc.dart';

@immutable
abstract class HeadlinesState {}

class HeadlinesInitial extends HeadlinesState {}

class Searching extends HeadlinesState {}

class Searched extends HeadlinesState {
  final List<Article> articles;

  Searched({required this.articles});
}

class SearchError extends HeadlinesState {
  final Error error;

  SearchError({required this.error});
}
