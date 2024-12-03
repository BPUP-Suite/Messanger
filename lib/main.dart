import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/start/start.dart';
import 'package:messanger_bpup/src/localDatabaseMethods.dart';




void main() async{
  // WebSocketReceiver();

  runApp(MyApp());

  bool doesDBExists = await LocalDatabaseMethods.checkDatabaseExistence();
  print('Esistenza Database: ${doesDBExists.toString()}');

  if(doesDBExists == true) {
    // String localUserID = await LocalDatabaseMethods().fetchLocalUserID();
    // String localUserApiKey = await LocalDatabaseMethods().fetchLocalUserApiKey();
    // WebSocketMethods().openWebSocketConnection(localUserID, localUserApiKey);
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      //imposta un tema generale di tutte le pagine (spero) per i TEXTFIELD
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.blue,  // Colore dell'evidenziazione
          selectionHandleColor: Colors.blue, // Colore del cursore quando evidenzi
          cursorColor: Colors.blue,
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: Start(),
    );
  }
}

//se API KEY già esiste = utente logga in automatico
