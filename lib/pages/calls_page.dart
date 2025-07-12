import 'package:flutter/material.dart';
import 'package:whatsapp_clone/custom_ui/call_custom_card.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView(children: [CallCustomCard()]));
  }
}
