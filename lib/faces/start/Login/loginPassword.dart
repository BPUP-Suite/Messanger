import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/chatList.dart';
import 'package:messanger_bpup/src/API/jsonParser.dart';
import 'package:messanger_bpup/src/obj/localDatabase.dart';
import 'package:messanger_bpup/src/obj/localDatabaseAccess.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late bool _isLoggedIn;

class LoginPassword extends StatelessWidget {
  const LoginPassword({super.key, required this.emailValue});

  final emailValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        title: Text(
          "Password",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff202c3e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        alignment: Alignment.center, // Center content horizontally
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            LoginPasswordForm(emailValue),
          ],
        ),
        // child: PhoneForm(),
      ),
    );
  }
}

class LoginPasswordForm extends StatelessWidget {
  late final String emailValue;

  LoginPasswordForm(String emailValue) {
    this.emailValue = emailValue;
  }

  final _formKey = GlobalKey<FormState>();

  late final String passwordValue;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 250,
        child: Column(
          children: <Widget>[
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Per favore inserisci la tua password';
                }
                passwordValue = value;
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Form valido!')),
                    // );

                    LoginAndNavigate(context, emailValue, passwordValue);
                  }
                },
                child: Text('Invia'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void LoginAndNavigate(
    BuildContext context, String emailValue, String passwordValue) async {
  String apiKey = await JsonParser.loginPasswordJson(emailValue, passwordValue);

  if (apiKey != "false") {
    //DA MODIFICARE, ATTENZIONE ERA SOLO PER TESTARE IN ATTESA DELLO STORAGE LOCALE \/\/\/\/\/\/\/\/

    // if(LocalDatabaseAccess.database.localUser.name.isEmpty) {
    //   if(apiKey.isNotEmpty) {
    //     LocalDatabaseAccess.database = await LocalDatabase.init(apiKey);
    //   }
    // }

    LocalDatabaseAccess.database = await LocalDatabase.init(apiKey);

    print("teoricamente il database si sta creando");
    //DATABASE LOCALE
    final localDatabase = openDatabase(
      join(await getDatabasesPath(), 'localDatabase.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE localUser(
            apiKey TEXT PRIMARY KEY, 
            user_id TEXT, 
            user_email TEXT, 
            handle TEXT, 
            name TEXT, 
            surname TEXT
          );
          
          CREATE TABLE users(
            user_id PRIMARY KEY TEXT;
            handle TEXT;
          );
          
          CREATE TABLE chat_users(
            chat_id TEXT,
            user_id TEXT,
            PRIMARY KEY (chat_id, user_id),
            FOREIGN KEY (chat_id) REFERENCES chats(chat_id),
            FOREIGN KEY (user_id) REFERENCES users(user_id)
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
          ''',
        );

      },
      version: 1,
    );

    Future<void> insertDog(name, age) async {
      // Get a reference to the database.
      final db = await localDatabase;

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'dogs',
        {'name': name, 'age': age},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    insertDog("NomeCane1", 10);
    insertDog("NomeCane2", 4);

    Future<void> stampaTuttiICani() async {
      final db = await localDatabase;

      // Esegui una query per selezionare tutti i cani
      final List<Map<String, dynamic>> maps = await db.query('dogs');

      // Stampa i risultati direttamente dalle mappe
      maps.forEach((row) {
        print('Id: ${row['id']}, Cane: ${row['name']}, Età: ${row['age']}');
      });
    }

    stampaTuttiICani();
    print("database dovrebbe esistere");

    print(apiKey);
    print(LocalDatabaseAccess.database.localUser.userID);

    //chiama i metodi per salvare un valore true/false se utente è loggato
    _loadLoggedIn();
    _saveLoggedIn(true);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatList(),
      ),
    );
  } else {
    print("Password errata");
  }
}

//carica preferenza se utente loggato oppure no
Future<void> _loadLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  print("funzione login load Loggato?: ");
  print(_isLoggedIn);
}

// Salva lo stato della preferenza nelle SharedPreferences
Future<void> _saveLoggedIn(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', value);
  print("funzione login save Loggato?: ");
  print(value);
}
