part of 'headlines_bloc.dart';

@immutable
abstract class HeadlinesState {}

class HeadlinesInitial extends HeadlinesState {}

class Searching extends HeadlinesState {}

class Searched extends HeadlinesState {}
