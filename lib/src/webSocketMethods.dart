import 'dart:collection';
import 'package:messanger_bpup/src/API/jsonParser.dart';
import 'package:messanger_bpup/src/localDatabaseMethods.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketMethods {

  late String localUserID;
  late String apiKey = "";
  final String webSocketAddress = 'wss://api.messanger.bpup.israiken.it/ws';



  static late WebSocketChannel webSocketChannel;



  openWebSocketConnection(String _localUserID, String _apiKey) {
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
    print("Messaggio inviato alla websocket: $message");
  }



  //ricevo qualcosa dal websocket
  Future<String> WebSocketReceiver() async {
    await webSocketChannel.ready;

    await webSocketChannel.stream.listen((data) async {
      HashMap hashData = JsonParser().convertJsonToDynamicStructure(data);
      String type = hashData["type"];

      switch(type) {
        //INIT --> quello che ricevo quando faccio il login
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
            await LocalDatabaseMethods.updateLocalUser(user_email, handle, name, surname);



            //INSERIMENTO CHATS
            List<dynamic> chats = hashData["chats"];
            for (var chat in chats) {
              HashMap<String, dynamic> chatMap = HashMap<String, dynamic>.from(chat);

              if(chatMap["name"] == null) {
                chatMap["name"] = "";
              }

              LocalDatabaseMethods.insertChat(chatMap["chat_id"], chatMap["name"]);

              //INSERIMENTO USERS
              List<dynamic> users = chatMap["users"];
              for(var user in users) {
                HashMap<String, dynamic> userMap = HashMap<String, dynamic>.from(user);

                print("User: ${userMap["handle"]}");
                LocalDatabaseMethods.insertUsers(userMap["handle"]);
                LocalDatabaseMethods.insertChatAndUsers(chatMap["chat_id"], userMap["handle"]);
              }



              //INSERIMENTO MESSAGES
              List<dynamic> messages = chatMap["messages"];
              for(var message in messages) {
                HashMap<String, dynamic> messageMap = HashMap<String, dynamic>.from(message);

                print("Messaggio: ${messageMap["message_id"]}");
                LocalDatabaseMethods.insertMessage(messageMap["message_id"], messageMap["chat_id"], messageMap["text"], messageMap["sender"], messageMap["date"]);
              }
            }
          }
          if(init == "False"){
            print("server error during init");
          }
          break;
        }

        //SEND_MESSAGE --> quello che ricevo quando mando un messaggio
        case "send_message": {
          String send_message = hashData["send_message"];
          if(send_message == "True") {
            print("Messaggio tornato indietro: true");
            String hash = hashData["hash"];
            print(hash);
          }
          if(send_message == "False") {
            print("Messaggio tornato indietro: false");

          }

          break;
        }



        //RECEIVE_MESSAGE --> ricevo dall'India un messaggio
        case "receive_message": {
          String message_id = hashData["message_id"];
          String chat_id = hashData["chat_id"];
          String text = hashData["text"];
          String sender = hashData["sender"];
          String date = hashData["date"];
          LocalDatabaseMethods.insertMessage(message_id, chat_id, text, sender, date);
          print("Nuovo messaggio ricevuto da $sender!");
          break;
        }


        default: {print("sei stronzo");}
      }
    }
    );
    return "return of web socket function";
  }
}