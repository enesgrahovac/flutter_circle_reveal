import 'package:flutter/material.dart';
import 'global_vars.dart';

final Color backgroundColor = Colors.white;

class PageTwo extends StatefulWidget {
  // Run Command + D
  // on the "PageTwo" finds and change it to the page number
  // For example: PageThree for the third page in the process.
  final Function() changePage;
  const PageTwo({Key key, this.changePage}) : super(key: key);
  @override
  _PageTwo createState() => _PageTwo();
}

class _PageTwo extends State<PageTwo> {
  _changePage() {
    setState(
      () {
        widget.changePage();
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Positioned(
          left: ((width / 2) - width * .1125),
          top: ((height * .2) - buttonRadius),
          child: Container(
            width: width * .25,
            height: width * .25,
            color: Colors.purple,
            child: Text(
              "PAGE 2!",
              style: TextStyle(fontSize: 36, color:backgroundColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          left: ((width / 2) - buttonRadius),
          top: ((height * .76) - buttonRadius),
          child: Container(
            height: buttonRadius * 2,
            width: buttonRadius * 2,
            // color:Colors.blue,
            alignment: Alignment(1, 0),
            child: GestureDetector(
              onTap: () {
                _changePage();
              },
            ),
          ),
        ),
      ],
    );
  }
}
