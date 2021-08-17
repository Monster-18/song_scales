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

  //Error Handling
  bool error_number = false, error_name = false, error_comment = false;
  String error_txt = null;

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

  void resetBooleanValues(){
    error_number = false;
    error_name = false;
    error_comment = false;
  }

  //Check whether any textfield is empty or not
  bool checkControllerIsNotEmpty(){
    bool res = true;
    if(songNoController.text.trim() == ''){
      res = false;
      error_number = true;
    }
    if(songNameController.text.trim() == ''){
      res = false;
      error_name = true;
    }
    if(songCommentController.text.trim() == ''){
      res = false;
      error_comment = true;
    }

    return res;
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
          resetBooleanValues();
          if(checkControllerIsNotEmpty()){
            ScaleModel scale = new ScaleModel();
            scale.id = int.parse(songNoController.text.trim());
            scale.name = songNameController.text.trim();
            scale.scale = selectedScale;
            scale.comments = songCommentController.text.trim();

            bool flag = await db.insertData(scale);

            if(flag){
              clearAllTexts();
              Navigator.pop(context);
            }else{
              error_number = true;
              error_txt = "Song Number already exist";
            }
          }else{
            error_txt = "Should not be empty";
            print('Enter all Fields');
          }
          setState(() { });
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
        errorText: (error_number)? error_txt: null,
      ),
    );

    TextField songName = TextField(
      controller: songNameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
        errorText: (error_name)? error_txt: null,
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
        errorText: (error_comment)? error_txt: null,
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