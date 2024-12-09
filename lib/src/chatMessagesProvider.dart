import 'dart:async';
import 'package:flutter/material.dart';

// Provider dei messaggi nello StreamBuilder
class ChatMessagesProvider extends ChangeNotifier {




  final _messagesController = StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get messagesStream => _messagesController.stream;

  List<Map<String, dynamic>> _messages = List<Map<String, dynamic>>.from([]); // Explicitly create a new mutable list

  List<Map<String, dynamic>> get messages => _messages;

  void set messages(List<Map<String, dynamic>> newMessages) {
    _messages = List<Map<String, dynamic>>.from(newMessages); // Ensure we're working with a copy
    _messagesController.add(_messages);
    notifyListeners();
  }

  void addMessage(Map<String, dynamic> message) {
    _messages = List.from(_messages)..add(message); // Create a new list with the message added
    _messagesController.add(_messages); // Add the updated list to the stream
    notifyListeners();
  }
}