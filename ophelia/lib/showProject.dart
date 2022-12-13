import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'myappbar.dart';
import 'package:http/http.dart' as http;

class Project {
  final String projectName;
  final int projectColor;
  final int numSessions;
  final int numHours;
  final String projectNotes;
  final String startDate;
  final String endDate;
  final int projectIndex;
  final List<dynamic> projectDays;

  const Project(
      {required this.projectName,
      required this.projectColor,
      required this.numSessions,
      required this.numHours,
      required this.projectNotes,
      required this.startDate,
      required this.endDate,
      required this.projectIndex,
      required this.projectDays});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectName: json['projectName'],
      projectColor: json['projectColor'],
      numSessions: json['numSessions'],
      numHours: json['numHours'],
      projectNotes: json['projectNotes'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      projectIndex: json['projectIndex'],
      projectDays: json['projectDays'],
    );
  }
}

class ProjectDay {
  final String eventName;
  final String timeDelta;
  final String date;

  const ProjectDay(
      {required this.eventName, required this.timeDelta, required this.date});

  factory ProjectDay.fromJson(Map<String, dynamic> json) {
    return ProjectDay(
      eventName: json['eventName'],
      timeDelta: json['timeDelta'],
      date: json['date'],
    );
  }
}

class ShowProject extends StatefulWidget {
  const ShowProject({super.key, required this.id});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String id;

  @override
  State<ShowProject> createState() => _ShowProjectState();
}

Future<Project> getProjectById(projId) async {
  final response = await http
      .get(Uri.parse('http://71.182.194.216:8080/getProject?id=$projId'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Project.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    // throw Exception('Failed to load album');
    throw Exception('Failed to create project.');
  }
}

class _ShowProjectState extends State<ShowProject> {
  /// Creates a [Page1Screen].
  late Future<Project> myData;
  @override
  void initState() {
    super.initState();
    myData = getProjectById(widget.id);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(),
        body: Center(
          child: SafeArea(
            child: ListView(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('UNDER CONSTRUCTION SETTINGS PAGE'),
                ),
                SingleChildScrollView(
                  child: FutureBuilder<String>(
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
                ),
              ],
            ),
          ),
        ),
      );
}
