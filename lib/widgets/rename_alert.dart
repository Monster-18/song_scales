import 'package:flutter/material.dart';

import 'package:song_scales/widgets/rename_btn.dart';

class RenameAlert extends StatefulWidget {
  @override
  _RenameAlertState createState() => _RenameAlertState();
}

class _RenameAlertState extends State<RenameAlert> {
  //Error
  bool error = false;

  @override
  Widget build(BuildContext context) {
    FlatButton okButton = FlatButton(
      onPressed: (){
        error = false;
        if(RenameButton.renameController.text.trim().isNotEmpty){
          RenameButton.rename = true;
          Navigator.pop(context);
        }else{
          setState(() {
            error = true;
          });
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
      controller: RenameButton.renameController,
      decoration: InputDecoration(
        hintText: 'Enter text',
        errorText: (error)? "Should not be empty": null,
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

    return alert;
  }
}
