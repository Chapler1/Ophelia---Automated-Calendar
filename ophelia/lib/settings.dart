import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'myappbar.dart';

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
