import 'package:flutter/material.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/styles.dart';

class ChordCell extends StatelessWidget {
  final String name;
  final int number;

  // Constant Values
  final Color? color = AppTheme.secondary90;
  final ShapeBorder? shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  );
  final Color? textColor = AppTheme.secondary10;
  final EdgeInsetsGeometry? padding = const EdgeInsets.all(8);

  const ChordCell({
    super.key,
    required this.number,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      color: AppTheme.secondary40,
      child: Text(
        '$number: $name',
        style: AppTextStyle.medium(color: AppTheme.surface),
      ),
    );
  }
}