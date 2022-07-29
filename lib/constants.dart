import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/controllers/auth_controller.dart';
import 'package:tmdb_app/views/screens/add_video_screen.dart';
import 'package:tmdb_app/views/screens/favorites_screen.dart';
import 'package:tmdb_app/views/screens/inbox_screen.dart';
import 'package:tmdb_app/views/screens/profile_screen.dart';
import 'package:tmdb_app/views/screens/search_screen.dart';
import 'package:tmdb_app/views/screens/video_screen.dart';

// Colors
const backgroundColor = Colors.black;
final buttonColor = Colors.cyan;
final borderColor = Colors.grey;

// FIREBASE
final firebaseAuth = FirebaseAuth.instance;
final firebaseStorage = FirebaseStorage.instance;
final firestore = FirebaseFirestore.instance;

// Controller
final authController = AuthController.instance;

// Pages
final List<Widget> pages = [
  VideoScreen(),
  SearchScreen(),
  AddVideoScreen(),
  FavoritesScreen(),
  ProfileScreen(uid: authController.user.uid),
];
