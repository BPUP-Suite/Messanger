import 'package:messanger_bpup/src/obj/chat.dart';
import 'package:messanger_bpup/src/API/jsonParser.dart';
import 'package:messanger_bpup/src/obj/chatMessage.dart';
import 'package:messanger_bpup/src/obj/localUser.dart';
import 'package:messanger_bpup/main.dart';





class LocalDatabase {
  late final LocalUser localUser;
  late List<Chat> chats;

  LocalDatabase(this.localUser, this.chats);

  static Future<LocalDatabase> init(String apiKey) async {

    //mando apikey a Samuele
    webSocketChannel.sink.add('{"init":$apiKey}');

    String localUserID = await JsonParser.getUserID(apiKey);

    LocalUser localUser = LocalUser(apiKey, localUserID, "email", "mestesso", "mestesso", "mestesso");
    List<Chat> chats = [];

    // List<User> users1 = [];
    // User user1 = User("ciao13", "Ugello", "Magellano");
    // User user3 = User("ciao14", "Ciro", "immobile");
    // users1.add(user);
    // users1.add(user1);
    // users1.add(user3);
    // Chat chat1 = Chat("123", [], users1, "NomeGruppo");

    List<String> users2 = [];
    String user2 = "HandleTest1";
    users2.add(localUser.handle);
    users2.add(user2);
    List<ChatMessage> messages2 = [];
    ChatMessage msg21 = ChatMessage("lorem ipsum", "HandleTest1", DateTime.now(), "id_messaggio");
    ChatMessage msg22 = ChatMessage("lorem ipsum", "mestesso", DateTime.now(), "id_messaggio");
    messages2.add(msg21);
    messages2.add(msg22);
    Chat chat2 = Chat("124", messages2, users2, null);

    // chats.add(chat1);
    chats.add(chat2);

    return LocalDatabase(localUser, chats);
  }
}