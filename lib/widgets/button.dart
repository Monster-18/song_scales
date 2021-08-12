import  'package:flutter/material.dart';

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