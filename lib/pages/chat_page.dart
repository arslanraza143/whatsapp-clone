import 'package:flutter/material.dart';
import 'package:whatsapp_clone/custom_ui/chat_custom_card.dart';
import 'package:whatsapp_clone/models/chat_custom_card_model.dart';
import 'package:whatsapp_clone/screens/select_contact.dart';

class ChatPage extends StatefulWidget {
  final List<ChatCustomCard> chatList;
  const ChatPage({super.key, required this.chatList});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF075E54), // Primary color for FAB
        foregroundColor: Colors.white, // Icon color in FAB
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const SelectContact(); // Navigate to SelectContact page
              },
            ),
          );
        },

        child: const Icon(Icons.chat), // Primary color for FAB
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return CustomCard(chatCustomCard: widget.chatList[index]);
        },
        itemCount: widget.chatList.length,
      ),
    );
  }
}
