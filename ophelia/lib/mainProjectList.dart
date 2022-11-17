import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

/*
    projectList() - Project Container positioned to bottom of the screen
    Container with a list view of list items inside of it.
  */
Future<String> fetchNames() async {
  final response =
      await http.get(Uri.parse('http://71.182.194.216:8080/getProjectNames'));

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
        projectFuture(myData, projListItemList),
      ],
    ),
  );
}

FutureBuilder<String> projectFuture(myData, List<Widget> projListItemList) {
  return FutureBuilder<String>(
    future: myData,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        String data = snapshot.data!;
        final List<dynamic> projectNameList = jsonDecode(data);
        for (var i = 0; i < projectNameList.length; i++) {
          projListItemList
              .add(ProjListItem((projectNameList[i])['$i'].toString() + "$i"));

          print(projectNameList[i]);
        }
        return projectButtons(projListItemList);
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }

      // By default, show a loading spinner.
      return const CircularProgressIndicator();
    },
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
