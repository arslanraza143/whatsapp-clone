import 'package:flutter/material.dart';
import 'package:whatsapp_clone/custom_ui/status_pages/other_status_page.dart';

class StatusCustomCard extends StatefulWidget {
  const StatusCustomCard({super.key});

  @override
  State<StatusCustomCard> createState() => _StatusCustomCardState();
}

class _StatusCustomCardState extends State<StatusCustomCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/arslan.jpg'),
                ),
                title: Text(
                  'My Status',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                subtitle: Text(
                  '31 minutes ago',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
                ),
                trailing: PopupMenuButton(
                  icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        value: 'view_status',
                        child: Text('View Status'),
                      ),
                      PopupMenuItem(
                        value: 'delete_status',
                        child: Text('Delete Status'),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    print(value);
                  },
                ),
              ),
            ),
          ],
        ),
        label('Recent Updates'),
        SizedBox(height: 5),
        OtherStatusPage(
          name: 'Awais Raza',
          time: DateTime.now().toString().substring(10, 13),
          imageName: "assets/awais.png", isSeen: false, statusNum: 2,
          
        ),
        OtherStatusPage(
          name: 'Asad Raza',
          time: DateTime.now().toString().substring(10, 13),
          imageName: "assets/awais.png", isSeen: false, statusNum: 5,
        ),
        OtherStatusPage(
          name: 'Usman Raza',
          time: DateTime.now().toString().substring(10, 13),
          imageName: "assets/awais.png", isSeen: false, statusNum: 1
        ),
        SizedBox(height: 5),
        label('Viewed Updates'),
        OtherStatusPage(
          name: 'Awais Raza',
          time: DateTime.now().toString().substring(10, 13),
          imageName: "assets/awais.png",isSeen: true, statusNum: 3
        ),
        OtherStatusPage(
          name: 'Asad Raza',
          time: DateTime.now().toString().substring(10, 13),
          imageName: "assets/awais.png",isSeen: true, statusNum: 10
        ),
        OtherStatusPage(
          name: 'Usman Raza',
          time: DateTime.now().toString().substring(10, 13),
          imageName: "assets/awais.png",isSeen: true, statusNum: 6
        ),
      ],
    );
  }

  Widget label(String labelName) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            labelName,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
