import 'package:flutter/material.dart';

//Model
import 'package:song_scales/model/scale_model.dart';

//Details
import 'package:song_scales/data/details.dart';

class AddData extends StatefulWidget {
  dynamic db;

  AddData({this.db});

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  dynamic db;

  //List of Scales
  List<String> scaleList;
  String selectedScale = 'C';

  //TextEditingControllers
  TextEditingController songNoController = new TextEditingController();
  TextEditingController songNameController = new TextEditingController();
  TextEditingController songCommentController = new TextEditingController();

  //Clear all TextEditingControllers
  void clearAllTexts(){
    songNoController.clear();
    songNameController.clear();
    songCommentController.clear();
  }

  //Check whether any textfield is empty or not
  bool checkControllerIsNotEmpty(){
    return songNoController.text.trim() != '' && songNameController.text.trim() != '' && songCommentController.text.trim() != '';
  }

  @override
  void initState() {
    db = widget.db;
    scaleList = Details.scales;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlatButton addButton = new FlatButton(
        onPressed: () async{
          if(checkControllerIsNotEmpty()){
            ScaleModel scale = new ScaleModel();
            scale.id = int.parse(songNoController.text.trim());
            scale.name = songNameController.text.trim();
            scale.scale = selectedScale;
            scale.comments = songCommentController.text.trim();

            await db.insertData(scale);
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

    DropdownButton songScale = DropdownButton<String>(
      isExpanded: true,
      value: selectedScale,
      onChanged: (String val){
        setState(() {
          selectedScale = val;
        });
      },
      items: scaleList.map((String value){
        return new DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
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
        width: MediaQuery.of(context).size.width*0.75,  //3/4th
        height: MediaQuery.of(context).size.height*0.40,
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 10,),
                songNo,
                SizedBox(height: 10,),
                songName,
                SizedBox(height: 10,),
                Container(height: 50,child: songScale),
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

    return alert;
  }
}