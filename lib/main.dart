import 'dart:ui' as ui;

import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircleTransitionPainter(
        backgroundColor: Colors.red,
        currentCircleColor: Colors.white,
        nextCircleColor: Colors.grey,
      ),
    );
  }
}

class CircleTransitionPainter extends CustomPainter {
  CircleTransitionPainter({
    Color backgroundColor,
    Color currentCircleColor,
    Color nextCircleColor,
    this.transitionPercent = 0,
  })  : backgroundPaint = Paint()..color = backgroundColor,
        currentCirclePaint = Paint()..color = currentCircleColor,
        nextCirclePaint = Paint()..color = nextCircleColor;

  final double baseRadius = 36.0;
  final Paint backgroundPaint;
  final Paint currentCirclePaint;
  final Paint nextCirclePaint;
  final double transitionPercent;

  @override
  void paint(Canvas canvas, Size size) {
    // Paint the Background
    canvas.drawPaint(backgroundPaint);

    // Paint the Circle
    Offset circleCenter = Offset(size.width / 2, size.height * .76);
    canvas.drawCircle(circleCenter, baseRadius, currentCirclePaint);

    // Paint the Chevron
    final IconData chevronIcon = Icons.art_track;

    final ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontFamily: chevronIcon.fontFamily,
        fontSize: 17,
        textAlign: TextAlign.center,
      ),
    )
      ..pushStyle(ui.TextStyle(color: backgroundPaint.color))
      ..addText("Next");
      // ..addText(String.fromCharCode(chevronIcon.codePoint));

    final ui.Paragraph paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: baseRadius));
    canvas.drawParagraph(paragraph,
        circleCenter - Offset(paragraph.width / 2, paragraph.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
