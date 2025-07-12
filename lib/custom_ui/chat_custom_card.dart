import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/models/chat_custom_card_model.dart';
import 'package:whatsapp_clone/pages/specific_chat_screen.dart'
    show SpecificChatScreen;
//import 'package:whatsapp_clone/pages/specific_chat_screen.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.chatCustomCard});
  final ChatCustomCard chatCustomCard;
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        ListTile(
          leading: InkWell(
            onTap: () {
              // Handle tap on the avatar
              print('Avatar tapped');
            },
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 20.0,
              child: SvgPicture.asset(
                chatCustomCard.isGroup!
                    ? 'assets/groups.svg'
                    : 'assets/person.svg', // Replace with your SVG asset path
                width: 25.0,
                height: 25.0,
                colorFilter: ColorFilter.mode(
                  Colors.white, // Change color to blue
                  BlendMode.srcIn,
                ),
              ), // Adjust the radius as needed
            ),
          ),
          title: Text(
            chatCustomCard.name!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SpecificChatScreen(chatCustomCard: chatCustomCard),
              ),
            );
          },
          subtitle: Row(
            children: [
              Icon(Icons.done_all, color: Colors.blue, size: 16.0),
              SizedBox(width: 4.0),
              Expanded(
                child: Text(
                  chatCustomCard.lastMessage!,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                chatCustomCard.time!,
                style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
              ),
              SizedBox(height: 4.0),
              CircleAvatar(
                radius: 9.0,
                backgroundColor: Colors.green,
                child: Text(
                  '1',
                  style: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
              ),
            ],
          ),
        ),
        // ListTile(
        //   leading: InkWell(
        //     onTap: () {
        //       // Handle tap on the avatar
        //       print('Avatar tapped');
        //     },
        //     child: SvgPicture.asset(
        //       'assets/groups.svg', // Replace with your SVG asset path
        //       width: 50.0,
        //       height: 40.0,
        //       colorFilter: ColorFilter.mode(
        //         Colors.blueGrey, // Change color to blue
        //         BlendMode.srcIn,
        //       ),
        //     ),
        //   ),
        //   title: Text(
        //     'Arslan Raza',
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        //   ),
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => SpecificChatScreen()),
        //     );
        //   },
        //   subtitle: Row(
        //     children: [
        //       Icon(Icons.done_all, color: Colors.blue, size: 16.0),
        //       SizedBox(width: 4.0),
        //       Expanded(
        //         child: Text(
        //           'Hello, how are you?',
        //           style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ),
        //     ],
        //   ),
        //   trailing: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         '10:30 AM',
        //         style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
        //       ),
        //       SizedBox(height: 4.0),
        //       CircleAvatar(
        //         radius: 9.0,
        //         backgroundColor: Colors.green,
        //         child: Text(
        //           '1',
        //           style: TextStyle(color: Colors.white, fontSize: 10.0),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(height: 1.0, color: Colors.grey[300]),
        ),
      ],
    );
  }
}
