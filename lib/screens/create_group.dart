import 'package:flutter/material.dart';
import 'package:whatsapp_clone/custom_ui/avatar_card_group.dart';
import 'package:whatsapp_clone/custom_ui/contact_custom_card.dart';
import 'package:whatsapp_clone/models/chat_custom_card_model.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatCustomCard> group = [];
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
              'New Group',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Add participants',
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
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              group.isNotEmpty
                  ? Container(
                      height: 75,

                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          if (contacts[index].isSelected == true) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  contacts[index].isSelected = false;
                                  group.remove(contacts[index]);
                                });
                              },
                              child: AvatarCardGroup(contacts: contacts[index]),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
          group.isNotEmpty ? Divider(thickness: 1) : Container(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        if (contacts[index].isSelected == false) {
                          setState(() {
                            contacts[index].isSelected = true;
                            group.add(contacts[index]);
                            //print('this is the stack: ' + group.toString());
                          });
                        } else {
                          setState(() {
                            contacts[index].isSelected = false;
                            group.remove(contacts[index]);
                            //print('this is the stack: ' + group.toString());
                          });
                        }
                      },
                      child: ContactCustomCard(contacts: contacts[index]),
                    ),
                    contacts[index].isSelected
                        ? Positioned(
                            right: 330,
                            top: 40,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: const Color.fromARGB(
                                255,
                                28,
                                161,
                                33,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                );
              },
              itemCount: contacts.length,
              padding: const EdgeInsets.all(8.0),
            ),
          ),
        ],
      ),
    );
  }
}
