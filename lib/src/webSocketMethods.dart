import 'dart:collection';

import 'package:messanger_bpup/src/API/jsonParser.dart';
import 'package:messanger_bpup/src/localDatabaseMethods.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketMethods {

  late String localUserID;
  late String apiKey = "";
  final String webSocketAddress = 'wss://api.messanger.bpup.israiken.it/ws';



  static late WebSocketChannel webSocketChannel;

  // Funzione per aprire la connessione WebSocket
  //(al giorno 10/11/24 01:20 ancora da testare)
  void openWebSocketConnection(String _localUserID, String _apiKey) {
    localUserID = _localUserID;
    apiKey = _apiKey;
    webSocketChannel = WebSocketChannel.connect(
      Uri.parse('$webSocketAddress/$localUserID/$apiKey'),
    );
    
    // final WebSocketChannel web2 = await WebSocketChannel.connect(Uri.parse('wss://api.messanger.bpup.israiken.it/ws/$localUserID/$apiKey'));
    print("Connessione aperta (speriamo)");
  }


  //da cambiare stringa con json object come piace a zamuele
  Future<void> WebSocketSenderMessage(String message) async {
    await webSocketChannel.ready;
    webSocketChannel.sink.add(message);

  }




  //ricevo qualcosa dal websocket
  Future<String> WebSocketReceiver() async {
    await webSocketChannel.ready;

    webSocketChannel.stream.listen((data) async {
      // webSocketChannel.sink.add('{"init":$apiKey}');
      // _listNotifier.add(ChatMessage(message, "NonMatteo", DateTime.now()));
      HashMap hashData = JsonParser().convertJsonToDynamicStructure(data);
      String type = hashData["type"];

      switch(type) {
        case "init": {
          String init = hashData["init"];
          if(init == "True"){
            print(data);

            //INSERIMENTO LOCAL USER
            HashMap localUserMap = hashData["localUser"];
            String user_email = localUserMap["email"];
            String handle = localUserMap["handle"];
            String name = localUserMap["name"];
            String surname = localUserMap["surname"];

            print("NAMEEEEEEEEEEEEEEEEEEEEEEEEEEEE: $name");

            await LocalDatabaseMethods.updateLocalUser(user_email, handle, name, surname);
            await LocalDatabaseMethods.stampaTuttiICani();
          }
          if(init == "False"){

          }
          break;
        }



        default: {print("sei stronzo");}
      }
    }
    );
    return "return of web socket function";
  }
}