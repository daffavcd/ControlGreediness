import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import '../models/transaction.dart'; //import model class
import 'dart:io';
import 'dart:async';

class TransactionHelper {
  Future<Database> init() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path =
        join(directory.path, "transaction.db"); //create path to database

    return await openDatabase(
        //open the database or create a database if there isn't any
        path,
        version: 1, onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE Transactions(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT,
          amount TEXT,
          description TEXT,
          type TEXT)""");
    });
  }

  Future<int> addItem(TransactionModel item) async {
    //returns number of items inserted as an integer

    final db = await init(); //open database

    return db.insert(
      "Transactions", item.toMap(), //toMap() function from MemoModel
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db.query(
        "Transactions"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return TransactionModel(
        date: maps[i]['date'] as String,
        amount: maps[i]['amount'] as String,
        description: maps[i]['description'] as String,
        type: maps[i]['type'] as String,
      );
    });
  }

  Future<int> updateTransaction(int id, TransactionModel item) async {
    // returns the number of rows updated

    final db = await init();

    int result = await db
        .update("Transactions", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }
}
