import 'package:flutter/material.dart';

/// This widget creates the clock hand
/// using [_ClockHandPainter] as its [CustomPainter]
class ClockHand extends StatelessWidget {
  ClockHand({
    this.outerLineLength = 10,
    this.centerLineLength = 10,
    this.thickness = 8,
    this.outerSpacing = 20,
    this.centerCircleRadius = const Radius.circular(10),
    this.strokeColor = Colors.blue,
    this.fillColor = Colors.blue,
  })  : assert(outerLineLength >= 0),
        assert(centerLineLength >= 0),
        assert(thickness >= 0),
        assert(outerSpacing >= 0),
        assert(centerCircleRadius != null),
        assert(strokeColor != null),
        assert(fillColor != null);

  final int outerLineLength;
  final int centerLineLength;
  final int thickness;
  final int outerSpacing;
  final Radius centerCircleRadius;

  final Color strokeColor;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _ClockHandPainter(
          outerLineLength: outerLineLength,
          centerLineLength: centerLineLength,
          thickness: thickness,
          outerSpacing: outerSpacing,
          centerCircleRadius: centerCircleRadius,
          strokeColor: strokeColor,
          fillColor: fillColor,
        ),
      ),
    );
  }
}

/// The [CustomPainter] to draw the clock hand
class _ClockHandPainter extends CustomPainter {
  _ClockHandPainter({
    @required this.outerLineLength,
    @required this.centerLineLength,
    @required this.thickness,
    @required this.outerSpacing,
    @required this.centerCircleRadius,
    @required this.strokeColor,
    @required this.fillColor,
  });

  final int outerLineLength;
  final int centerLineLength;
  final int thickness;
  final int outerSpacing;
  final Radius centerCircleRadius;

  final Color strokeColor;
  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final centerCircle = _getCenterCirclePath(size);
    final innerLine = _getInnerLine(size);
    final outerLine = _getOuterLine(size);
    final clockHand = _getClockHandPath(
      size,
      centerLineLength,
      thickness,
      outerSpacing,
      outerLineLength,
    );

    final offset = Offset.zero;
    final path = Path()
      ..addPath(centerCircle, offset)
      ..addPath(innerLine, offset)
      ..addPath(outerLine, offset)
      ..addPath(clockHand, offset);

    canvas.drawPath(path, paint);

    // Fill the clock hand
    paint
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(clockHand, paint);
  }

  Path _getInnerLine(Size size) {
    final center = size.center(Offset.zero);

    return Path()
      ..moveTo(center.dx, center.dy - centerCircleRadius.y / 2)
      ..lineTo(center.dx, center.dy - centerLineLength);
  }

  Path _getOuterLine(Size size) {
    final topCenter = size.topCenter(Offset.zero);

    return Path()
      ..moveTo(topCenter.dx, topCenter.dy + outerSpacing + outerLineLength)
      ..lineTo(topCenter.dx, topCenter.dy + outerSpacing);
  }

  Path _getCenterCirclePath(Size size) {
    final center = size.center(Offset.zero);

    return Path()
      ..moveTo(center.dx, center.dy)
      ..addOval(Rect.fromCenter(
        center: center,
        width: centerCircleRadius.x,
        height: centerCircleRadius.y,
      ));
  }

  Path _getClockHandPath(
    Size size,
    int centerLineSize,
    int pointerSize,
    int outerSpacing,
    int outerLineSize,
  ) {
    final path = Path();

    final center = size.center(Offset.zero);
    final topCenter = size.topCenter(Offset.zero);

    final bottomCorner = center.dy - centerLineSize;
    final topCorner = topCenter.dy + outerSpacing + outerLineSize;

    final diagonalHalfSize = pointerSize / 2;

    path.moveTo(center.dx, bottomCorner);

    // bottom left diagonal
    path.lineTo(
      center.dx - diagonalHalfSize,
      bottomCorner - diagonalHalfSize,
    );

    // left line
    path.lineTo(
      center.dx - diagonalHalfSize,
      topCorner + diagonalHalfSize,
    );

    // top left diagonal
    path.lineTo(
      center.dx,
      topCorner,
    );

    // top right diagonal
    path.lineTo(
      center.dx + diagonalHalfSize,
      topCorner + diagonalHalfSize,
    );

    // right line
    path.lineTo(
      center.dx + diagonalHalfSize,
      bottomCorner - diagonalHalfSize,
    );

    // bottom right diagonal
    path.lineTo(
      center.dx,
      bottomCorner,
    );

    return path;
  }

  @override
  bool shouldRepaint(_ClockHandPainter oldDelegate) {
    return oldDelegate.outerLineLength != outerLineLength ||
        oldDelegate.centerLineLength != centerLineLength ||
        oldDelegate.thickness != thickness ||
        oldDelegate.outerSpacing != outerSpacing ||
        oldDelegate.centerCircleRadius != centerCircleRadius ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.fillColor != fillColor;
  }
}
