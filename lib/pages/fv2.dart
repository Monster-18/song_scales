import 'package:flutter/material.dart';

//DB
import 'package:song_scales/data_base/db_fv2.dart';

//Details
import  'package:song_scales/data/details.dart';

//Widget
import 'package:song_scales/widgets/song_page.dart';

class Fv2 extends StatefulWidget {
  @override
  _Fv2State createState() => _Fv2State();
}

class _Fv2State extends State<Fv2> {
  DBFv2 fv2;

  @override
  void initState() {
    //Initialize DBFv2
    fv2 = DBFv2.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Song(
      db: fv2,
      title: Details.fv2,
    );
  }
}
