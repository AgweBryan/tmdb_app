import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/controllers/favorites_controller.dart';
import 'package:tmdb_app/controllers/video_controller.dart';
import 'package:tmdb_app/models/video.dart';
import 'package:tmdb_app/views/widgets/video_player_item.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  final VideoController videoController = VideoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        () => favoritesController.favVideos.isEmpty
            ? Center(child: Text('No videos added here yet'))
            : PageView.builder(
                itemCount: favoritesController.favVideos.length,
                controller: PageController(
                  initialPage: 0,
                  viewportFraction: 1,
                ),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, i) {
                  final Video data = favoritesController.favVideos[i];

                  return Stack(
                    children: [
                      GestureDetector(
                        onLongPress: () => showOptionsDialog(context, data),
                        child: VideoPlayerItem(
                          videoUrl: data.videoUrl,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          data.username,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data.caption,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.music_note,
                                                size: 19, color: Colors.white),
                                            Text(
                                              ' original sound - ${data.songName}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }),
      ),
    );
  }

  showOptionsDialog(BuildContext context, Video data) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () =>
                      favoritesController.removeFromFavorites(data),
                  child: Row(children: [
                    Icon(Icons.remove_circle),
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        'Remove from Favorites',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ]),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(context),
                  child: Row(children: [
                    Icon(
                      Icons.cancel,
                    ),
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            ));
  }
}
