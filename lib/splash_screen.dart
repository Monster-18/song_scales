import 'dart:async';

import 'package:flutter/material.dart';

//Shared Preference
import 'package:shared_preferences/shared_preferences.dart';

//Details
import 'package:song_scales/data/details.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences preferences;

  Timer _timer, _start;
  bool start = false;

  @override
  void initState() {
    _getDataFromSharedPreference();

    _timer = new Timer(Duration(milliseconds: 500), (){
      setState(() {
        start = true;
      });
    });

    _start = new Timer(Duration(seconds: 3), (){
      Navigator.pushNamed(context, '/home');
    });

    super.initState();
  }

  _getDataFromSharedPreference() async{
    preferences = await SharedPreferences.getInstance();

    if(preferences.containsKey('fv1')){
      Details.fv1 = preferences.getString('fv1');
    }
    if(preferences.containsKey('fv2')){
      Details.fv2 = preferences.getString('fv2');
    }
    if(preferences.containsKey('fv3')){
      Details.fv3 = preferences.getString('fv3');
    }
    if(preferences.containsKey('fv4')){
      Details.fv4 = preferences.getString('fv4');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _start.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Details.height = MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;

    return Container(
      color: Colors.white,
      child: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 3),
          width: (start)? 300: 10,
          height: (start)? 300: 10,
          curve: Curves.easeIn,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
