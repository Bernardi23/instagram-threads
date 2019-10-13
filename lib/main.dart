import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_threads/pages/homepage/homepage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.white,
    systemNavigationBarColor: Colors.white,
  ));
  runApp(Threads());
}

class Threads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Threads',
      theme: threadsTheme(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

ThemeData threadsTheme() {
  return ThemeData(
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Proxima Nova",
    buttonColor: Color(0xFFF1F1F1),
    // Notification Purple
    focusColor: Color(0xFF8444F9),
    // Active Green
    accentColor: Color(0xFF5EE747),
    textTheme: TextTheme(
      body1: TextStyle(fontSize: 18),
      subhead: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      subtitle: TextStyle(
        fontSize: 13.0,
        color: Color(0xFF919191),
      ),
    ),
  );
}
