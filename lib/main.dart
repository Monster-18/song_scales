import 'package:flutter/material.dart';

//Pages
import 'package:song_scales/home.dart';
import 'package:song_scales/pages/pamalai.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Song Scales',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/pamalai': (context) => Pamalai(),
      },
    )
  );
}