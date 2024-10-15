import 'package:flutter/material.dart';
import 'package:messanger_bpup/faces/start/start.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


//web socket
final webSocketChannel = WebSocketChannel.connect(
  Uri.parse(
      'wss://api.messanger.bpup.israiken.it/ws/1000000000000000000/gbitFE9c_ysdVzWoxb0BXVDOshqCv76ZSPGQzghvwnw9A6dQBrJ4kan2bw9eFn-yBpWtItevNLQQJafb7qyT1jBRHGQb7ek7PZvtU01nOehoWieFfrBQWWWLDMRwPxr3jyKfxKzyy-M1Ww5bc2t1CJJDQi86BCMkYkR7JU_TBqc8LGR3Jy9q3yGp3kQCUr6EXxcm4Xib7E8jIKJlDKnlSnsrLUxK26BMpaDvTPbEh0vBvTUvyuiIQA-oT6FxI_zYQNvCS8cjCFv41jg_Qg-Yos0WI6VoZfrjmAmjjwfeXXYB8VDimatU8hb1WvjAw-jMtPxOMjfOV8EPQIzwrdno9w'),
);

Future<String> WebSocketReceiver() async {
  await webSocketChannel.ready;

  webSocketChannel.stream.listen((message) {
    webSocketChannel.sink.add('received!');
    print(message);
  }
  );
  return "return function web socket";
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
