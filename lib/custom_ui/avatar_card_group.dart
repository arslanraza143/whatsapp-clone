import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/models/chat_custom_card_model.dart';

class AvatarCardGroup extends StatelessWidget {
  const AvatarCardGroup({super.key, required this.contacts});
  final ChatCustomCard contacts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
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
              Positioned(
                right: 0,
                top: 20,
                child: CircleAvatar(
                  radius: 12,

                  child: Icon(Icons.cancel, color: Colors.red, size: 25.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Text(contacts.name.toString()),
        ],
      ),
    );
  }
}
