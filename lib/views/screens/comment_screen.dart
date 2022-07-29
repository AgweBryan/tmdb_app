import 'package:flutter/material.dart';
import 'package:tmdb_app/constants.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatefulWidget {
  final String id;
  CommentScreen({Key? key, required this.id});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(widget.id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: commentController.comments.length,
                    itemBuilder: (context, i) {
                      final comment = commentController.comments[i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: backgroundColor,
                          backgroundImage: NetworkImage(
                            comment.profilePhoto,
                          ),
                        ),
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.username,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: buttonColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                comment.comment,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]),
                        subtitle: Row(
                          children: [
                            Text(
                              tago.format(comment.datePublished.toDate()),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${comment.likes.length} likes',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                            onTap: () =>
                                commentController.likeComment(comment.id),
                            child: Column(
                              children: [
                                SizedBox(height: 3),
                                Icon(
                                  Icons.favorite,
                                  size: 25,
                                  color: comment.likes
                                          .contains(authController.user.uid)
                                      ? Colors.red
                                      : Colors.white,
                                ),
                                SizedBox(height: 3),
                                Text(
                                  '${comment.likes.length}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: buttonColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: buttonColor,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    commentController.postComment(_commentController.text);
                    setState(() {
                      _commentController.text = '';
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
