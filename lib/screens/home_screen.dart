import 'package:whatsapp_clone/models/chat_custom_card_model.dart';
import 'package:whatsapp_clone/pages/calls_page.dart';
import 'package:whatsapp_clone/pages/camera_page.dart';
import 'package:whatsapp_clone/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/pages/status_page.dart';
//import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final List<ChatCustomCard> chatList;
  const HomeScreen({super.key, required this.chatList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);

    _tabController.addListener(() async {
      // This triggers on both tap and swipe
      if (_tabController.indexIsChanging) return;
      if (_tabController.index == 0) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CameraPage()),
        );
        if (mounted) {
          _tabController.index = 1; // Always return to chat tab after camera
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whatsapp'),
        //backgroundColor: Color(0xFF075E54),
        // foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 'new_group', child: Text('New Group')),
                PopupMenuItem(
                  value: 'new_community',
                  child: Text('New Community'),
                ),
                PopupMenuItem(
                  value: 'broadcase_list',
                  child: Text('Broadcast Lists'),
                ),
                PopupMenuItem(
                  value: 'linked_devices',
                  child: Text('Linked Devices'),
                ),
                PopupMenuItem(
                  value: 'starred_messages',
                  child: Text("Starred Messages"),
                ),
                PopupMenuItem(value: 'settings', child: Text('Settings')),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Container()),
          Center(child: ChatPage(chatList: widget.chatList)),
          Center(child: StatusPage()),
          Center(child: CallsPage()),
        ],
      ),
    );
  }
}
