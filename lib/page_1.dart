import 'package:flutter/material.dart';
import 'global_vars.dart';

final Color backgroundColor = Colors.red;

class PageOne extends StatefulWidget {
  final Function() changePage;
  final Function(Map<String, Color>) getCurrentColors;
  final bool currentPage;
  // final Color backgroundColor;
  const PageOne(
      {Key key, this.changePage, this.currentPage, this.getCurrentColors})
      : super(key: key);

  @override
  _PageOne createState() => _PageOne();
}

class _PageOne extends State<PageOne> {
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
        // Slider(
        //   value: _transitionPercent,
        //   onChanged: (value) {
        //     updateSliderVal(value);
        //   },
        // ),
        Positioned(
          left: ((width / 2) - width * .1125),
          top: ((height * .2) - buttonRadius),
          child: Container(
            width: width * .25,
            height: width * .25,
            color: Colors.blue,
            child: Text(
              "PAGE 1!",
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
            )),
      ],
    );
  }
}
