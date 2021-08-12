import 'package:flutter/material.dart';

//Shared Preference
import 'package:shared_preferences/shared_preferences.dart';

//Details
import 'package:song_scales/data/details.dart';

class RenameButton extends StatefulWidget {
  String title;
  final VoidCallback callback;
  final int num;

  RenameButton({this.title, this.num, this.callback});

  @override
  _RenameButtonState createState() => _RenameButtonState();
}

class _RenameButtonState extends State<RenameButton> {
  SharedPreferences _sharedPreferences;

  bool onPressed = false;
  TextEditingController renameController = new TextEditingController();
  bool rename = false;

  //Alert box
  Future<void> alertBox(BuildContext context){

    FlatButton okButton = FlatButton(
      onPressed: (){
        if(renameController.text.trim().isNotEmpty){
          rename = true;
          Navigator.pop(context);
        }
      },
      child: Text("Ok"),
    );

    FlatButton cancelButton = FlatButton(
      onPressed: (){
        Navigator.pop(context);
      },
      child: Text("Cancel"),
    );

    TextField text = TextField(
      controller: renameController,
      decoration: InputDecoration(
        hintText: 'Enter text',
      ),
    );

    AlertDialog alert = AlertDialog(
      title: Text('Rename File'),
      content: text,
      actions: [
        okButton,
        cancelButton
      ],
    );

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return alert;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
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
                          color: Colors.lightBlueAccent
                      )
                    ]
                ),
                child: Center(
                  child: Text(
                    '${widget.title}',
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 22.0
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
                    if(rename){
                      rename = false;
                      switch(widget.num){
                        case 1: Details.fv1 = renameController.text.trim();
                        await _sharedPreferences.setString('fv1', Details.fv1);
                        break;
                        case 2: Details.fv2 = renameController.text.trim();
                        await _sharedPreferences.setString('fv2', Details.fv2);
                        break;
                        case 3: Details.fv3 = renameController.text.trim();
                        await _sharedPreferences.setString('fv3', Details.fv3);
                        break;
                        case 4: Details.fv4 = renameController.text.trim();
                        await _sharedPreferences.setString('fv4', Details.fv4);
                        break;
                      }
                      widget.title = renameController.text;
                    }
                    renameController.clear();
                    setState(() { });
                  },
                  splashColor: Colors.grey,
                  child: Icon(Icons.edit),
                ),
              ),
            )
          ],
        )
    );
  }
}