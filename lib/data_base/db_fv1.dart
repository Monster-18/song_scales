import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import 'package:song_scales/model/scale_model.dart';


class DBFv1{
  //Constructor
  DBFv1._privateConstructor();
  static final DBFv1 instance = DBFv1._privateConstructor();

  static Database _database;
  Future<Database> get database async{
    if(_database != null){
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  //Initialize a db
  _initDatabase() async{
    String path = join(await getDatabasesPath(), 'Fv1.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version){
          db.execute(
              'CREATE TABLE Fv1(id number, name varchar2(50), scale varchar2(20), comments varchar2(60))'
          );
        }
    );
  }

  //Insert a data
  Future<int> insertData(ScaleModel scale) async{
    Database db = await instance.database;

    await db.execute(
        'INSERT INTO Fv1 VALUES(?, ?, ?, ?)',
        [scale.id, scale.name, scale.scale, scale.comments]
    );

  }

  //Update a data
  Future<int> updateData(ScaleModel scale) async{
    Database db = await instance.database;

    await db.execute(
        'UPDATE Fv1 SET name = ?, scale = ?, comments = ? WHERE id = ?',
        [scale.name, scale.scale, scale.comments, scale.id]
    );
  }

  //Delete a data
  Future<int> deleteData(int id) async{
    Database db = await instance.database;

    await db.execute(
        'DELETE FROM Fv1 where id = ?',
        [id]
    );
  }

  //Retrive all data which starts with start
  Future<List<ScaleModel>> queryAllRows(String start) async{
    Database db = await instance.database;

    List<Map<String, dynamic>> list = await db.query(
        'Fv1',
        where: 'name like ? or comments like ?',
        whereArgs: ["%"+start+"%", "%"+start+"%"],
        orderBy: 'id'
    );

    List<ScaleModel> l = [];

    for(Map<String, dynamic> map in list){
      l.add(ScaleModel.fromMap(map));
    }

    return l;
  }
}