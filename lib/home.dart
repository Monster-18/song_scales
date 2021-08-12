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
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Details.height,
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(
                      title: 'Pamalai',
                      callback: (){
                        Navigator.pushNamed(context, '/pamalai');
                      },
                    ),
                    Button(
                      title: 'Keerthanai',
                      callback: (){
                        Navigator.pushNamed(context, '/keerthanai');
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30,),
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
                SizedBox(height: 30,),
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
      ),
    );
  }
}

