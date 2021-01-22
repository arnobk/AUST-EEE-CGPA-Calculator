import 'dart:io';

import 'package:CGPACalculator/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import './screens/homepage.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: primaryColor,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox<String>('courseResultBox');
  await Hive.openBox<String>('semesterResultBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AUST EEE CGPA Calculator',
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorLight: Colors.blue[100],
        accentColor: accentColor,
        canvasColor: primaryColor,
        fontFamily: 'Montserrat',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 64,
            fontWeight: FontWeight.w700,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: Color(0xff000000),
        primaryColorLight: Colors.blueGrey[900],
        canvasColor: Color(0xff000000),
        accentColor: accentColor,
        fontFamily: 'Montserrat',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 64,
            fontWeight: FontWeight.w700,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
