import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import '../models/user.dart'; //import model class
import 'dart:io';
import 'dart:async';

class UserHelper {
  Future<Database> init() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path, "user.db"); //create path to database

    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("""
          CREATE TABLE Users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT)
        """);

        final existingUser = await db.query(
          "Users",
          where: "username = ?",
          whereArgs: ["user"],
        );

        if (existingUser.isEmpty) {
          // Insert the default user when the database is created
          await db.insert("Users", {
            'username': 'user',
            'password': 'user',
          });
        }
      },
    );

    return db;
  }

  Future<bool> signIn(String username, String password) async {
    final db = await init();
    final existingUser = await db.query(
      "Users",
      where: "username = ? AND password = ?",
      whereArgs: [username, password],
    );

    if (existingUser.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<UserModel>> fetchUsers() async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db
        .query("Users"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return UserModel(
        username: maps[i]['username'] as String,
        password: maps[i]['password'] as String,
      );
    });
  }

  Future<int> updatePassword(String newPassword) async {
    final db = await init();
    final existingUser = await db.query(
      "Users",
      where: "username = ?",
      whereArgs: ["user"],
    );

    if (existingUser.isNotEmpty) {
      // Update the password for the default user
      final updatedRows = await db.update(
        "Users",
        {'password': newPassword},
        where: "username = ?",
        whereArgs: ["user"],
      );

      return updatedRows;
    } else {
      await init();
      // No user currently
      return -1;
    }
  }
}
