import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestone_demo/FirestoreService.dart';
import 'package:flutter_firestone_demo/homePage.dart';
import 'package:flutter_firestone_demo/models/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firestone CRUD',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HomePage(),
    );
  }
}
