import 'package:flutter/material.dart';

/// This widget creates the fluid animation
/// based on the [currentTime]
/// and animates through the [animationDuration]
///
/// If the [currentTime] changes it will be synchronized,
/// so we can guarantee that the current rotation
/// based on the [currentTime] is accurate
class TimedRotation extends StatefulWidget {
  TimedRotation({
    Key key,
    @required this.currentTime,
    @required this.animationDuration,
    @required this.child,
  })  : assert(currentTime != null),
        assert(animationDuration != null),
        assert(child != null),
        super(key: key);

  final Duration currentTime;
  final Duration animationDuration;
  final Widget child;

  @override
  TimedRotationState createState() => TimedRotationState();
}

class TimedRotationState extends State<TimedRotation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _rotationAnimation;

  double get rotation => _rotationAnimation.value;
  AnimationController get controller => _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _rotationAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _startAnimationFromCurrentStep();
      }
    });

    _startAnimationFromCurrentStep();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startAnimationFromCurrentStep();
  }

  _startAnimationFromCurrentStep() {
    final currentStep = _getCurrentStep();
    if (_animationController?.status != AnimationStatus.forward ||
        _animationController?.value != currentStep) {
      _animationController?.forward(from: currentStep);
    }
  }

  double _getCurrentStep() =>
      widget.currentTime.inSeconds / widget.animationDuration.inSeconds;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: widget.child,
    );
  }
}
