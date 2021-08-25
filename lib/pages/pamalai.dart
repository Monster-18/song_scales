import 'package:flutter/material.dart';

//DB
import 'package:song_scales/data_base/db_pamalai.dart';

//Widget
import 'package:song_scales/widgets/song_page.dart';

class Pamalai extends StatefulWidget {
  @override
  _PamalaiState createState() => _PamalaiState();
}

class _PamalaiState extends State<Pamalai> {
  DBPamalai pamalai;

  @override
  void initState() {
    //Initialize DBPamalai
    pamalai = DBPamalai.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Song(
      db: pamalai,
      title: 'Hymns',
    );
  }
}
