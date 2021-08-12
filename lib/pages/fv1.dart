import 'package:flutter/material.dart';

//DB
import 'package:song_scales/data_base/db_fv1.dart';

//Details
import  'package:song_scales/data/details.dart';

//Widget
import 'package:song_scales/widgets/song_page.dart';

class Fv1 extends StatefulWidget {
  @override
  _Fv1State createState() => _Fv1State();
}

class _Fv1State extends State<Fv1> {
  DBFv1 fv1;

  @override
  void initState() {
    //Initialize DBFv1
    fv1 = DBFv1.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Song(db: fv1, title: Details.fv1,);
  }
}
