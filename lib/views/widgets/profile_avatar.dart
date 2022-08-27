import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String profilePhoto;
  ProfileAvatar({Key? key, required this.profilePhoto});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(
                  profilePhoto,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
