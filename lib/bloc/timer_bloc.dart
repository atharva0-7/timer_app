import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/bloc/timer_event.dart';
import 'package:timer_app/bloc/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(InitialTimerState()) {
    on<GetTimerDataEvent>(((event, emit) {
      emit(LoadedTimerState());
    }));
    on<TimerUpdateEvent>((event, emit) {
      emit(LoadedTimerState());
    });
  }
}
