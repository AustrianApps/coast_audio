import 'package:flutter/material.dart';
import 'package:flutter_coast_audio_miniaudio/flutter_coast_audio_miniaudio.dart';
import 'package:music_player/player/isolated_music_player.dart';
import 'package:provider/provider.dart';

class PositionSlider extends StatelessWidget {
  const PositionSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isReady = context.select<IsolatedMusicPlayer, bool>((p) => p.state != MabAudioPlayerState.stopped);
    final duration = context.select<IsolatedMusicPlayer, AudioTime>((p) => p.duration);
    final position = context.select<IsolatedMusicPlayer, AudioTime>((p) => p.position);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          child: Text(
            position.formatMMSS(),
            style: const TextStyle(
              height: 1,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: position.seconds,
            min: 0,
            max: duration.seconds,
            onChanged: isReady
                ? (position) {
                    context.read<IsolatedMusicPlayer>().position = AudioTime(position);
                  }
                : null,
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            (duration - position).formatMMSS(),
            style: const TextStyle(
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
