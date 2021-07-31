import 'dart:async';

import 'package:flutter/material.dart';

//DB
import 'package:song_scales/data_base/db_pamalai.dart';

//Model
import 'package:song_scales/model/scale_model.dart';

class Pamalai extends StatefulWidget {
  @override
  _PamalaiState createState() => _PamalaiState();
}

class _PamalaiState extends State<Pamalai> {
  DBPamalai pamalai;

  //TextEditingControllers
  TextEditingController songNoController = new TextEditingController();
  TextEditingController songNameController = new TextEditingController();
  TextEditingController songScaleController = new TextEditingController();
  TextEditingController songCommentController = new TextEditingController();

  @override
  void initState() {
    pamalai = DBPamalai.instance;
    super.initState();
  }

  //Reloading List
  void reload(){
    setState(() { });
  }

  //Getting data from db
  Future<List<ScaleModel>> get rows async{
    List<ScaleModel> list= await pamalai.queryAllRows();
    if(list.isEmpty){
      return [];
    }else{
      return list;
    }
  }

  //Body of data
  Widget listBody(List<ScaleModel> list){
    List<Cards> l = [];

    if(list.isEmpty){
      return Container(
        child: Center(
          child: Text('No data'),
        ),
      );
    }

    l.add(
        // Container(
        //   height: 50,
        //   child: Card(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         Container(
        //             width: 30,
        //             child: Text(
        //               'No.',
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold
        //               ),
        //             )
        //         ),
        //         Container(
        //             width: 70,
        //             child: Text(
        //               'Name',
        //               style: TextStyle(
        //                   fontWeight: FontWeight.bold
        //               ),
        //             )
        //         ),
        //         Container(
        //             width: 40,
        //             child: Text(
        //               'Scale',
        //               style: TextStyle(
        //                   fontWeight: FontWeight.bold
        //               ),
        //             )
        //         ),
        //         Container(
        //             width: 100,
        //             child: Text(
        //               'Comments',
        //               style: TextStyle(
        //                   fontWeight: FontWeight.bold
        //               ),
        //             )
        //         ),
        //       ],
        //     ),
        //   ),
        // )
      Cards(scale: null, callback: reload,)
    );
    for(ScaleModel scale in list){
      l.add(
        // Container(
        //   constraints: BoxConstraints(
        //     minHeight: 50,
        //   ),
        //   child: GestureDetector(
        //     onLongPress: (){
        //       //TODO
        //     },
        //     child: Card(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           Container(
        //             width: 30,
        //               child: Text('${scale.id}')
        //           ),
        //           Container(
        //             width: 70,
        //               child: Text(scale.name)
        //           ),
        //           Container(
        //             width: 40,
        //               child: Text(scale.scale)
        //           ),
        //           Container(
        //             width: 100,
        //               child: Text(scale.comments)
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // )
        Cards(scale: scale, callback: reload,)
      );
    }

    return Column(
      children: l,
    );

  }

  //Clear all TextEditingControllers
  void clearAllTexts(){
    songNoController.clear();
    songNameController.clear();
    songScaleController.clear();
    songCommentController.clear();
  }

  //Check whether any textfield is empty or not
  bool checkControllerIsNotEmpty(){
    return songNoController.text.trim() != '' && songNameController.text.trim() != '' && songScaleController.text.trim() != '' && songCommentController.text.trim() != '';
  }

  //AlertBox to add data
  Future<void> addData(BuildContext context){
    FlatButton addButton = new FlatButton(
        onPressed: () async{
          if(checkControllerIsNotEmpty()){
            ScaleModel scale = new ScaleModel();
            scale.id = int.parse(songNoController.text.trim());
            scale.name = songNameController.text.trim();
            scale.scale = songScaleController.text.trim();
            scale.comments = songCommentController.text.trim();

            await pamalai.insertData(scale);
            clearAllTexts();
            Navigator.pop(context);
          }else{
            print('Enter all Fields');
          }
        },
        child: Text('Add')
    );

    FlatButton cancelButton = new FlatButton(
        onPressed: (){
          clearAllTexts();
          Navigator.pop(context);
        },
        child: Text('Cancel')
    );

    TextField songNo = TextField(
      controller: songNoController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Number',
      ),
    );

