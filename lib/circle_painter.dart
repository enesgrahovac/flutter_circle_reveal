import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
class CircleTransitionPainter extends CustomPainter {
  CircleTransitionPainter({
    Color backgroundColor,
    Color currentCircleColor,
    Color nextCircleColor,
    this.transitionPercent = 0,
  })  : backgroundPaint = Paint()..color = backgroundColor,
        currentCirclePaint = Paint()..color = currentCircleColor,
        nextCirclePaint = Paint()..color = nextCircleColor;

  final double baseCircleRadius = 36.0;
  final Paint backgroundPaint;
  final Paint currentCirclePaint;
  final Paint nextCirclePaint;
  final double transitionPercent;

  @override
  void paint(Canvas canvas, Size size) {
    if (transitionPercent < 0.5) {
      final double expansionPercent = transitionPercent / 0.5;
      print("Expansion Percent: $expansionPercent");
      paintExpansion(canvas, size, expansionPercent);
    } else {
      final double contractionPercent = (transitionPercent - .5) / 0.5;
      print("Contraction Percent: $contractionPercent");
      paintContraction(canvas, size, contractionPercent);
    }
  }

  void paintExpansion(Canvas canvas, Size size, expansionPercent) {
    // Maximum radius of circle to look vertical
    final double maxRadius = 200 * size.height;

    // The original center position of the circle.
    Offset baseCircleCenter = Offset(size.width / 2, size.height * .76);

    // Left side of circle, which never moves during expansion.
    final double circleLeftBound = baseCircleCenter.dx - baseCircleRadius;

    // Apply exponential reduction to slow down expansion of circle
    final double slowedExpansionRate = pow(expansionPercent, 8);

    // Current Radius of circle
    final double currentRadius =
        (maxRadius * slowedExpansionRate) + baseCircleRadius;

    // Current center of circle
    final Offset currentCircleCenter =
        Offset(circleLeftBound + currentRadius, baseCircleCenter.dy);

    // Paint the Background
    canvas.drawPaint(backgroundPaint);

    // Paint the Circle
    canvas.drawCircle(currentCircleCenter, currentRadius, currentCirclePaint);

    // Paint the Chevron
    if (expansionPercent < 0.2) {
      paintChevron(canvas, baseCircleCenter, backgroundPaint.color);
    }
  }

  void paintContraction(Canvas canvas, Size size, contractionPercent) {
    // Maximum radius of circle to look vertical
    final double maxRadius = 200 * size.height;

    // The original center position of the circle.
    Offset baseCircleCenter = Offset(size.width / 2, size.height * .76);

    // Initial right side of circle, which becomes starting left side by end of
    // animation.
    final double circleStartingRightSide =
        baseCircleCenter.dx - baseCircleRadius;

    // The final right side of the circle.
    final double circleEndingRightSide = baseCircleCenter.dx + baseCircleRadius;

    // Apply exponential reduction to slow down contraction of circle
    final double easedContractionPercent =
        Curves.easeInOut.transform(contractionPercent);
    final double inverseContractionPercent = 1 - contractionPercent;
    final double slowedInverseContractionPercent =
        pow(inverseContractionPercent, 8);

    // Current Radius of circle
    final double currentRadius =
        (maxRadius * slowedInverseContractionPercent) + baseCircleRadius;

    // Calculate current right side of the circle.
    final double circleCurrentRightSide = circleStartingRightSide +
        ((circleEndingRightSide - circleStartingRightSide) *
            easedContractionPercent);
    final double circleCurrentCenterX = circleCurrentRightSide - currentRadius;
    // print(circleCurrentCenterX);

    // Current center of circle
    final Offset currentCircleCenter =
        Offset(circleCurrentCenterX, baseCircleCenter.dy);

    // Paint the Background
    canvas.drawPaint(currentCirclePaint);

    // Paint the Circle
    canvas.drawCircle(currentCircleCenter, currentRadius, backgroundPaint);

    // Paint the new expanding circle
    if (easedContractionPercent > 0.9) {
      double newCircleExpansionPercent = (easedContractionPercent - 0.9) / .1;
      double newCircleRadius = baseCircleRadius * newCircleExpansionPercent;

      canvas.drawCircle(
        currentCircleCenter,
        newCircleRadius,
        nextCirclePaint,
      );
    }

    // Paint the Chevron
    if (contractionPercent > 0.95) {
      paintChevron(canvas, baseCircleCenter, currentCirclePaint.color);
    }
  }

  void paintChevron(Canvas canvas, Offset circleCenter, Color color) {
    final IconData chevronIcon = Icons.art_track;

    final ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontFamily: chevronIcon.fontFamily,
        fontSize: 17,
        textAlign: TextAlign.center,
      ),
    )
      ..pushStyle(ui.TextStyle(color: color))
      ..addText("Next");
    // ..addText(String.fromCharCode(chevronIcon.codePoint)); // icon does not work on chrome. Might work on mobile.

    final ui.Paragraph paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: baseCircleRadius));
    canvas.drawParagraph(paragraph,
        circleCenter - Offset(paragraph.width / 2, paragraph.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
