import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/chatList.dart';
import 'package:messanger_bpup/src/API/jsonParser.dart';
import 'package:messanger_bpup/src/localDatabaseMethods.dart';
import 'package:messanger_bpup/src/webSocketMethods.dart';
import 'package:shared_preferences/shared_preferences.dart';

late bool _isLoggedIn;

class LoginPassword extends StatelessWidget {
  const LoginPassword({super.key, required this.emailValue});

  final emailValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff354966),
      appBar: AppBar(
        // title: Text(
        //   "Password",
        //   style: TextStyle(color: Colors.white),
        // ),
        centerTitle: true,
        backgroundColor: Color(0xff354966),
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

  late String passwordValue;

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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),

                ),
                // child: Icon(Icons.check, color: Colors.white,),
                child: Text(
                  "Invia",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
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
    String localUserID = await JsonParser.getUserID(apiKey);

  if (apiKey != "false") {


    //DATABASE LOCALE
    LocalDatabaseMethods.databaseOpen();
    LocalDatabaseMethods.insertLocalUser(localUserID, apiKey);
    WebSocketMethods().openWebSocketConnection(localUserID, apiKey);
    WebSocketMethods().WebSocketSenderMessage('{"type":"init","apiKey":"$apiKey"}');
    await WebSocketMethods().WebSocketReceiver();


    //devo aspettare l'input di tutte le info di localuser
    // await LocalDatabaseMethods.stampaTuttiICani();


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
