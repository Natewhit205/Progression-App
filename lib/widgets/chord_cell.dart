import 'package:flutter/material.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/constants.dart';
import 'package:flutter_music_application/styles.dart';

class ChordCell extends StatelessWidget {
  final String name;

  // Constant Values
  final Color? color = AppTheme.secondary90;
  final ShapeBorder? shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  );
  final Color? textColor = AppTheme.secondary10;
  final EdgeInsetsGeometry? padding = const EdgeInsets.all(8);

  const ChordCell({
    super.key,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: padding,
      color: AppTheme.primary40,
      child: Text(
        name,
        style: AppTextStyle.large(color: AppTheme.surface),
      ),
    );
  }
}