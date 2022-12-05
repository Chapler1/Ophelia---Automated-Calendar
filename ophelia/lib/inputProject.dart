import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'myappbar.dart';
import 'dart:math';

class ProjectInput extends StatefulWidget {
  @override
  _ProjectInputState createState() => _ProjectInputState();
}

class _ProjectInputState extends State<ProjectInput> {
  /// Creates a [Page1Screen].
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late Future<String> myData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      myData = fetchNames(); //NOTE4
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MyAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                TextFormField(
                  focusNode: _focusNode,
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter project name',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: FractionallySizedBox(
                    widthFactor: .9,
                    child: Column(
                      children: [
                        Text("Set Project Color"),
                        Container(
                            height: 50,
                            color: Colors.white,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: nCircles(100))),
                      ],
                    ),
                  ),
                ),
                TextFormField(
                  focusNode: _focusNode,
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Project Deadline',
                  ),
                ),
                TextFormField(
                  focusNode: _focusNode,
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Number of sessions to complete',
                  ),
                ),
                TextFormField(
                  focusNode: _focusNode,
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Approximate the number of hours to complete',
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () => {context.go('/generateSchedules')},
                    child: Container(
                      width: (double.infinity),
                      height: 50,
                      color: Colors.amber,
                      child: const Center(
                          child: Text("Plan my Project",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Container colorCircle(Color c) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      width: 30,
      height: 30,
      decoration: BoxDecoration(color: c, shape: BoxShape.circle),
    );
  }

  List<Widget> nCircles(n) {
    List<Widget> circleList = <Widget>[];
    for (int i = 0; i < n; i++) {
      circleList.add(colorCircle(
          Colors.primaries[Random().nextInt(Colors.primaries.length)]));
    }
    return circleList;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}

class Project {
  final String projectName;
  final String projectColor;
  final int numSessions;
  final int numHours;
  final String projectNotes;
  final String startDate;
  final String endDate;
  final List<ProjectDay> endDate;

  const Project({required this.id, required this.title});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
    );
  }
}

class ProjectDay {
  final String eventName;
  final String timeDelta;
}

Future<Project> createProject(String title) async {
  final response = await http.post(
    Uri.parse('http://71.182.194.216:8080/planProject'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "projectName": "testName",
      "projectDeadline": "12/25/2022",
      "numSessions": "5",
      "numHours": "2"
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Project.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create project.');
  }
}

// // main list with data in it.
// //TODO this code is weird ill look at it later.
// FractionallySizedBox projectList(myData) {
//   List<Widget> projListItemList = <Widget>[];
//   return FractionallySizedBox(
//     widthFactor: 1,
//     child: Column(
//       children: [
//         projectFuture(myData, projListItemList),
//       ],
//     ),
//   );
// }

// //build the list at the bottom of the home screen and set the routes to be able to go into the per project view.
// FutureBuilder<String> projectFuture(myData, List<Widget> projListItemList) {
//   return FutureBuilder<String>(
//     future: myData,
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         String data = snapshot.data!;
//         final List<dynamic> projectNameList = jsonDecode(data);
//         for (var i = 0; i < projectNameList.length; i++) {
//           projListItemList.add(ProjListItem(
//             name: (projectNameList[i])['$i'].toString() + "$i",
//             route: "/showProject/$i", //NOTE2
//           ));

//           // print(projectNameList[i]);
//         }
//         return projectButtons(projListItemList);
//       } else if (snapshot.hasError) {
//         return Text('${snapshot.error}');
//       }

//       // By default, show a loading spinner.
//       return const CircularProgressIndicator();
//     },
//   );
// }

//a function to take an array of 7 ints and return a widget with horizontally sized boxes like this.
