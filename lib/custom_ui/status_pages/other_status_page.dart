import 'dart:math';

import 'package:flutter/material.dart';

class OtherStatusPage extends StatelessWidget {
  final String name;
  final String time;
  final String imageName;
  final bool isSeen;
  final int statusNum;
  const OtherStatusPage({
    super.key,
    required this.name,
    required this.time,
    required this.imageName,
    required this.isSeen,
    required this.statusNum,
  });

  @override
  Widget build(BuildContext context) {
    //   return ListView.builder(
    //     itemCount: 1, // Replace with your actual status count
    //     itemBuilder: (context, index) {
    //       return ListTile(
    //         leading: CircleAvatar(
    //           backgroundImage: AssetImage(imageName),
    //         ),
    //         title: Text(
    //           name,
    //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
    //         ),
    //         subtitle: Text(
    //           '${time} minutes ago',
    //           style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
    //         ),
    //       );
    //     },
    //   );

    return ListTile(
      leading: CustomPaint(
        painter: StatusPainer(isSeen: isSeen, statusNum: statusNum),
        child: CircleAvatar(backgroundImage: AssetImage(imageName)),
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
      subtitle: Text(
        '$time minutes ago',
        style: TextStyle(color: Colors.grey[700], fontSize: 14.0),
      ),
    );
  }
}

degreeToAngle(double degree) {
  return degree * pi / 180;
}

class StatusPainer extends CustomPainter {
  bool isSeen;
  int statusNum;
  StatusPainer({required this.isSeen, required this.statusNum});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 5.0
      ..color = isSeen ? Colors.grey : Color(0xff21bfa6)
      ..style = PaintingStyle.stroke;
    drawArcc(canvas, size, paint);
  }

  void drawArcc(Canvas canvas, Size size, Paint paint) {
    if (statusNum == 1) {
      canvas.drawArc(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        degreeToAngle(0),
        degreeToAngle(360),
        false,
        paint,
      );
    } else {
      double degree = -90;
      double arc = 360 / statusNum;
      for (int i = 0; i < statusNum; i++) {
        canvas.drawArc(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          degreeToAngle(degree + 4),
          degreeToAngle(arc - 8),
          false,
          paint,
        );
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
