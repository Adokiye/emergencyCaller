import 'package:flutter/material.dart';
import 'package:emergencyCaller/helpers/color.dart';
import 'package:emergencyCaller/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency Caller',
      theme: ThemeData(
        fontFamily: 'Gilroy',
        primarySwatch: colorCustom,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: const Color(0xff1281dd),
      ),
      home: MyHomePage(title: 'Emergency Caller'),
    );
  }
}

