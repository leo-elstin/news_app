part of 'headlines_bloc.dart';

@immutable
abstract class HeadlinesEvent {}

class Search extends HeadlinesEvent {
  final String? query;

  Search({this.query});
}

class Reset extends HeadlinesEvent {}

class Initial extends HeadlinesEvent {
  final String query;

  Initial(this.query);
}

class NetworkConnection extends HeadlinesEvent {
  final bool available;

  NetworkConnection(this.available);
}

class AutoRefresh extends HeadlinesEvent {
  final bool refresh;

  AutoRefresh(this.refresh);
}
