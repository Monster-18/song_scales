import 'package:flutter/material.dart';

//DB
import 'package:song_scales/data_base/db_keerthanai.dart';

//Widget
import 'package:song_scales/widgets/song_page.dart';

class Keerthanai extends StatefulWidget {
  @override
  _KeerthanaiState createState() => _KeerthanaiState();
}

class _KeerthanaiState extends State<Keerthanai> {
  DBKeerthanai keerthanai;

  @override
  void initState() {
    //Initialize DBKeerthanai
    keerthanai = DBKeerthanai.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Song(db: keerthanai, title: 'Keerthanai',);
  }
}
