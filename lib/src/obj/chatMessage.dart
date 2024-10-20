class ChatMessage {
  late String text;
  late String sender;
  late DateTime dateTime;
  late String messageID;
  // late List<MessageRead> messageRead;

  ChatMessage(this.text, this.sender, this.dateTime, this.messageID);


  @override
  String toString() {
    return 'ChatMessage{text: $text, sender: $sender, datetime: $dateTime}';
  }

  String get getText => text;
  String get getSender => sender;
  DateTime get getDateTime => dateTime;
}