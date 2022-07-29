import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tmdb_app/views/widgets/overlay_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  final DefaultCacheManager defaultCacheManager = DefaultCacheManager();
  bool isCached = false;
  File? videoFile;

  getCachedVideo() async {
    final fileInfo =
        await defaultCacheManager.getFileFromCache(widget.videoUrl);

    if (fileInfo == null) {
      await defaultCacheManager.downloadFile(widget.videoUrl);
      setState(() {
        isCached = false;
      });
    } else {
      setState(() {
        videoFile = fileInfo.file;
        isCached = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getCachedVideo();
    videoPlayerController = isCached
        ? VideoPlayerController.file(videoFile!)
        : VideoPlayerController.network(widget.videoUrl);

    videoPlayerController.addListener(() => setState(() {}));
    videoPlayerController.setLooping(true);
    videoPlayerController.initialize().then((_) {
      videoPlayerController.play();
      videoPlayerController.setVolume(1);
    });

    // ..addListener(() => setState(() {}))
    // ..setLooping(true)
    // ..initialize().then((_) {
    //   videoPlayerController.play();
    //   videoPlayerController.setVolume(1);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController.value.isInitialized
        ? Container(
            alignment: Alignment.topCenter,
            child: buildVideo(),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget buildVideo() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => videoPlayerController.value.isPlaying
          ? videoPlayerController.pause()
          : videoPlayerController.play(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          buildFullScreen(
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            ),
          ),
          Positioned.fill(
            child: BasicOverlayWidget(controller: videoPlayerController),
          )
        ],
      ),
    );
  }

  Widget buildFullScreen({required Widget child}) {
    final size = videoPlayerController.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
