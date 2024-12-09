import 'package:flutter/material.dart';
import 'package:flutter_music_application/styles.dart';

class ChartRow extends StatelessWidget {
  final int interval;

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

  final double? width = 50;
  final EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 32.0);
  final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween;

  ChartRow({
    super.key,
    required this.interval,
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
              intervalMap[interval]!,
              textAlign: TextAlign.center,
              style: AppTextStyle.bold(context, color: Colors.black),
            ),
          ),
          Image.asset(
            'assets/chord_imgs/F/1.png',
            width: MediaQuery.of(context).size.width / 3,
          ),
          Image.asset(
            'assets/chord_imgs/F/4.png',
            width: MediaQuery.of(context).size.width / 3,
          ),
        ],
      ),
    );
  }
}
