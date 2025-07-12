import 'package:flutter/material.dart';

class ReplyMessageCard extends StatelessWidget {
  final String message;
  final String time;
  const ReplyMessageCard({
    super.key,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,

      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                child: Text(
                  time,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
