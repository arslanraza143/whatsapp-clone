import 'package:flutter/material.dart';
import 'package:whatsapp_clone/custom_ui/contact_botton_custom_card.dart';
import 'package:whatsapp_clone/custom_ui/contact_custom_card.dart';
import 'package:whatsapp_clone/models/chat_custom_card_model.dart';
import 'package:whatsapp_clone/screens/create_group.dart';
import 'package:whatsapp_clone/screens/create_new_contact.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatCustomCard> contacts = [
    ChatCustomCard(
      icon: 'assets/person.svg',
      name: 'Arslan Raza',
      status: 'At your service',
    ),
    ChatCustomCard(icon: 'assets/person.svg', name: 'Ali Khan', status: 'Busy'),
    ChatCustomCard(
      icon: 'assets/person.svg',
      name: 'John Doe',
      status: 'Available',
    ),
    ChatCustomCard(
      icon: 'assets/person.svg',
      name: 'Jane Smith',
      status: 'Busy',
    ),
    ChatCustomCard(
      icon: 'assets/person.svg',
      name: 'Emily Johnson',
      status: 'At your service',
    ),
    ChatCustomCard(
      icon: 'assets/person.svg',
      name: 'Michael Brown',
      status: 'Available',
    ),
    // Add more contacts as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Contact',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '200 contacts',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white70,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            tooltip: 'Search',
            onPressed: () {
              // Handle search action
              print('Search pressed');
            },
          ),
          PopupMenuButton(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'invite_a_friend',
                  child: Text('Invite a Friend'),
                ),
                PopupMenuItem(value: 'contact_info', child: Text('Contacts')),
                PopupMenuItem(value: 'Refresh', child: Text('Refresh')),
                PopupMenuItem(value: 'help', child: Text('Help')),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateGroup()),
                );

                print('New group tapped');
              },
              child: ContactBottonCustomCard(
                icons: Icons.group,
                name: Text(
                  'New group',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          if (index == 1) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const CreateNewContact(),
                  ),
                );

                print('New contact tapped');
              },
              child: ContactBottonCustomCard(
                icons: Icons.person_add,
                name: Text(
                  'New contact',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return ContactCustomCard(
            contacts: contacts[index - 2],
          ); // Subtract 2 to account for the first two items
        },
        itemCount:
            contacts.length +
            2, // Add 2 for the "New group" and "New contact" items
        padding: const EdgeInsets.all(8.0),
      ),
    );
  }
}
