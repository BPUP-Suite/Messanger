import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/start/start.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


//web socket
final webSocketChannel = WebSocketChannel.connect(
  Uri.parse(
      'wss://api.messanger.bpup.israiken.it/ws/1000000000000000007/l_3lWqxkXrjAPKICwRgHxZtSKWkdKUulZ_M0egIuZQyIPu4njv2P9voBTXfVV9VCUaab0mTM2ci6aiTJOJca7OTWm_FvI0OhtCLaW4TTj_K3mYvp43p4YdzUsm_ZwuADyHLDewZ4zTxyIoaiv87rLflwh552zeENTpHZnUtyIJPkSi0zZNnM-ulLR0HJgKv8TowQGrrJMH4XEeSI8m_u2V8L6eLZAa_woqNXy9F14KTCPM3iyAUfnN-kj8QWFIJzZTQoINBk91i5qtC0PgNe79eRkYqjq7502L2wEbpUWM9Eppa0S7DaOsHtX9oiBdgRT5PDY2GAMcaTAIf_4AjOtg'),
);

Future<String> WebSocketReceiver() async {
  await webSocketChannel.ready;

  webSocketChannel.stream.listen((message) {
    webSocketChannel.sink.add('Matteo: connessione effettuata');
    // _listNotifier.add(ChatMessage(message, "NonMatteo", DateTime.now()));
  }
  );
  return "return of web socket function";
}





void main() {
  WebSocketReceiver();
  runApp(MyApp());
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
