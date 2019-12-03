import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

import 'analog_clock/analog_clock.dart';
import 'details_panel/details_panel.dart';

class FluidClock extends StatefulWidget {
  FluidClock(this.model);

  final ClockModel model;

  @override
  _FluidClockState createState() => _FluidClockState();
}

class _FluidClockState extends State<FluidClock> {
  Timer _timer;
  DateTime _now = DateTime.now();

  final _analogClockPadding = 80;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _synchronizeTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(FluidClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _synchronizeTime() {
    setState(() {
      _now = DateTime.now();

      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _synchronizeTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final analogClockHeight = screenHeight - _analogClockPadding;

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.5, 0),
          radius: 1.2,
          colors: <Color>[
            Theme.of(context).accentColor,
            TinyColor(Theme.of(context).accentColor).lighten(10).color,
          ],
        ),
      ),
      child: Center(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: analogClockHeight,
                height: analogClockHeight,
                child: AnalogClock(
                  currentTime: _now,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: DetailsPanel(
                  currentTime: _now,
                  model: widget.model,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
