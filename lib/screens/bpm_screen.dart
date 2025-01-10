import 'package:flutter/material.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/styles.dart';

class BpmScreen extends StatefulWidget {
  const BpmScreen({super.key});

  @override
  BpmScreenState createState() => BpmScreenState();
}

class BpmScreenState extends State<BpmScreen> with AutomaticKeepAliveClientMixin<BpmScreen> {
  @override
  bool get wantKeepAlive => true;
  // BPM Variables
  int _beatsPerMinute = 0;
  int _numOfTaps = 0;
  DateTime _startTime = DateTime.now();
  DateTime _lastTap = DateTime.now();

  void _setBpm() {
    if (_numOfTaps == 0) {
      _startTime = DateTime.now();
    }

    if (DateTime.now().difference(_lastTap).inMilliseconds > 5000) {
      _resetBPM();
    }

    _numOfTaps += 1;
    DateTime currentTime = DateTime.now();
    int timeElapsed = currentTime.difference(_startTime).inMilliseconds;
    _lastTap = DateTime.now();

    if (timeElapsed == 0) {
      timeElapsed = 400;
    }

    setState(() => _beatsPerMinute = (60000 * _numOfTaps) ~/ timeElapsed);
  }

  void _resetBPM() {
    _numOfTaps = 0;
    _startTime = DateTime.now();
    _lastTap = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: const Alignment(0.0, -0.85),
                child: Text(
                  'BPM Clicker',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: AppTextStyle.heading(color: Colors.black),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.4),
                child: Text(
                  '$_beatsPerMinute BPM',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: AppTextStyle.setSize(color: AppTheme.secondary40, fontSize: 34),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.0),
                child: MaterialButton(
                  onPressed: _setBpm,
                  color: AppTheme.secondary90,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  height: 10,
                  minWidth: 120,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Tap',
                    style: AppTextStyle.large(color: AppTheme.secondary10),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.7),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _resetBPM();
                      _beatsPerMinute = 0;
                    });
                  },
                  color: AppTheme.primary80,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  height: 8,
                  minWidth: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Reset',
                    style: AppTextStyle.medium(color: AppTheme.primary10),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}