import 'dart:math';
import 'dart:ui';
import 'package:vector_math/vector_math_64.dart' show radians;

/// A circle representation with the given center position and its radius
class Circle {
  const Circle(this.center, this.radius);

  final Offset center;
  final double radius;

  /// Calculates the position of a point inside a circle by the given angle
  Offset getPoint(double angle) {
    var angleSin = sin(radians(angle));
    var angleCos = cos(radians(angle));

    return Offset(
      radius * angleCos + center.dx,
      radius * angleSin + center.dy,
    );
  }

  /// Creates a [Line] based on the current circle and the [other] circle
  /// with the desired [angle]
  Line createLine(Circle other, double angle) {
    var start = getPoint(angle);
    var end = other.getPoint(angle);

    return Line(start, end);
  }
}


/// A line representation with a [start] and [end] point
class Line {
  const Line(this.start, this.end);

  final Offset start;
  final Offset end;
}