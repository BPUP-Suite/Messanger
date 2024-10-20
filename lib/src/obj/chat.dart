import 'package:messanger_bpup/src/obj/chatMessage.dart';

class Chat {
  late String chatID;
  late List<ChatMessage> messages;
  late List<String> usersHandle;
  late String? groupChannelName;

  Chat(this.chatID, this.messages, this.usersHandle, this.groupChannelName);
}