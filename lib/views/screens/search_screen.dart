import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/controllers/search_controller.dart';
import 'package:tmdb_app/models/user.dart';
import 'package:tmdb_app/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: buttonColor,
            title: TextFormField(
              cursorColor: backgroundColor,
              style: TextStyle(color: backgroundColor),
              decoration: InputDecoration(
                filled: false,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: backgroundColor,
                ),
              ),
              onFieldSubmitted: (val) => searchController.searchUser(val),
            ),
          ),
          body: searchController.searchedUsers.isEmpty
              ? Center(
                  child: Text(
                    'Search for users',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  itemCount: searchController.searchedUsers.length,
                  itemBuilder: (context, i) {
                    User user = searchController.searchedUsers[i];
                    return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen(uid: user.uid))),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePhoto),
                        ),
                        title: Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  },
                ));
    });
  }
}
