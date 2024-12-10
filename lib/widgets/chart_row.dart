import 'package:flutter/material.dart';
import 'package:flutter_music_application/styles.dart';

class ChartRow extends StatelessWidget {
  final int interval;
  final String keySignature;
  final String chord;

  // Constant Values
  final Map<int, String> intervalMap = {
    1: 'I',
    2: 'ii',
    3: 'iii',
    4: 'IV',
    5: 'V',
    6: 'vi',
    7: 'vii°'
  };

  final double? width = 70;
  final EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(8.0, 32.0, 16.0, 32.0);
  final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween;

  ChartRow({
    super.key,
    required this.keySignature,
    required this.interval,
    required this.chord,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          SizedBox(
            width: width,
            child: Text(
              '${intervalMap[interval]!}\n$chord',
              textAlign: TextAlign.center,
              style: AppTextStyle.bold(context, color: Colors.black),
            ),
          ),
          Image.asset(
            'assets/charts/piano/$keySignature/$interval.png',
            width: MediaQuery.of(context).size.width / 3,
          ),
          Image.asset(
            'assets/charts/piano/$keySignature/$interval.png',
            width: MediaQuery.of(context).size.width / 3,
          ),
        ],
      ),
    );
  }
}
