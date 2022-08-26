// import 'dart:async';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/bloc/timer_bloc.dart';
import 'package:timer_app/bloc/timer_event.dart';
import 'package:timer_app/bloc/timer_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int startTimerValue = 120;
  @override
  void initState() {
    super.initState();
    startTimer(context);
  }

  int minute = 1;
  int seconds = 60;
  double linearValue = 1;
  void startTimer(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (watch) {
      if (minute == 0 && seconds == 1) {
        watch.cancel();
      }

      if (seconds == 0 && minute > 0) {
        minute--;
        seconds = 60;
      }

      BlocProvider.of<TimerBloc>(context).add(TimerUpdateEvent());
      linearValue = linearValue - 0.00833333333;
      seconds--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
          if (state is InitialTimerState) {
            BlocProvider.of<TimerBloc>(context).add(GetTimerDataEvent());
            return const Text("0");
          } else if (state is LoadedTimerState) {
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$minute:"),
                    Text("$seconds"),
                  ],
                ),
                LinearProgressIndicator(
                  color: Colors.pink,
                  minHeight: 20,
                  value: linearValue,
                )
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
