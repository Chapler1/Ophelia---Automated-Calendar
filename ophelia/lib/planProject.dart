import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import 'myappbar.dart';

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
