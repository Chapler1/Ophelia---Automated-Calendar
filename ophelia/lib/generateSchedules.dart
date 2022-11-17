import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import 'myappbar.dart';

class GenerateSchedules extends StatelessWidget {
  /// Creates a [Page1Screen].
  const GenerateSchedules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar(),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 20,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                'Generated 12 Schedules',
              ),
            ),
            TextButton(
                //Todo: this route should be able to persist data back and fourth so the user can change their options
                onPressed: () => {context.go('/projectInput')},
                child: Text("Go Back")),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ListView(
                  children: <Widget>[
                    generatedSchedule(),
                    generatedSchedule(),
                    generatedSchedule(),
                    generatedSchedule(),
                    generatedSchedule(),
                    generatedSchedule(),
                    generatedSchedule(),
                    generatedSchedule(),
                    generatedSchedule(),
                    generatedSchedule(),
                    generatedSchedule(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  FractionallySizedBox generatedSchedule() {
    return FractionallySizedBox(
      widthFactor: .9,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 60,
        color: Colors.red[100],
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              listDayItemBox("M"),
              listDayItemBox("T"),
              listDayItemBox("W"),
              listDayItemBox("T"),
              listDayItemBox("F"),
              listDayItemBox("Sa"),
              listDayItemBox("Su"),
            ],
          ),
        ),
      ),
    );
  }

  Container listDayItemBox(String dayText) {
    //the sum of all freq is 1
    //this data is generated on the backend.
    return Container(
      height: 39,
      width: 53,
      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0),
      margin: const EdgeInsets.only(top: 0, left: 0),
      child: Center(child: Text(textAlign: TextAlign.center, dayText)),
    );
  }
}

//a function to take an array of 7 ints and return a widget with horizontally sized boxes like this.
