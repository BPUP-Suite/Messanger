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
          '''
        );

        db.execute(
            '''
          CREATE TABLE chats(
            chat_id TEXT PRIMARY KEY,
            group_channel_name TEXT
          );
          '''
        );

        db.execute(
            '''
          CREATE TABLE users(
            handle TEXT PRIMARY KEY
          );
          '''
        );

        db.execute(
            '''
          CREATE TABLE messages (
            message_id TEXT,
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
            handle TEXT,
            PRIMARY KEY (chat_id, handle),
            FOREIGN KEY (chat_id) REFERENCES chats(chat_id),
            FOREIGN KEY (handle) REFERENCES users(handle)
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



  Future<String> fetchLocalUserID() async {
    final db = await localDatabase;

    final result = await db.query(
      'localUser',
      columns: ['user_id'],
      limit: 1,
    );

    if (result.isNotEmpty) {
      final Map<String, dynamic> user = result.first;
      final String userId = user['user_id'];
      return userId;
    } else {
      // Handle the case where no user ID is found
      return 'User ID not found'; // Or any other appropriate default value
    }
  }



  Future<String> fetchLocalUserApiKey() async {
    final db = await localDatabase;

    final result = await db.query(
      'localUser',
      columns: ['apiKey'],
      limit: 1,
    );

    if (result.isNotEmpty) {
      final Map<String, dynamic> user = result.first;
      final String apiKey = user['apiKey'];
      return apiKey;
    } else {
      // Handle the case where no user ID is found
      return 'apiKey not found'; // Or any other appropriate default value
    }
  }



  //fetch localuser name + surname
  Future<String> fetchLocalUserNameAndSurname() async {
    final db = await localDatabase;

    final result = await db.query(
      'localUser',
      columns: ['name', 'surname'],
    );

    if (result.isNotEmpty) {
      final Map<String, dynamic> user = result.first;
      final String name = user['name'];
      final String surname = user['surname'];
      return '$name $surname';
    } else {
      return 'name or/and surname not found';
    }
  }



  //fetch email localuser
  Future<String> fetchLocalUserEmail() async {
    final db = await localDatabase;



    final result = await db.query(
      'localUser',
      columns: ['user_email'],
    );

    if (result.isNotEmpty) {
      final Map<String, dynamic> user = result.first;
      final String user_email = user['user_email'];
      return user_email;
    } else {
      return 'email not found';
    }
  }



  Future<String> fetchLocalUserhandle() async {
    final db = await localDatabase;



    final result = await db.query(
      'localUser',
      columns: ['handle'],
    );

    if (result.isNotEmpty) {
      final Map<String, dynamic> user = result.first;
      final String handle = user['handle'];
      return handle;
    } else {
      return 'handle not found';
    }
  }



  //prende le chat dal DB per inserirle nella ChatList
  Future<List<Map<String, dynamic>>> fetchChats() async {
    final db = await localDatabase;

    return await db.query('chats');
  }



  //estrae uno user se il group_channel_name è null, quindi lo mette come nome della chat
  Future<List<Map<String, dynamic>>> fetchUser(chat_id) async {
    final db = await localDatabase;

    return await db.query(
        'chat_users',
        columns: ['handle'],
        where: 'chat_id = ?',
        whereArgs: ['$chat_id']
    );
  }



  Future<List<Map<String, dynamic>>> fetchLastMessage(chat_id) async {
    final db = await localDatabase;

    return await db.query(
        'messages',
        orderBy: 'message_id DESC',
        limit: 1,
        where: 'chat_id = ?',
        whereArgs: ['$chat_id']
    );
  }



  Future<List<Map<String, dynamic>>> fetchAllChatMessages(chat_id) async {
    final db = await localDatabase;

    return await db.query(
        'messages',
        where: 'chat_id = ?',
        whereArgs: ['$chat_id']
    );
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



  static Future<void> insertMessage(String? message_id, String chat_id, String text, String sender, String? date) async {
    final db = await localDatabase;

    try {
      await db.insert(
        'messages',
        {
          'message_id': message_id,
          'chat_id': chat_id,
          'text': text,
          'sender': sender,
          'date_time': date,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Errore durante l'inserimento del messaggio: $e");
    }
  }



  static Future<void> insertUsers(handle) async {

    final db = await localDatabase;

    try {
      await db.insert(
        'users',
        {'handle': handle},

        //Se trova un handle uguale lo ignora e non fa nulla
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    catch (e) {
      print("Errore durante l'inserimento dello user: $e");
    }
  }



  static Future<void> insertChatAndUsers(chat_id, handle) async {

    final db = await localDatabase;

    try {
      await db.insert(
        'chat_users',
        {'chat_id': chat_id, 'handle': handle},

        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    catch (e) {
      print("Errore durante l'inserimento nella tabella di mezzo chat_users: $e");
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