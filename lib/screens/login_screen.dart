import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/custom_ui/contact_botton_custom_card.dart';
import 'package:whatsapp_clone/models/chat_custom_card_model.dart';

import 'package:whatsapp_clone/pages/share_data.dart';
import 'package:whatsapp_clone/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatCustomCard sourcechat;
  List<ChatCustomCard> chatList = [
    ChatCustomCard(
      icon: 'assets/person.svg',
      name: 'Arslan Raza',
      isGroup: false,
      lastMessage: 'Hey, How are you?',
      time: '4:00',
      id: 1,
    ),
    // ChatCustomCard(
    //   icon: 'assets/groups.svg',
    //   name: 'Class Group',
    //   isGroup: true,
    //   lastMessage: 'Hey, This is a group message',
    //   time: '9:00',
    // ),
    ChatCustomCard(
      icon: 'assets/person.svg',
      name: 'Usman Raza',
      isGroup: false,
      lastMessage: 'Hey, This is me',
      time: '10:00',
      id: 2,
    ),
    // ChatCustomCard(
    //   icon: 'assets/groups.svg',
    //   name: 'Uskt Group',
    //   isGroup: true,
    //   lastMessage: 'Hey, This is a group message',
    //   time: '9:00',
    // ),
    // ChatCustomCard(
    //   icon: 'assets/groups.svg',
    //   name: 'BBH Group',
    //   isGroup: true,
    //   lastMessage: 'Hey, This is a group message',
    //   time: '9:00',
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              sourcechat = chatList.removeAt(index);
              Provider.of<ShareData>(
                context,
                listen: false,
              ).setSourceChat(sourcechat);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (builder) => HomeScreen(chatList: chatList),
                ),
              );
            },
            child: ContactBottonCustomCard(
              icons: Icons.person,
              name: Text(chatList[index].name!),
            ),
          );
        },
      ),
    );
  }
}