    TextField songName = TextField(
      controller: songNameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
      ),
    );

    TextField songScale = TextField(
      controller: songScaleController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Scale',
      ),
    );


    TextField songComment = TextField(
      controller: songCommentController,
      maxLines: 3,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Comment',
      ),
    );

    AlertDialog alert = new AlertDialog(
      title: Text('Add Song'),
      content: Container(
        width: 300,
        height: 330,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              songNo,
              SizedBox(height: 10,),
              songName,
              SizedBox(height: 10,),
              songScale,
              SizedBox(height: 10,),
              songComment,
            ],
          )
        ),
      ),
      actions: [
        addButton,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pamalai'),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: rows,
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.done:
                if(snapshot.hasData){
                  return listBody(snapshot.data);
                }else if(snapshot.hasError){
                  return Text('Error');
                }else{
                  return Text('No Data');
                }
            }
            return Text('No Data');//No need
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await addData(context);
          setState(() { });
        },
        child: Icon(
          Icons.add
        ),
      ),
    );
  }
}


class Cards extends StatefulWidget {
  ScaleModel scale;
  VoidCallback callback;

  Cards({this.scale, this.callback});

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  DBPamalai pamalai;
  bool show = false;

  //TextEditingControllers
  TextEditingController songNoController = new TextEditingController();
  TextEditingController songNameController = new TextEditingController();
  TextEditingController songScaleController = new TextEditingController();
  TextEditingController songCommentController = new TextEditingController();

  Timer timer = new Timer(Duration(seconds: 0), (){});

  @override
  void initState() {
    pamalai = DBPamalai.instance;
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  //Check whether any textfield is empty or not
  bool checkControllerIsNotEmpty(){
    return songNameController.text.trim() != '' && songScaleController.text.trim() != '' && songCommentController.text.trim() != '';
  }

  //Alert Box before deleting
  Future<void> deleteAlert(){
    FlatButton deleteButton = new FlatButton(
      onPressed: () async{
        show = false;
        await pamalai.deleteData(widget.scale.id);
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
    FlatButton updateButton = new FlatButton(
        onPressed: () async{
          if(checkControllerIsNotEmpty()){
            ScaleModel scale = new ScaleModel();
            scale.id = widget.scale.id;
            scale.name = songNameController.text.trim();
            scale.scale = songScaleController.text.trim();
            scale.comments = songCommentController.text.trim();

            await pamalai.updateData(scale);
            Navigator.pop(context);
          }else{
            print('Enter all Fields');
          }
        },
        child: Text('Update')
    );

    FlatButton cancelButton = new FlatButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Text('Cancel')
    );

    songNoController.text = widget.scale.id.toString();
    TextField songNo = TextField(
      enabled: false,
      controller: songNoController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Number',
      ),
    );

    songNameController.text = widget.scale.name;
    TextField songName = TextField(
      controller: songNameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
      ),
    );

    songScaleController.text = widget.scale.scale;
    TextField songScale = TextField(
      controller: songScaleController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Scale',
      ),
    );

    songCommentController.text = widget.scale.comments;
    TextField songComment = TextField(
      controller: songCommentController,
      maxLines: 3,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Comment',
      ),
    );

    AlertDialog alert = new AlertDialog(
      title: Text('Update Song'),
      content: Container(
        width: 300,
        height: 330,
        child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                songNo,
                SizedBox(height: 10,),
                songName,
                SizedBox(height: 10,),
                songScale,
                SizedBox(height: 10,),
                songComment,
              ],
            )
        ),
      ),
      actions: [
        updateButton,
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

  @override
  Widget build(BuildContext context) {
    if(widget.scale == null){
      return Container(
        height: 50,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 30,
                  child: Text(
                    'No.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Container(
                  width: 70,
                  child: Text(
                    'Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Container(
                  width: 40,
                  child: Text(
                    'Scale',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Container(
                  width: 100,
                  child: Text(
                    'Comments',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
            ],
          ),
        ),
      );
    }


    return Container(
      constraints: BoxConstraints(
        minHeight: 50,
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
              Container(
                  width: 30,
                  child: Text('${widget.scale.id}')
              ),
              Container(
                  width: 70,
                  child: Text(widget.scale.name)
              ),
              Container(
                  width: 40,
                  child: Text(widget.scale.scale)
              ),
              Container(
                  width: 100,
                  child: Text(widget.scale.comments)
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
                  Container(width: 0,)
            ],
          ),
        ),
      ),
    );
  }
}
