import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/models/chat_custom_card_model.dart';

class ContactCustomCard extends StatelessWidget {
  const ContactCustomCard({super.key, required this.contacts});

  final ChatCustomCard contacts;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        radius: 23.0,
        child: SvgPicture.asset(
          'assets/person.svg', // Replace with your SVG asset path
          width: 25.0,
          height: 25.0,
          colorFilter: ColorFilter.mode(
            Colors.white, // Change color to white
            BlendMode.srcIn,
          ),
        ), // Adjust the radius as needed
      ),
      title: Text(
        contacts.name ?? 'Unknown',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
      subtitle: Text(
        contacts.status ?? 'No status',
        style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
      ),
      
    );
  }
}
