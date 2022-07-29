import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tmdb_app/constants.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/views/screens/confirm_screen.dart';

class AddVideoScreen extends StatefulWidget {
  AddVideoScreen({Key? key}) : super(key: key);

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);

    if (video != null) {
      Get.to(ConfirmScreen(
        videoFile: File(video.path),
        videoPath: video.path,
      ));
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: Row(children: [
                    Icon(Icons.image),
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        'Galley',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ]),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.camera, context),
                  child: Row(children: [
                    Icon(Icons.camera),
                    Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ]),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(children: [
                    Icon(Icons.cancel),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptionsDialog(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
            ),
            child: Center(
                child: Text(
              'Add Video',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
