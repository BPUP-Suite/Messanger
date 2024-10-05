class ChatMessage {
  late String text;
  late String sender;
  late String receiver;

  ChatMessage(this.text, this.sender, this.receiver);


  @override
  String toString() {
    return 'ChatMessage{text: $text, sender: $sender, receiver: $receiver}';
  }

  String get getText => text;
  String get getSender => sender;
  String get getReceiver => receiver;
}