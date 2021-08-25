import 'package:flutter/material.dart';

//Details
import 'package:song_scales/data/details.dart';

//Widgets
import 'package:song_scales/widgets/button.dart';
import 'package:song_scales/widgets/rename_btn.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: Details.height
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    title: 'Hymns',
                    callback: (){
                      Navigator.pushNamed(context, '/pamalai');
                    },
                  ),
                  Button(
                    title: 'Lyrics',
                    callback: (){
                      Navigator.pushNamed(context, '/keerthanai');
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RenameButton(
                    title: Details.fv1,
                    num: 1,
                    callback: (){
                      Navigator.pushNamed(context, '/fv1');
                    },
                  ),
                  RenameButton(
                    title: Details.fv2,
                    num: 2,
                    callback: (){
                      Navigator.pushNamed(context, '/fv2');
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RenameButton(
                    title: Details.fv3,
                    num: 3,
                    callback: (){
                      Navigator.pushNamed(context, '/fv3');
                    },
                  ),
                  RenameButton(
                    title: Details.fv4,
                    num: 4,
                    callback: (){
                      Navigator.pushNamed(context, '/fv4');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

