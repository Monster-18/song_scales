import 'package:flutter/material.dart';

//Shared Preference
import 'package:shared_preferences/shared_preferences.dart';

//Details
import 'package:song_scales/data/details.dart';

import 'package:song_scales/widgets/rename_alert.dart';

class RenameButton extends StatefulWidget {
  String title;
  final VoidCallback callback;
  final int num;

  static bool rename = false;
  static TextEditingController renameController = new TextEditingController();

  RenameButton({this.title, this.num, this.callback});

  @override
  _RenameButtonState createState() => _RenameButtonState();
}

class _RenameButtonState extends State<RenameButton> {
  SharedPreferences _sharedPreferences;

  bool onPressed = false;

  //Alert box
  Future<void> alertBox(BuildContext context){

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return RenameAlert();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTapDown: (details){
            setState(() {
              onPressed = true;
            });
          },
          onTapUp: (details){
            setState(() {
              onPressed = false;
            });
          },
          onTap: widget.callback,

          child: Container(
            width: (MediaQuery.of(context).size.width > 700)? 300: 150,
            height: (MediaQuery.of(context).size.width > 700)? 300: 150,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                // border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
                boxShadow: [
                  //Background Shadow
                  BoxShadow(
                    offset: (onPressed)? Offset(0.0, 0.0): Offset(3.0, 3.0),
                    color: Colors.blueGrey,
                  ),
                  BoxShadow(
                      offset: (onPressed)? Offset(3.0, 3.0): Offset(0.0, 0.0),
                      color: Colors.white
                  )
                ]
            ),
            child: Center(
              child: Text(
                '${widget.title}',
                style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: (MediaQuery.of(context).size.width > 700)? 44: 22.0
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 2,
          bottom: 2,
          width: 40,
          height: 40,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () async{
                await alertBox(context);
                _sharedPreferences = await SharedPreferences.getInstance();
                if(RenameButton.rename){
                  RenameButton.rename = false;
                  switch(widget.num){
                    case 1: Details.fv1 = RenameButton.renameController.text.trim();
                    await _sharedPreferences.setString('fv1', Details.fv1);
                    break;
                    case 2: Details.fv2 = RenameButton.renameController.text.trim();
                    await _sharedPreferences.setString('fv2', Details.fv2);
                    break;
                    case 3: Details.fv3 = RenameButton.renameController.text.trim();
                    await _sharedPreferences.setString('fv3', Details.fv3);
                    break;
                    case 4: Details.fv4 = RenameButton.renameController.text.trim();
                    await _sharedPreferences.setString('fv4', Details.fv4);
                    break;
                  }
                  setState(() {
                    widget.title = RenameButton.renameController.text;
                  });
                }
                RenameButton.renameController.clear();
              },
              splashColor: Colors.grey,
              child: Icon(Icons.edit),
            ),
          ),
        )
      ],
    );
  }
}