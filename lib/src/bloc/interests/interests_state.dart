part of 'interests_bloc.dart';

@immutable
abstract class InterestsState {}

class InterestsInitial extends InterestsState {}

class Fetching extends InterestsState {}

class Fetched extends InterestsState {
  final List<InterestData> interests;
  final int max;

  Fetched(this.interests, {required this.max});
}

class FetchError extends InterestsState {
  final Error error;

  FetchError(this.error);
}
