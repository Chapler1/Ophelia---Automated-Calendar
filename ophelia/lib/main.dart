import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const MyHomePage(title: 'Flutter Demo Page'),
    );
  }
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
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: const Icon(
              IconData(0xf363, fontFamily: 'MaterialIcons'),
              color: Color.fromARGB(255, 6, 46, 107),
              size: 40.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ),
          Spacer(),
          Container(
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
          Spacer(),
          Container(
            margin: const EdgeInsets.only(right: 20.0),
            child: const Icon(
              IconData(0xf527, fontFamily: 'MaterialIcons'),
              color: Color.fromARGB(255, 6, 46, 107),
              size: 40.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ),
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
  int _counter = 0;

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
      backgroundColor: Colors.blue,
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
            const Text(
              'You have pressed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Spacer(),
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
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          border: const Border(
            top:
                BorderSide(width: 10.0, color: Color.fromARGB(255, 6, 46, 107)),
          ),
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
            ProjListItem(),
          ],
        ),
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
