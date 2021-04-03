part of 'interests_bloc.dart';

@immutable
abstract class InterestsEvent {}

class Fetch extends InterestsEvent {
  final String? query;

  Fetch({this.query});
}
