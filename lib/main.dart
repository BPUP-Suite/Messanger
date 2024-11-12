import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/start/start.dart';
import 'package:messanger_bpup/src/localDatabaseMethods.dart';



//controllo se db c'è, POI websocket





void main() async{
  // WebSocketReceiver();

  runApp(MyApp());

  bool doesDBExists = await LocalDatabaseMethods.checkDatabaseExistence();
  print('Esistenza Database: ${doesDBExists.toString()}');

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
