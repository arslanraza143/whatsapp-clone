import 'package:flutter/material.dart';

class CallCustomCard extends StatefulWidget {
  const CallCustomCard({super.key});

  @override
  State<CallCustomCard> createState() => _CallCustomCardState();
}

class _CallCustomCardState extends State<CallCustomCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF075E54),
                  child: Icon(Icons.attachment_outlined, color: Colors.white),
                ),
                title: Text(
                  'Create Call Link',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    // Primary color for the text
                  ),
                ),
                subtitle: Text(
                  'Share a link for your WhatsApp call',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://th.bing.com/th/id/OIP.n2mVTG3V3FAmoz90kGzcPAHaH8?w=174&h=187&c=7&r=0&o=5&pid=1.7', // Replace with a valid image URL
                ),
              ),
              title: Text(
                'Arslan Raza',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              subtitle: Text(
                'Missed call at 10:30 AM',
                style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
              ),
              trailing: Icon(Icons.call, color: Colors.green, size: 20.0),
            );
          },
        ),
      ],
    );
  }
}
