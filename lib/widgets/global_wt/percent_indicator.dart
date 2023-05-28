import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentLinearWidget extends StatelessWidget {
  final double percent;
  final Color color;
  const PercentLinearWidget(
      {Key? key, required this.percent, required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      animation: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      lineHeight: 16,
      percent: percent,
      barRadius: const Radius.circular(10),
      // progressColor: color,
      linearGradient: LinearGradient(colors: [
        Colors.grey,
        color,
        color,
      ]),
      center: Text(
        '${(percent * 100).toStringAsFixed(2)}%',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}

class PercentCircular extends StatelessWidget {
  final double percent;
  final double radius;
  final Color color;
  final ArcType arcType;

  const PercentCircular(
      {super.key,
      required this.percent,
      required this.radius,
      required this.color,
      required this.arcType});

  @override
  Widget build(BuildContext context) {
    var finalPercent = percent;
    if (finalPercent > 1) finalPercent = 1;

    return CircularPercentIndicator(
      animationDuration: 1500,
      percent: finalPercent,
      radius: radius,
      progressColor: color,
      arcType: arcType,
      lineWidth: 20,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        '${(finalPercent * 100).toStringAsFixed(2)}%',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}
