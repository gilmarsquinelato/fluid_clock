import 'package:fluid_clock/geometry.dart';
import 'package:flutter/material.dart';

/// This widget creates the lines around the clock
/// using [_ClockDecorationPainter] as its [CustomPainter]
class ClockDecoration extends StatelessWidget {
  ClockDecoration({
    @required this.secondsColor,
    @required this.secondsLength,
    @required this.minutesColor,
    @required this.minutesLength,
    @required this.hoursColor,
    @required this.hoursLength,
    @required this.outerSpacing,
  })  : assert(secondsColor != null),
        assert(secondsLength > 0),
        assert(hoursColor != null),
        assert(hoursLength > 0),
        assert(outerSpacing >= 0);

  final Color secondsColor;
  final double secondsLength;

  final Color minutesColor;
  final double minutesLength;

  final Color hoursColor;
  final double hoursLength;

  final double outerSpacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _ClockDecorationPainter(
          secondsColor: secondsColor,
          secondsLength: secondsLength,
          minutesColor: minutesColor,
          minutesLength: minutesLength,
          hoursColor: hoursColor,
          hoursLength: hoursLength,
          outerSpacing: outerSpacing,
        ),
      ),
    );
  }
}

/// The [CustomPainter] to draw the clock decoration
class _ClockDecorationPainter extends CustomPainter {
  _ClockDecorationPainter({
    @required this.secondsColor,
    @required this.secondsLength,
    @required this.minutesColor,
    @required this.minutesLength,
    @required this.hoursColor,
    @required this.hoursLength,
    @required this.outerSpacing,
  });

  final Color secondsColor;
  final double secondsLength;

  final Color minutesColor;
  final double minutesLength;

  final Color hoursColor;
  final double hoursLength;

  final double outerSpacing;

  @override
  void paint(Canvas canvas, Size size) {
    // make sure that it will start from middle top
    final startAngle = -90.0;

    final center = size.center(Offset.zero);
    final radius = size.height / 2 - outerSpacing;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final outerCircle = Circle(center, radius);

    // Outer circles
    final secondsOuterCircle = Circle(center, radius - secondsLength);
    final hoursOuterCircle = Circle(center, radius - hoursLength);
    final minutesOuterCircle = Circle(center, radius - minutesLength);

    // Seconds lines decoration
    // 120 = 12 lines (hours) * 10 (seconds passed between each hour line)
    final secondsLinesPath = _getLinesPath(
      120,
      startAngle,
      outerCircle,
      secondsOuterCircle,
    );
    paint.color = secondsColor;
    canvas.drawPath(secondsLinesPath, paint);

    // Minutes lines decoration
    // 60 = 60 minutes
    final minutesLinesPath = _getLinesPath(
      60,
      startAngle,
      outerCircle,
      minutesOuterCircle,
    );
    paint.color = minutesColor;
    canvas.drawPath(minutesLinesPath, paint);

    // Hours lines decoration
    // 12 = 12 lines of hour
    final hoursLinesPath = _getLinesPath(
      12,
      startAngle,
      outerCircle,
      hoursOuterCircle,
    );
    paint.color = hoursColor;
    canvas.drawPath(hoursLinesPath, paint);
  }

  /// Creates a path with all lines based on the [lineCount]
  Path _getLinesPath(
    int lineCount,
    double startAngle,
    Circle outerCircle,
    Circle innerCircle,
  ) {
    final path = Path();
    final degreesPerLine = 360 / lineCount;

    for (var i = 0; i < lineCount; i++) {
      final line = innerCircle.createLine(
        outerCircle,
        startAngle + degreesPerLine * i,
      );
      final linePath = _getLinePath(line);
      path.addPath(linePath, Offset.zero);
    }

    return path;
  }

  /// Creates a path representing the given [Line] object
  Path _getLinePath(Line line) {
    return Path()
      ..moveTo(line.start.dx, line.start.dy)
      ..lineTo(line.end.dx, line.end.dy);
  }

  @override
  bool shouldRepaint(_ClockDecorationPainter oldDelegate) {
    return oldDelegate.secondsColor != secondsColor ||
        oldDelegate.secondsLength != secondsLength ||
        oldDelegate.hoursColor != hoursColor ||
        oldDelegate.hoursLength != hoursLength ||
        oldDelegate.outerSpacing != outerSpacing;
  }
}
