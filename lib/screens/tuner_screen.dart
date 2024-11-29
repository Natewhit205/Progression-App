import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/widgets/start_stop_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_music_application/permissions.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';


class TunerScreen extends StatefulWidget {
  const TunerScreen({super.key});

  @override
  TunerScreenState createState() {
    return TunerScreenState();
  }
}

class TunerScreenState extends State<TunerScreen> with AutomaticKeepAliveClientMixin<TunerScreen> {
  @override
  bool get wantKeepAlive => true;

  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(audioSampleRate: 44100, bufferSize: 2000);
  final pitchupDart = PitchHandler(InstrumentType.guitar);

  String _note = "C";
  String _status = "Press Start";
  bool _listening = false;

  Future<void> _startRecording() async {
    if (await Permission.microphone.isGranted) {
      try {
        await _audioRecorder.start(listener, onError, sampleRate: 44100, bufferSize: 3000);
        setState(() {
          _status = "Recording";
          _listening = true;
        });
      } catch (e) {
        print('Recording Error: $e');
      }
    } else {
      requestPermissions();
    }
  }

  Future<void> _stopRecording() async {
    await _audioRecorder.stop();
    setState(() {
      _status = "Press Start";
      _listening = false;
    });
  }

  void listener(dynamic obj) {
    // Get audio from user
    Float64List buffer = Float64List.fromList(obj.cast<double>());
    final List<double> audioSample = buffer.toList();

    pitchDetectorDart.getPitchFromFloatBuffer(audioSample).then((result) {
      if (result.pitched) {
        pitchupDart.handlePitch(result.pitch).then((handledPitchResult) {
          if (handledPitchResult.note != '') {
            setState(() {
              _note = handledPitchResult.note;
            });
          }
        });
      }
    });
  }

  void onError(Object e) {
    print(e);
  }

  @override
  void initState() {
    super.initState();
    _audioRecorder.init();
  }

  @override
  void dispose() {
    _audioRecorder.stop();
    super.dispose();
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
              const Align(
                alignment: Alignment(0.0, -0.85),
                child: Text(
                  'Tuner',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 36,
                    color: Colors.black,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.1),
                child: Text(
                  _note,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 96,
                    color: AppTheme.primaryAccent,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.5),
                child: !_listening ? StartStopButton(
                  onPressed: _startRecording,
                  color: AppTheme.secondary,
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ) : StartStopButton(
                  onPressed: _stopRecording,
                  color: AppTheme.primaryAccent,
                  child: const Text(
                    'Stop',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.9),
                child: Text(
                  _status,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                    color: Colors.grey,
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