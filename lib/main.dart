import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'circle_painter.dart';

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

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )
      ..addListener(() {
        setState(() {
          _transitionPercent = _animationController.value;
        });
      })
      ..addStatusListener((status) {
        setState(() {});
      });

    _transitionPercent = 0;
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double buttonRadius = 36;
    updateSliderVal(value) {
      setState(() {
        _animationController.value = value;
      });
    }
    nextPage(){
      _animationController.forward(from:0);
    }

    return CustomPaint(
      painter: CircleTransitionPainter(
        backgroundColor: Colors.red,
        currentCircleColor: Colors.white,
        nextCircleColor: Colors.grey,
        transitionPercent: _transitionPercent,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // Slider(
              //   value: _transitionPercent,
              //   onChanged: (value) {
              //     updateSliderVal(value);
              //   },
              // ),
              Positioned(left:((width/2)-buttonRadius),top:((height*.76)-buttonRadius),child:Container(
                height:buttonRadius*2,
                width:buttonRadius*2,
                // color:Colors.blue,
                alignment: Alignment(1,0),
                child: GestureDetector(onTap:(){nextPage();}),
              )),
            ],
          ),
        ),
    );
  }
}
