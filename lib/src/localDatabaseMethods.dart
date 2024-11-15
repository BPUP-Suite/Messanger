import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseMethods {

  static Future<void> databaseOpen() async {
    final localDatabase = openDatabase(
      join(await getDatabasesPath(), 'localDatabase.db'),
      onCreate: (db, version) {
        db.execute(
          '''          
          CREATE TABLE localUser(
            user_id TEXT,
            apiKey TEXT PRIMARY KEY,  
            user_email TEXT, 
            handle TEXT, 
            name TEXT, 
            surname TEXT
          );
          ''',
        );

        db.execute(
          '''
          CREATE TABLE chats(
            chat_id TEXT PRIMARY KEY,
            group_channel_name TEXT NULL
          );
          '''
        );

        db.execute(
          '''
          CREATE TABLE users(
            user_id TEXT PRIMARY KEY,
            handle TEXT
          );
          '''
        );

        db.execute(
          '''
          CREATE TABLE messages (
            message_id TEXT PRIMARY KEY,
            chat_id TEXT REFERENCES chats(chat_id),
            sender TEXT,
            text TEXT,
            date_time DATETIME
          );
          '''
        );

        db.execute(
          '''
          CREATE TABLE chat_users(
            chat_id TEXT,
            user_id TEXT,
            PRIMARY KEY (chat_id, user_id),
            FOREIGN KEY (chat_id) REFERENCES chats(chat_id),
            FOREIGN KEY (user_id) REFERENCES users(user_id)
          );
          '''
        );
      },
      version: 1,
    );
  }


  static final localDatabase = databaseConnection();

  static Future<Database> databaseConnection() async {
    final localDatabase = openDatabase(
      join(await getDatabasesPath(), 'localDatabase.db'),
      version: 1,
    );
    return localDatabase;
  }





  static Future<void> stampaTuttiICani() async {
    final db = await localDatabase;

    // Esegui una query per selezionare tutti i cani
    final List<Map<String, dynamic>> maps = await db.query('messages');

    // Stampa i risultati direttamente dalle mappe
    maps.forEach((row) {
      print(
          '\nMessage Id: ${row['message_id']},'
          '\nChat id: ${row['chat_id']},'
          '\nText: ${row['text']},'
          '\nSender: ${row['sender']},'
          '\nDatetime: ${row['date_time']},'
      );
    });
  }



  static Future<void> insertLocalUser(user_id, apiKey) async {

    final db = await localDatabase;

    try {
      await db.insert(
        'localUser',
        {'user_id': user_id, 'apiKey': apiKey},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    catch (e) {
      print("Errore durante l'inserimento dell'utente: $e");
    }
  }



  static Future<void> updateLocalUser(user_email, handle, name, surname) async {

    final db = await localDatabase;

    await db.update(
      'localUser',
      where: "true=true",
      { 'user_email': user_email, 'handle': handle, 'name': name, 'surname': surname},
    );
  }



  static Future<void> insertChat(chat_id, group_channel_name) async {

    final db = await localDatabase;

    try {
      await db.insert(
        'chats',
        {'chat_id': chat_id, 'group_channel_name': group_channel_name},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    catch (e) {
      print("Errore durante l'inserimento della chat: $e");
    }
  }



  static Future<void> insertMessage(message_id, chat_id, text, sender, date) async {

    final db = await localDatabase;

    try {
      await db.insert(
        'messages',
        {'message_id': message_id, 'chat_id': chat_id, 'text': text, 'sender': sender, 'date_time': date},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    catch (e) {
      print("Errore durante l'inserimento della chat: $e");
    }
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