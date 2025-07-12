import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/chat_custom_card_model.dart';

class ShareData extends ChangeNotifier {
  String? _imagePath;
  String? _message;
  
  String? get imagePath => _imagePath;
  String? get message => _message;
  ChatCustomCard? _sourceChat;
  ChatCustomCard? get sourceChat => _sourceChat;

  void setImagePath(String path, String message) {
    _imagePath = path;
    _message = message;
    notifyListeners();
  }

  void clearImagePath() {
    _imagePath = null;
    notifyListeners();
  }

  void setSourceChat(ChatCustomCard chat) {
    _sourceChat = chat;
    notifyListeners();
  }

  void clearShourceChat() {
    _sourceChat = null;
    notifyListeners();
  }
}
