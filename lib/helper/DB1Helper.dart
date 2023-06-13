import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DB1Helper{
  static  Future<Database> database() async {
final dbPath=await sql.getDatabasesPath();
return sql.openDatabase(path.join(dbPath,"users1.db"),
onCreate:(db,version){
 return db.execute("CREATE TABLE users2(id INTEGER,name TEXT, contact INTEGER)",);
},version: 1);
  }
  static Future<void> insert(String table, Map<String,Object> data) async{
  final db=await DB1Helper.database();
  db.insert(table, data);
  }
   static Future<List<Map<String ,Object?>>> getData(String table) async{
   final db = await DB1Helper.database();
    return db.query(table);
  
   }
    static Future <void> deleteData(String table,var id)async{
      final db=await DB1Helper.database();

       db.delete(table,where:"id=?",whereArgs: [id]);
    }

    static Future<void> updateData(String table,var id, Map<String,Object>data) async{
      final db=await DB1Helper.database();

      db.update(table, data,where: "id=?", whereArgs: [id]);
    }
    
  }
  
