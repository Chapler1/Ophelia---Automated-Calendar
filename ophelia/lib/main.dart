import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import 'planProject.dart';
import 'myappbar.dart';
import 'weekView.dart';
import 'settings.dart';
import 'http_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'utils.dart';
import 'dart:collection';

void main() {
  runApp(const MyApp());
}

//RPC routing instead of REST
//REST: is resource oriented routes
// Returning data is in JSON format and requests we are using are PUT, DELETE, POST, and GET
//RPC: is functional routes very data-centric
//it consists of allowing client code to call a piece of server code as if it was local.
//I chose this because it will make the routing less nested.

//How to routes get resources? from the user object reference
//make it accessible to all paths somehow?
//the issue with this is that all the data is in the app at once some of it should be on the server.
//all paths have the user ID
//they send fetch requests to the server with their current path
final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const MyHomePage(title: 'Flutter Demo Page'),
      routes: <GoRoute>[
        GoRoute(
          path: 'projectInput',
          builder: (BuildContext context, GoRouterState state) =>
              const ProjectInput(),
        ),
        GoRoute(
          path: 'generateSchedules',
          builder: (BuildContext context, GoRouterState state) =>
              const ProjectInput(),
        ),
        GoRoute(
          path: 'weekView',
          builder: (BuildContext context, GoRouterState state) =>
              const WeekView(),
        ),
        GoRoute(
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) =>
              const Settings(title: "hello world"),
        ),
      ],
    ),
  ],
);

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Page'),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late Future<String> myData;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    myData = fetchNames();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue[600],
      appBar: MyAppBar(),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SafeArea(
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 90),
                color: Colors.blue[100],
                child: TableCalendar<Event>(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  eventLoader: _getEventsForDay,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      _selectedEvents.value = _getEventsForDay(selectedDay);
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                ),
              ),
              Spacer(),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            onTap: () => print('${value[index]}'),
                            title: Text('${value[index]}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  context.go('/weekview');
                },
                child: Container(
                  //this makes the width expand.
                  width: double.infinity,
                  height: 33,
                  alignment: Alignment.center,
                  decoration: (BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 6, 46, 107),
                        width: 2.5,
                      ),
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15))),

                  // we can set width here with conditions
                  // var height = MediaQuery.of(context).viewPadding.top;
                  child: Text(
                    'Week View',
                    style: TextStyle(
                      fontSize: 20,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Color.fromARGB(255, 6, 46, 107),
                    ),
                  ),
                ),
              ),
              //optional makes the calender more to the top of the screen Spacer(),
              Align(
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: projectList(myData),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
    projectList() - Project Container positioned to bottom of the screen
    Container with a list view of list items inside of it.
  */
  Future<String> fetchNames() async {
    final response =
        await http.get(Uri.parse('http://192.168.86.35:8080/getProjectNames'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ((response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // throw Exception('Failed to load album');
      return '{API not connected probably}';
    }
  }

  FractionallySizedBox projectList(myData) {
    List<Widget> projListItemList = <Widget>[];
    return FractionallySizedBox(
      widthFactor: 1,
      child: Column(
        children: [
          const Text(
            textAlign: TextAlign.center,
            "Welcome user you have 5 projects scheduled for this week",
          ),
          FutureBuilder<String>(
            future: myData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String data = snapshot.data!;
                final List<dynamic> projectNameList = jsonDecode(data);
                for (var i = 0; i < projectNameList.length; i++) {
                  projListItemList.add(ProjListItem(
                      (projectNameList[i])['$i'].toString() + "$i"));

                  print(projectNameList[i]);
                }
                return projectButtons(projListItemList);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  Container projectButtons(List<Widget> projListItemList) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.blue[600],
      ),
      child: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: projListItemList,
      ),
    );
  }
}

/*
    ProjListItem() - List item that represents a project.
    Fractionally sizing list items to 90% of the space in the outter projectList() container
    Putting it into a container to display it
    Aligning the text center on both axis within the list item.
  */

FractionallySizedBox ProjListItem(name) {
  return FractionallySizedBox(
    widthFactor: .9,
    child: Container(
      decoration: Shadows(Colors.blue[200]),
      margin: const EdgeInsets.only(bottom: 20),
      height: 38,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          name,
        ),
      ),
    ),
  );
}

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
