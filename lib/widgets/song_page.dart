import 'dart:async';

import 'package:flutter/material.dart';

//Search Bar
import 'package:flutter_search_bar/flutter_search_bar.dart';

//Model
import 'package:song_scales/model/scale_model.dart';

//Details
import  'package:song_scales/data/details.dart';

//Widget
import 'package:song_scales/widgets/song_card.dart';
import 'package:song_scales/widgets/add_data.dart';

class Song extends StatefulWidget {
  //Database
  dynamic db;
  String title;

  Song({this.db, this.title});

  @override
  _SongState createState() => _SongState();
}

class _SongState extends State<Song> {
  SearchBar searchBar;
  dynamic db;

  String songStart;

  //AppBar
  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          searchBar.getSearchAction(context)
        ]
    );
  }

  @override
  void initState() {
    //Initializing db
    db = widget.db;
    //Initializing SearchBar
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: (value){
          print('Submitted $value');
        },
        onChanged: onChange,
        onCleared: emptySearch,
        onClosed: emptySearch
    );
    //Initial Search
    songStart = "";
    super.initState();
  }

  //Show all songs
  void emptySearch(){
    songStart = "";
    setState(() {});
  }

  //Show songs which starts with the given letters
  void onChange(String value){
    songStart = value.trim();
    setState(() { });
  }

  //Reloading List
  void reload(){
    setState(() { });
  }

  //Getting data from db
  Future<List<ScaleModel>> get rows async{
    List<ScaleModel> list= await db.queryAllRows(songStart);
    if(list.isEmpty){
      return [];
    }else{
      return list;
    }
  }

  //Body of data
  Widget listBody(List<ScaleModel> list){
    List<Cards> l = [];

    if(list.isEmpty){
      return Container(
        height: Details.height,
        child: Center(
          child: Text('No data'),
        ),
      );
    }

    l.add(
        Cards(db: db, scale: null, callback: reload,)
    );
    for(ScaleModel scale in list){
      l.add(
          Cards(db: db, scale: scale, callback: reload,)
      );
    }

    return Column(
      children: l,
    );

  }

  //AlertBox to add data
  Future<void> addData(BuildContext context){
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return AddData(
            db: db,
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: rows,
            builder: (context, snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Container(
                      height: Details.height,
                      child: Center(
                          child: CircularProgressIndicator()
                      )
                  );
                  break;
                case ConnectionState.done:
                  if(snapshot.hasData){
                    return listBody(snapshot.data);
                  }else if(snapshot.hasError){
                    return Container(
                        height: Details.height,
                        child: Text('Error')
                    );
                  }else{
                    return Container(
                      height: Details.height,
                      child: Center(
                        child: Text('No data'),
                      ),
                    );
                  }
              }
              return Text('No Data');//No need
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await addData(context);
          setState(() { });
        },
        child: Icon(
            Icons.add
        ),
      ),
    );
  }
}

