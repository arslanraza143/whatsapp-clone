import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  final String message;
  final String time;
  const OwnMessageCard({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,

      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          color: Color(0xffdcf8c6),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  right: 30,
                  left: 10,
                  top: 5,
                ),
                child: Text(message, style: TextStyle(fontSize: 17)),
              ),
              Positioned(
                right: 5,
                bottom: 0,
                child: Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.done_all, size: 20, color: Colors.blue),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
