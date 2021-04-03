part of 'interests_bloc.dart';

@immutable
abstract class InterestsState {}

class InterestsInitial extends InterestsState {}

class Fetching extends InterestsState {}

class Fetched extends InterestsState {
  final List<InterestData> interests;

  Fetched(this.interests);
}

class FetchError extends InterestsState {}
