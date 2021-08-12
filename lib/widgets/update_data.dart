import 'package:flutter/material.dart';

//Model
import 'package:song_scales/model/scale_model.dart';

//Details
import 'package:song_scales/data/details.dart';

class UpdateData extends StatefulWidget {
  dynamic db;
  ScaleModel scale;

  UpdateData({this.db, this.scale});

  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  dynamic db;

  //List of Scales
  List<String> scaleList = ['C', 'D', 'E', 'C#'];
  String selectedScale;

  //TextEditingControllers
  TextEditingController songNoController = new TextEditingController();
  TextEditingController songNameController = new TextEditingController();
  TextEditingController songCommentController = new TextEditingController();

  //Check whether any textfield is empty or not
  bool checkControllerIsNotEmpty(){
    return songNameController.text.trim() != '' && songCommentController.text.trim() != '';
  }

  @override
  void initState() {
    db = widget.db;
    scaleList = Details.scales;

    selectedScale = widget.scale.scale;

    songNoController.text = widget.scale.id.toString();
    songNameController.text = widget.scale.name;
    songCommentController.text = widget.scale.comments;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlatButton updateButton = new FlatButton(
        onPressed: () async{
          if(checkControllerIsNotEmpty()){
            ScaleModel scale = new ScaleModel();
            scale.id = widget.scale.id;
            scale.name = songNameController.text.trim();
            scale.scale = selectedScale;
            scale.comments = songCommentController.text.trim();

            await db.updateData(scale);
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

    TextField songNo = TextField(
      enabled: false,
      controller: songNoController,
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

    return alert;
  }
}