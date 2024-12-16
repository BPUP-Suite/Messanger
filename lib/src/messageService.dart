import 'package:flutter/material.dart';

class MessageService {
  final _listeners = <void Function(Map<String, dynamic>)>[];

  void addListener(void Function(Map<String, dynamic>) listener) {
    _listeners.add(listener);
  }

  void removeListener(void Function(Map<String, dynamic>) listener) {
    _listeners.remove(listener);
  }

  void notifyListeners(Map<String, dynamic> message) {
    for (var listener in _listeners) {
      listener(message);
    }
  }
}

// Create a singleton instance of MessageService
final messageService = MessageService();