import 'dart:async';

import 'package:flutter/material.dart';

//Model
import 'package:song_scales/model/scale_model.dart';

//Widget
import 'package:song_scales/widgets/update_data.dart';

class Cards extends StatefulWidget {
  ScaleModel scale;
  VoidCallback callback;

  dynamic db;

  Cards({this.db, this.scale, this.callback});

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  dynamic db;
  bool show = false;

  Timer timer = new Timer(Duration(seconds: 0), (){});

  @override
  void initState() {
    db = widget.db;
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  //Alert Box before deleting
  Future<void> deleteAlert(){
    FlatButton deleteButton = new FlatButton(
      onPressed: () async{
        show = false;
        await db.deleteData(widget.scale.id);
        Navigator.pop(context);
      },
      child: Text(
        'Delete',
        style: TextStyle(
            color: Colors.red
        ),
      ),
    );

    FlatButton cancelButton = new FlatButton(
        onPressed: (){
          show = false;
          Navigator.pop(context);
        },
        child: Text(
          'Cancel',
          style: TextStyle(
              color: Colors.blue
          ),
        )
    );

    AlertDialog alert = new AlertDialog(
      title: Text('Delete Data'),
      content: Container(
        child: Text('Are You sure You want to delete the song ${widget.scale.id}?'),
      ),
      actions: [
        deleteButton,
        cancelButton
      ],
    );

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return alert;
        }
    );
  }

  //Update Data
  Future<void> updateData(){
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return UpdateData(
            db: db,
            scale: widget.scale,
          );
        }
    );
  }

  //Heading
  Widget headText(String text){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  //Body
  Widget bodyText(String text, bool isScale){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            fontSize: (show)? 14: 16,
            color: (isScale)? Colors.deepPurple: Colors.black
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(widget.scale == null){
      return Container(
        height: 50,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(),
              Container(
                  width: 30,
                  child: headText('No.'),
              ),
              Container(
                  width: 70,
                  child: headText('Name'),
              ),
              Container(
                  width: 40,
                  child: headText('Scale'),
              ),
              Container(
                  width: 100,
                  child: headText('Comments'),
              ),
              Container(),
            ],
          ),
        ),
      );
    }


    return Container(
      constraints: BoxConstraints(
        minHeight: 60,
      ),
      child: GestureDetector(
        onLongPress: (){
          show = true;
          setState(() { });
          timer = new Timer(Duration(seconds: 10), (){
            show = false;
            setState(() { });
          });
        },
        child: Card(
          color: (show)? Colors.yellow: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(),
              Container(
                  width: 30,
                  child: bodyText('${widget.scale.id}', false),
              ),
              Container(
                  width: 70,
                  child: bodyText(widget.scale.name, false)
              ),
              Container(
                  width: 40,
                  child: bodyText(widget.scale.scale, true)
              ),
              Container(
                  width: 100,
                  child: bodyText(widget.scale.comments, false)
              ),
              show?
              Row(
                children: [
                  Container(
                    child: IconButton(
                      onPressed: ()async{
                        await updateData();
                        widget.callback();
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () async{
                        await deleteAlert();
                        widget.callback();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ):
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
