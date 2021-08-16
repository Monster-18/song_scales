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
        height: 60,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                      child: headText('No.'),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                      child: headText('Name'),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      child: headText('Scale'),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                      child: headText('Comments'),
                  ),
                ),
              ],
            ),
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
          setState(() {
            show = true;
          });
          timer = new Timer(Duration(seconds: 10), (){
            setState(() {
              show = false;
            });
          });
        },
        child: Card(
          color: (show)? Colors.yellow: Colors.white,
          child: Padding(
            padding: (show)? EdgeInsets.all(1.0): const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: (show)? 5: 0.0),
                      child: bodyText('${widget.scale.id}', false),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                      child: bodyText(widget.scale.name, false)
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      child: bodyText(widget.scale.scale, true)
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                      child: bodyText(widget.scale.comments, false)
                  ),
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
                Expanded(flex: 0, child: Container())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
