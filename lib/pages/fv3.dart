import 'package:flutter/material.dart';

//DB
import 'package:song_scales/data_base/db_fv3.dart';

//Details
import  'package:song_scales/data/details.dart';

//Widget
import 'package:song_scales/widgets/song_page.dart';

class Fv3 extends StatefulWidget {
  @override
  _Fv3State createState() => _Fv3State();
}

class _Fv3State extends State<Fv3> {
  DBFv3 fv3;

  @override
  void initState() {
    //Initialize DBFv3
    fv3 = DBFv3.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Song(db: fv3, title: Details.fv3,);
  }
}
