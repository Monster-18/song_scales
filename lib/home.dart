import 'package:flutter/material.dart';

//Details
import 'package:song_scales/data/details.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                      callback: (){},
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
                      callback: (){},
                    ),
                    RenameButton(
                      title: Details.fv2,
                      num: 2,
                      callback: (){},
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
                      callback: (){},
                    ),
                    RenameButton(
                      title: Details.fv4,
                      num: 4,
                      callback: (){},
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


class Button extends StatefulWidget {
  final String title;
  final VoidCallback callback;

  Button({this.title, this.callback});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {

  bool onPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
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
    );
  }
}


class RenameButton extends StatefulWidget {
  String title;
  final VoidCallback callback;
  final int num;

  RenameButton({this.title, this.num, this.callback});

  @override
  _RenameButtonState createState() => _RenameButtonState();
}

class _RenameButtonState extends State<RenameButton> {

  bool onPressed = false;
  TextEditingController renameController = new TextEditingController();
  bool rename = false;

  //Alert box
  Future<void> alertBox(BuildContext context){

    FlatButton okButton = FlatButton(
      onPressed: (){
        if(renameController.text.isNotEmpty){
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
                  if(rename){
                    rename = false;
                    switch(widget.num){
                      case 1: Details.fv1 = renameController.text;
                              break;
                      case 2: Details.fv2 = renameController.text;
                              break;
                      case 3: Details.fv3 = renameController.text;
                              break;
                      case 4: Details.fv4 = renameController.text;
                              break;
                    }
                    widget.title = renameController.text;
                    renameController.text = null;
                    setState(() { });
                  }
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
