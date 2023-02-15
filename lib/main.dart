import 'package:find_duplicate/screens/home_screen.dart';
import 'package:find_duplicate/services/file_management.dart';
import 'package:find_duplicate/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FileManagement fileManagement = Get.put(FileManagement());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: primarySwatch),
      home: HomeScreen(),
    );
  }
}
