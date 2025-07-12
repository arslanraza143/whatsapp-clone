import 'package:flutter/material.dart';

class ContactBottonCustomCard extends StatelessWidget {
  const ContactBottonCustomCard({
    super.key,
    required this.icons,
    required this.name,
  });
  final IconData icons;
  final Text name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xFF25D366), // WhatsApp green color
        radius: 23.0,
        child: Icon(
          icons,
          color: Colors.white,
          size: 26,
        ), // Adjust the radius as needed
      ),
      title: name,
      
    );
  }
}
