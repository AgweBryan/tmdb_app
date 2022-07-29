import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/controllers/favorites_controller.dart';
import 'package:tmdb_app/controllers/video_controller.dart';
import 'package:tmdb_app/models/video.dart';
import 'package:tmdb_app/views/screens/comment_screen.dart';
import 'package:tmdb_app/views/screens/profile_screen.dart';
import 'package:tmdb_app/views/widgets/animation.dart';
import 'package:tmdb_app/views/widgets/profile_avatar.dart';
import 'package:tmdb_app/views/widgets/profile_spinner.dart';
import 'package:tmdb_app/views/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);

  final VideoController videoController = Get.put(VideoController());
  final FavoritesController favoritesController = FavoritesController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => PageView.builder(
            itemCount: videoController.videoList.length,
            controller: PageController(
              initialPage: 0,
              viewportFraction: 1,
            ),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, i) {
              final Video data = videoController.videoList[i];

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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileScreen(uid: data.uid))),
                                    child: ProfileAvatar(
                                        profilePhoto: data.profilePhoto),
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            videoController.likeVideo(data.id),
                                        child: Icon(
                                          Icons.favorite,
                                          size: 40,
                                          color: data.likes.contains(
                                                  authController.user.uid)
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Text(
                                        data.likes.length.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => CommentScreen(
                                              id: data.id,
                                            ),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.comment,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Text(
                                        data.commentCount.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            videoController.shareVideo(data),
                                        child: Icon(
                                          Icons.share,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Text(
                                        data.shareCount.length.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileScreen(uid: data.uid))),
                                    child: CircleAnimation(
                                      child: ProfileSpinner(
                                          profilePhoto: data.profilePhoto),
                                    ),
                                  ),
                                ],
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
                // SimpleDialogOption(
                //   onPressed: () {
                //     Get.snackbar('Downloading...', '');
                //     videoController.saveVideo(data);
                //     Navigator.pop(context);
                //   },
                //   child: Row(children: [
                //     Icon(Icons.save_alt),
                //     Padding(
                //       padding: EdgeInsets.all(7),
                //       child: Text(
                //         'Save video',
                //         style: TextStyle(
                //           fontSize: 20,
                //         ),
                //       ),
                //     )
                //   ]),
                // ),
                SimpleDialogOption(
                  onPressed: () =>
                      favoritesController.addVideoToFavorites(data),
                  child: Row(children: [
                    Icon(Icons.bookmark),
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        'Add to Favorites',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ]),
                ),
                SimpleDialogOption(
                  onPressed: () => videoController.reportVideo(data.id),
                  child: Row(children: [
                    Icon(
                      Icons.report_problem_rounded,
                      color: data.reports.contains(authController.user.uid)
                          ? Colors.red
                          : Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        'Report',
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
