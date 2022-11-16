import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';

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
              const Settings(),
        ),
      ],
    ),
  ],
);

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

//extending the app bar basically a flexbox with stuff in it
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            //Route to go to settings empty for now
            onTap: () {
              context.go('/settings');
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: const Icon(
                IconData(0xf363, fontFamily: 'MaterialIcons'),
                color: Color.fromARGB(255, 6, 46, 107),
                size: 40.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              context.go('/');
            },
            child: Container(
              width: 125,
              height: 40,
              alignment: Alignment.center,
              decoration: (BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 6, 46, 107),
                    width: 2.5,
                  ),
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.circular(15))),

              // we can set width here with conditions
              // var height = MediaQuery.of(context).viewPadding.top;
              child: TitleText(),
            ),
          ),
          Spacer(),
          InkWell(
            //route to create new project input form
            onTap: () {
              context.go('/projectInput');
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: const Icon(
                IconData(0xf527, fontFamily: 'MaterialIcons'),
                color: Color.fromARGB(255, 6, 46, 107),
                size: 40.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            ),
          ), //wrapper that allows me to add an 'onTap()'
        ],
      ),
    );
  }

  ///width doesnt matter
  @override
  Size get preferredSize => Size(100, kToolbarHeight);
}

//Outlined text effect styles
class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          "Ophelia",
          style: TextStyle(
            fontSize: 20,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 6
              ..color = Color.fromARGB(255, 6, 46, 107),
          ),
        ),
        // Solid text as fill.
        Text(
          "Ophelia",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
            Spacer(),
            Container(
              margin: const EdgeInsets.only(top: 25),
              color: Colors.blue[100],
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
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
            InkWell(
              onTap: () {
                context.go('/weekview');
              },
              child: Container(
                width: 120,
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
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: projectList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
    projectList() - Project Container positioned to bottom of the screen
    Container with a list view of list items inside of it.
  */

  FractionallySizedBox projectList() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Column(
        children: [
          const Text(
            textAlign: TextAlign.center,
            "Welcome user you have 5 projects scheduled for this week",
          ),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.blue[600],
            ),
            child: ListView(
              padding: const EdgeInsets.only(top: 20),
              children: const <Widget>[
                ProjListItem(),
                ProjListItem(),
                ProjListItem(),
                ProjListItem(),
                ProjListItem(),
              ],
            ),
          ),
        ],
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
class ProjListItem extends StatelessWidget {
  const ProjListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .9,
      child: Container(
        decoration: Shadows(Colors.blue[200]),
        margin: const EdgeInsets.only(bottom: 20),
        height: 38,
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            "Ophelia",
          ),
        ),
      ),
    );
  }
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

class Settings extends StatelessWidget {
  /// Creates a [Page1Screen].
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('UNDER CONSTRUCTION SETTINGS PAGE'),
              ),
            ],
          ),
        ),
      );
}

class ProjectInput extends StatelessWidget {
  /// Creates a [Page1Screen].
  const ProjectInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('OPE user input text page'),
              ),
            ],
          ),
        ),
      );
}

//Week view page
class WeekView extends StatelessWidget {
  /// Creates a [Page1Screen].
  const WeekView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Week View',
                style: TextStyle(
                  fontSize: 30,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Color.fromARGB(255, 6, 46, 107),
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
      FractionallySizedBox(
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
