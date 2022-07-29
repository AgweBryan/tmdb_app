import 'package:flutter/material.dart';
import 'package:tmdb_app/constants.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  BasicOverlayWidget({Key? key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildPlayIcon(),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: buildIndicator(),
        )
      ],
    );
  }

  Widget buildPlayIcon() => controller.value.isPlaying
      ? SizedBox()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Icon(
            Icons.play_arrow,
            size: 80,
            color: Colors.white,
          ));

  Widget buildIndicator() {
    return VideoProgressIndicator(
      controller,
      allowScrubbing: false,
      colors: VideoProgressColors(
          playedColor: buttonColor, backgroundColor: Colors.transparent),
    );
  }
}
