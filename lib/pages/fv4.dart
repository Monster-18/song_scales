import 'package:flutter/material.dart';

//DB
import 'package:song_scales/data_base/db_fv4.dart';

//Details
import  'package:song_scales/data/details.dart';

//Widget
import 'package:song_scales/widgets/song_page.dart';

class Fv4 extends StatefulWidget {
  @override
  _Fv4State createState() => _Fv4State();
}

class _Fv4State extends State<Fv4> {
  DBFv4 fv4;

  @override
  void initState() {
    //Initialize DBFv1
    fv4 = DBFv4.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Song(db: fv4, title: Details.fv4,);
  }
}
