import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBConnection{
  static Database _database;

  static Future<Database> get database async{
    if(_database != null){
      return _database;
    }

    _database = await _initDatabase();
    return _database;

  }

  static _initDatabase() async{
    String path = join(await getDatabasesPath(), 'Scales.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute('CREATE TABLE pamalai(id number, name varchar2(50), scale varchar2(20), comments varchar2(60)');
        await db.execute('INSERT INTO pamalai VALUES(?, ?, ?, ?)', [1, 'Hi', 'C', 'Wow']);
        await db.execute('CREATE TABLE keerthanai(id number, name varchar2(50), scale varchar2(20), comments varchar2(60)');
        await db.execute('CREATE TABLE fv1(id number, name varchar2(50), scale varchar2(20), comments varchar2(60)');
        await db.execute('CREATE TABLE fv2(id number, name varchar2(50), scale varchar2(20), comments varchar2(60)');
        await db.execute('CREATE TABLE fv3(id number, name varchar2(50), scale varchar2(20), comments varchar2(60)');
        await db.execute('CREATE TABLE fv4(id number, name varchar2(50), scale varchar2(20), comments varchar2(60)');
      }
    );
  }
}