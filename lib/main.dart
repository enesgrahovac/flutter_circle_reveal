import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'circle_painter.dart';

import 'page_1.dart' as page_one;
import 'page_2.dart' as page_two;
import 'page_3.dart' as page_three;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _transitionPercent;

  Widget currentPage;
  Widget secondPage;
  Widget thirdPage;
  Widget visiblePage;

  Color currentCircleColor;
  Color backgroundColor;
  Color nextCircleColor;

  int currentPageIndex;
  int secondPageIndex;
  int thirdPageIndex;

  List pages;
  List<Color> colors;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )
      ..addListener(() {
        setState(() {
          _transitionPercent = _animationController.value;
          if (_transitionPercent > 0.5) {
            visiblePage = secondPage;
          }
        });
      })
      ..addStatusListener((status) {
        setState(() {
          if (status == AnimationStatus.completed) {
            currentPageIndex = currentPageIndex + 1;
            currentPageIndex = currentPageIndex % pages.length;
            secondPageIndex = currentPageIndex + 1;
            secondPageIndex = secondPageIndex % pages.length;
            thirdPageIndex = secondPageIndex + 1;
            thirdPageIndex = thirdPageIndex % pages.length;
            currentPage = pages[currentPageIndex];
            secondPage = pages[secondPageIndex];
            thirdPage = pages[thirdPageIndex];
            _animationController.value = 0;
            _transitionPercent = 0;
          }
        });
      });

    _transitionPercent = 0;

    // initialize the colors for each page of the app, manually
    colors = [
      page_one.backgroundColor,
      page_two.backgroundColor,
      page_three.backgroundColor,
    ];

    // manually initialize the content of each page for
    // easy iteration.
    pages = [
      page_one.PageOne(
        changePage: () {
          nextPage();
        },
      ),
      page_two.PageTwo(
        changePage: () {
          nextPage();
        },
      ),
      page_three.PageThree(
        changePage: () {
          nextPage();
        },
      ),
    ];

    currentPage = pages[0];
    secondPage = pages[1];
    thirdPage = pages[2];
    visiblePage = pages[0];

    currentPageIndex = 0;
    secondPageIndex = 1;
    thirdPageIndex = 2;

    // );

    super.initState();
  }

  nextPage() {
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Device screen width.
    double width = MediaQuery.of(context).size.width;

    // Calculate the position of the onboarding content
    final double maxOffset = width/1.5;

    double offsetPercent = 1;
    if (_transitionPercent <= 0.25) {
      offsetPercent = -_transitionPercent / 0.25;
    } else if (_transitionPercent >= 0.7) {
      offsetPercent = (1.0 - _transitionPercent) / 0.3;
      offsetPercent = Curves.easeInCubic.transform(offsetPercent);
    }
    final contentOffset = offsetPercent * maxOffset;
    final double contentScale = 0.6 + (0.4 * (1.0 - offsetPercent.abs()));

    print("CURENT PAGE: $currentPageIndex");
    print("Second: $secondPageIndex");
    print("Third: $thirdPageIndex");
    // currentPage = pages[currentPageIndex];
    backgroundColor = colors[currentPageIndex];
    currentCircleColor = colors[secondPageIndex];
    nextCircleColor = colors[thirdPageIndex];

    return CustomPaint(
      painter: CircleTransitionPainter(
        currentCircleColor: currentCircleColor,
        backgroundColor: backgroundColor,
        nextCircleColor: nextCircleColor,
        transitionPercent: _transitionPercent,
      ),
      child: Transform(
          transform: Matrix4.translationValues(contentOffset, 0, 0)
            ..scale(contentScale, contentScale),
          alignment: Alignment.center,
          child: visiblePage),
    );
  }
}
