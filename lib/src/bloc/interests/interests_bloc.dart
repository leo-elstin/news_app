import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'interests_event.dart';
part 'interests_state.dart';

class InterestsBloc extends Bloc<InterestsEvent, InterestsState> {
  InterestsBloc() : super(InterestsInitial());

  @override
  Stream<InterestsState> mapEventToState(
    InterestsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
