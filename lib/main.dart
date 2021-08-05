import 'package:flutter/material.dart';

//Pages
import 'package:song_scales/home.dart';
import 'package:song_scales/pages/pamalai.dart';
import 'package:song_scales/pages/keerthanai.dart';
import 'package:song_scales/pages/fv1.dart';
import 'package:song_scales/pages/fv2.dart';

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
        '/keerthanai': (context) => Keerthanai(),
        '/fv1': (context) => Fv1(),
        '/fv2': (context) => Fv2(),
      },
    )
  );
}