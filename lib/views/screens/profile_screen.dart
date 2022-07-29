import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/controllers/profile_controller.dart';
import 'package:tmdb_app/views/screens/favorites_screen.dart';
import 'package:tmdb_app/views/screens/my_videos_screen.dart';
import 'package:tmdb_app/views/screens/terms_and_conditions_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  ProfileScreen({Key? key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: backgroundColor,
              leading: widget.uid != authController.user.uid
                  ? null
                  : IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoritesScreen())),
                      icon: Icon(Icons.bookmark)),
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndConditionsScreen())),
                  icon: Icon(Icons.text_snippet_rounded),
                ),
              ],
              centerTitle: true,
              title: Text(
                controller.user['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: controller.user['profilePhoto'],
                                height: 100,
                                width: 100,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.user['following'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Following',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.user['followers'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Followers',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.user['likes'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Likes',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 140,
                          height: 47,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (widget.uid == authController.user.uid) {
                                authController.signOut();
                              } else {
                                controller.followUser();
                              }
                            },
                            child: Text(
                              widget.uid == authController.user.uid
                                  ? 'SIGN OUT '
                                  : controller.user['isFollowing']
                                      ? 'UNFOLLOW'
                                      : 'FOLLOW',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Video List
                        GridView.builder(
                          padding: EdgeInsets.all(8),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.user['videos'].length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, i) {
                            String thumbnail = (controller.user['videos'][i]
                                as dynamic)['thumbnail'];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyVideosScreen(
                                            data: (controller.user['videos']
                                                [i]))));
                              },
                              child: CachedNetworkImage(
                                imageUrl: thumbnail,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
