
import 'package:flutter/material.dart';
import 'package:flutter_dogapp/ui/bottom_bar.dart';

class DogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomBarWidget(),
    );
  }
}