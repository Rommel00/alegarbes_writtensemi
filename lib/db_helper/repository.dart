import 'package:basic_todo_app/db_helper/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository
{
  late DatabaseConnection _databaseConnection;
  Repository(){
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }

  }
  // Insert_ToDo
  insertTodo(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }
  //Read all record
  readTodo(table) async {
    var connection = await database;
    return await connection?.query(table);
  }
  //Update_todo
  updateTodo(table, data) async {
    var connection = await database;
    return await connection?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }
  //Delete_todo
  deleteTodo(table, todoId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$todoId");
  }



}