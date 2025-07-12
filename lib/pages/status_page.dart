import 'package:flutter/material.dart';
import 'package:whatsapp_clone/custom_ui/status_custom_card.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              onPressed: () {
                // Action for adding a new status
                print('Add new status');
              },

              backgroundColor: Colors.green,
              child: Icon(Icons.camera_alt_rounded, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 100.0,
            right: 28.0,
            child: FloatingActionButton(
              mini: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              onPressed: () {
                // Action to add new status
                print('Add new status');
              },
              backgroundColor: Colors.blue[100],
              child: Icon(Icons.edit, color: Colors.black),
            ),
          ),
        ],
      ),
      body: ListView(children: [StatusCustomCard()]),
    );
  }
}
