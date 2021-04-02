part of 'headlines_bloc.dart';

@immutable
abstract class HeadlinesEvent {}

class Search extends HeadlinesEvent {
  final String? query;

  Search({this.query});
}

class Reset extends HeadlinesEvent {

}
