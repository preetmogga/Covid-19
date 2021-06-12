import 'package:flutter/material.dart';
import 'ui/ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

