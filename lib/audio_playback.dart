import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AudioPlayback {
  final player = AudioPlayer();
  String filePath = '';

  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _getFile(List<String> chordProgression) async {
    const url = '10.0.2.2:5000';
    const endpoint = '/get-audio';

    try {
      final response = await post(
        Uri.http(url, endpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'chords': chordProgression})
      );

      if (response.statusCode == 200) {
        final Uint8List data = response.bodyBytes;
        final localFileDirectory = await _getLocalPath();
        final outIoFile = join(localFileDirectory, 'chord.mp3');
        print('File Path $outIoFile');
        filePath = outIoFile;
        await Directory(dirname(outIoFile)).create(recursive: true);
        await File(outIoFile).writeAsBytes(data);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Duration> playAudio(List<String> chordProgression) async {
    player.stop();
    await _getFile(chordProgression);
    await player.setAudioSource(AudioSource.file(filePath));
    await player.play();
    return player.duration!;
  }

  void stopAudio() {
    player.stop();
  }
}