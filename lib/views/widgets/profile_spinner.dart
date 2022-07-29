import 'package:flutter/material.dart';

class ProfileSpinner extends StatelessWidget {
  final String profilePhoto;
  ProfileSpinner({Key? key, required this.profilePhoto});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(11),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey,
                Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image(
              image: NetworkImage(profilePhoto),
              fit: BoxFit.cover,
            ),
          ),
        )
      ]),
    );
  }
}
