import 'dart:async';
import 'package:flutter/material.dart';
import 'messageService.dart';

class ChatMessagesProvider extends ChangeNotifier {
  final _messagesController = StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get messagesStream => _messagesController.stream;

  List<Map<String, dynamic>> _messages = [];

  List<Map<String, dynamic>> get messages => _messages;

  set messages(List<Map<String, dynamic>> newMessages) {
    _messages = List<Map<String, dynamic>>.from(newMessages);
    _messagesController.add(_messages);
    notifyListeners();
  }

  ChatMessagesProvider() {
    // Subscribe to the message service when the provider is created
    messageService.addListener(_onMessageReceived);
  }

  void _onMessageReceived(Map<String, dynamic> message) {
    _messages = List.from(_messages)..add(message);
    _messagesController.add(_messages);
    notifyListeners();
  }

  @override
  void dispose() {
    // Unsubscribe from the message service when the provider is disposed
    messageService.removeListener(_onMessageReceived);
    super.dispose();
  }

// Remove the direct `addMessage` method, as messages will now be added via the service
// Instead, messages will be added through the service notification
}