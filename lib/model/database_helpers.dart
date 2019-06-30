// singleton class to manage the database
import 'dart:io';
import 'package:flutter_gridview_app/model/Item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String tableTeniko = 'teniko';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDescription = 'description';
final String columnDateajout = 'dateajout';
final String columnImage = 'image';

class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "teniko.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute(''' DROP TABLE IF EXISTS $tableTeniko ''');
    await db.execute('''
              CREATE TABLE  IF NOT EXISTS $tableTeniko (
                $columnId INTEGER PRIMARY KEY,
                $columnTitle TEXT NOT NULL,
                $columnDescription TEXT NOT NULL,
                $columnDateajout TEXT NOT NULL,
                $columnImage TEXT NOT NULL
              )
              ''');
  }

  // Database helper methods:
  Future<int> insert(Photo teniko) async {
    Database db = await database;
    int id = await db.insert(tableTeniko, teniko.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
Future<List<Photo>> photos() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('$tableTeniko');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Photo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        dateajout: maps[i]['dateajout'],
        image: maps[i]['image']
      );
    });
  }

  Future<Photo> queryTeniko(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableTeniko,
        columns: [
          columnId,
          columnTitle,
          columnDescription,
          columnDateajout,
          columnImage
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Photo.fromMap(maps.first);
    }
    return null;
  }
}
