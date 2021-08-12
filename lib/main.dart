import 'package:flutter/material.dart';

//Splash Screen
import 'package:song_scales/splash_screen.dart';

//Pages
import 'package:song_scales/home.dart';
import 'package:song_scales/pages/pamalai.dart';
import 'package:song_scales/pages/keerthanai.dart';
import 'package:song_scales/pages/fv1.dart';
import 'package:song_scales/pages/fv2.dart';
import 'package:song_scales/pages/fv3.dart';
import 'package:song_scales/pages/fv4.dart';


void main() {
  runApp(
    MaterialApp(
      title: 'Song Scales',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/pamalai': (context) => Pamalai(),
        '/keerthanai': (context) => Keerthanai(),
        '/fv1': (context) => Fv1(),
        '/fv2': (context) => Fv2(),
        '/fv3': (context) => Fv3(),
        '/fv4': (context) => Fv4(),
      },
    )
  );
}