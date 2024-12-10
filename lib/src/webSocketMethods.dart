import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:messanger_bpup/src/API/jsonParser.dart';
import 'package:messanger_bpup/src/localDatabaseMethods.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'chatMessagesProvider.dart';
import 'package:provider/provider.dart';


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

    print("Connessione aperta");
  }

  Future<void> WebSocketSenderMessage(String message) async {
    await webSocketChannel.ready;
    webSocketChannel.sink.add(message);
    print("Messaggio inviato alla websocket: $message");
  }

  Future<String> WebSocketReceiver() async {
    await webSocketChannel.ready;

    await webSocketChannel.stream.listen((data) async {
      HashMap hashData = JsonParser().convertJsonToDynamicStructure(data);
      String type = hashData["type"];

      switch(type) {
        case "init": {
          String init = hashData["init"];
          if(init == "True"){
            print(data);

            HashMap localUserMap = hashData["localUser"];
            String user_email = localUserMap["email"];
            String handle = localUserMap["handle"];
            String name = localUserMap["name"];
            String surname = localUserMap["surname"];
            await LocalDatabaseMethods.updateLocalUser(user_email, handle, name, surname);

            List<dynamic> chats = hashData["chats"];
            for (var chat in chats) {
              HashMap<String, dynamic> chatMap = HashMap<String, dynamic>.from(chat);

              if(chatMap["name"] == null) {
                chatMap["name"] = "";
              }

              LocalDatabaseMethods.insertChat(chatMap["chat_id"], chatMap["name"]);

              List<dynamic> users = chatMap["users"];
              for(var user in users) {
                HashMap<String, dynamic> userMap = HashMap<String, dynamic>.from(user);

                LocalDatabaseMethods.insertUsers(userMap["handle"]);
                LocalDatabaseMethods.insertChatAndUsers(chatMap["chat_id"], userMap["handle"]);
              }

              List<dynamic> messages = chatMap["messages"];
              for(var message in messages) {
                HashMap<String, dynamic> messageMap = HashMap<String, dynamic>.from(message);

                LocalDatabaseMethods.insertMessage(messageMap["message_id"], messageMap["chat_id"], messageMap["text"], messageMap["sender"].toString(), messageMap["date"], "");
              }
            }
          }
          if(init == "False"){
            print("server error during init");
          }
          break;
        }

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

        case "receive_message": {
          String message_id = hashData["message_id"];
          String chat_id = hashData["chat_id"];
          String text = hashData["text"];
          String sender = hashData["sender"];
          String date = hashData["date"];
          String hash = "";
          LocalDatabaseMethods.insertMessage(message_id, chat_id, text, sender, date, hash);
          print("Nuovo messaggio ricevuto da $sender");
          break;
        }

        default: {print("sei stronzo");}
      }
    });
    return "return of web socket function";
  }
}
