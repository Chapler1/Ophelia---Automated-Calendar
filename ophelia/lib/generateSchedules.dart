import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import 'myappbar.dart';
import 'package:http/http.dart' as http;

class GenerateSchedules extends StatefulWidget {
  const GenerateSchedules({super.key, required this.id});

  final String id;

  @override
  _GenerateSchedules createState() => _GenerateSchedules();
}

Future<String> getProjectById(projId) async {
  final response = await http
      .get(Uri.parse('http://71.182.194.216:8080/getProject?id=$projId'));

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

class _GenerateSchedules extends State<GenerateSchedules> {
  late Future<String> myData;
  @override
  void initState() {
    super.initState();
    myData = getProjectById(widget.id); //NOTE4
  }

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
