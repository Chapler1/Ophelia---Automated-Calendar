import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import 'myappbar.dart';

class ProjectInput extends StatelessWidget {
  /// Creates a [Page1Screen].
  const ProjectInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Generated 12 Schedules',
                ),
              ),
              generatedSchedule(),
              generatedSchedule(),
              generatedSchedule(),
              generatedSchedule(),
            ],
          ),
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
            children: [
              listDayItemBox(),
              listDayItemBox(),
              listDayItemBox(),
              listDayItemBox(),
              listDayItemBox(),
              listDayItemBox(),
            ],
          ),
        ),
      ),
    );
  }

  Container listDayItemBox() {
    return Container(
      height: 60,
      width: 40,
      color: Colors.red,
      margin: const EdgeInsets.only(top: 20, left: 20),
    );
  }
}

//a function to take an array of 7 ints and return a widget with horizontally sized boxes like this.

