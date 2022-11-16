import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'myappbar.dart';

//Week view page
class WeekView extends StatelessWidget {
  /// Creates a [Page1Screen].
  const WeekView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(),
        body: Center(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: Text(
                    'Week View',
                    style: TextStyle(
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Color.fromARGB(255, 6, 46, 107),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 20),
                    children: const <Widget>[
                      DailyEventList(),
                      DailyEventList(),
                      DailyEventList(),
                      DailyEventList(),
                      DailyEventList(),
                      DailyEventList(),
                      DailyEventList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

//Widget for list of days with their events
class DailyEventList extends StatelessWidget {
  const DailyEventList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Day'),
      SafeArea(
        child: FractionallySizedBox(
          widthFactor: .9,
          child: Container(
            decoration: Shadows(Colors.blue[200]),
            margin: const EdgeInsets.only(bottom: 20),
            height: 60,
            child: Align(
              alignment: Alignment.center,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: const <Widget>[Event(), Event(), Event()],
              ),
            ),
          ),
        ),
      )
    ]);
  }
}

//Week view event widget (listed in a day)
class Event extends StatelessWidget {
  const Event({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      color: Color.fromARGB(255, 255, 255, 255),
      width: 100,
      height: 50,
      child: const Align(
        alignment: Alignment.center,
        child: Text(
          'Event',
        ),
      ),
    );
  }
}

//!! repeated code.
// BOX shadows styles
BoxDecoration Shadows(color) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(50),
      boxShadow: const [
        // Shadow for top-left corner
        BoxShadow(
          color: Color.fromARGB(255, 0, 65, 162),
          offset: Offset(10, 10),
          blurRadius: 6,
          spreadRadius: 1,
        ),
        // Shadow for bottom-right corner
        BoxShadow(
          color: Colors.white12,
          offset: Offset(-10, -10),
          blurRadius: 6,
          spreadRadius: 1,
        ),
      ]);
}
