import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseMethods {

  static Future<void> databaseOpen() async {
    final localDatabase = openDatabase(
      join(await getDatabasesPath(), 'localDatabase.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE localUser(
            user_id TEXT,
            apiKey TEXT PRIMARY KEY,  
            user_email TEXT, 
            handle TEXT, 
            name TEXT, 
            surname TEXT
          );
          
          CREATE TABLE users(
            user_id TEXT PRIMARY KEY;
            handle TEXT;
          );
          
          CREATE TABLE chats(
            chat_id TEXT PRIMARY KEY,
            group_channel_name TEXT,
          );
          
          CREATE TABLE messages (
            message_id TEXT PRIMARY KEY,
            chat_id TEXT REFERENCES chats(chat_id),
            sender TEXT,
            text TEXT,
            date_time DATETIME
          );
          
          CREATE TABLE chat_users(
              chat_id TEXT,
            user_id TEXT,
            PRIMARY KEY (chat_id, user_id),
            FOREIGN KEY (chat_id) REFERENCES chats(chat_id),
            FOREIGN KEY (user_id) REFERENCES users(user_id)
          );
          ''',
        );

      },
      version: 1,
    );
  }




  static Future<Database> databaseConnection() async {
    final localDatabase = openDatabase(
      join(await getDatabasesPath(), 'localDatabase.db'),
      version: 1,
    );
    return localDatabase;
  }

  static final localDatabase = databaseConnection();



  static Future<void> stampaTuttiICani() async {
    final db = await localDatabase;

    // Esegui una query per selezionare tutti i cani
    final List<Map<String, dynamic>> maps = await db.query('localUser');

    // Stampa i risultati direttamente dalle mappe
    maps.forEach((row) {
      print('\nId: ${row['user_id']}, \nAPI Key: ${row['apiKey']}, \nEmail: ${row['user_email']}, \nHandle: ${row['handle']}, \nName: ${row['name']}, \nSurname: ${row['surname']}');
    });
  }



  static Future<void> insertLocalUser(user_id, apiKey) async {

    final db = await localDatabase;

    await db.insert(
      'localUser',
      {'user_id': user_id, 'apiKey': apiKey},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }



  static Future<void> updateLocalUser(user_email, handle, name, surname) async {

    final db = await localDatabase;

    await db.update(
      'localUser',
      where: "true=true",
      { 'user_email': user_email, 'handle': handle, 'name': name, 'surname': surname},
    );
  }



  //check database esiste
  static Future<bool> checkDatabaseExistence() async {
    bool dbExists = await databaseFactory.databaseExists('localDatabase.db');
    print(dbExists.toString());
    return dbExists;
  }



  // static Future<void> init() async {
  //
  //   final db = await localDatabase;
  //
  //   await
  //
  // }
}