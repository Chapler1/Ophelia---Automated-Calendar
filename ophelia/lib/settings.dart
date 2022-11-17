import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'myappbar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  const Settings({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Settings> createState() => _SettingsState();
}

Future<String> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('http://192.168.86.35:8080/getFullProjecJson'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ((response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    // throw Exception('Failed to load album');
    return "{API not connected probably}";
  }
}

class _SettingsState extends State<Settings> {
  /// Creates a [Page1Screen].
  late Future<String> myData;
  @override
  void initState() {
    super.initState();
    myData = fetchAlbum();
  }

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
              FutureBuilder<String>(
                future: myData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      );
}
