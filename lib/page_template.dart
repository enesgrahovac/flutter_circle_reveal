import 'package:flutter/material.dart';
import 'global_vars.dart';

final Color circleColor = Colors.white;
final Color backgroundColor = Colors.red;
final Color nextCircleColor = Colors.grey;

class PageNumber extends StatefulWidget {
  // Run Command + D
  // on the "PageNumber" finds and change it to the page number
  // For example: PageThree for the third page in the process.
  final Function() changePage;
  const PageNumber({Key key, this.changePage}) : super(key: key);
  @override
  _PageNumber createState() => _PageNumber();
}

class _PageNumber extends State<PageNumber> {
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
          left: ((width / 2) - buttonRadius),
          top: ((height * .76) - buttonRadius),
          child: Container(
            height: buttonRadius * 2,
            width: buttonRadius * 2,
            // color:Colors.blue,
            alignment: Alignment(1, 0),
            child: GestureDetector(onTap: () {
              _changePage();
            }),
          ),
        ),
      ],
    );
  }
}
