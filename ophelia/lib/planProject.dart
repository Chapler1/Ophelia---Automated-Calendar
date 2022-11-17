import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
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

//a function to take an array of 7 ints and return a widget with horizontally sized boxes like this.
