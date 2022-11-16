import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
