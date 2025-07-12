import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/pages/share_data.dart';

class OwnImageCard extends StatefulWidget {
  final String path;
  final String message;
  final String time;

  // final String imagePath;
  const OwnImageCard({
    super.key,
    required this.path,
    required this.message,
    required this.time,
  });

  @override
  State<OwnImageCard> createState() => _OwnImageCardState();
}

class _OwnImageCardState extends State<OwnImageCard> {
  // Build the full image URL
  //String imageUrl = 'http://192.168.0.199:5000/uploads/${widget.path}';
  @override
  Widget build(BuildContext context) {
    // final shareData = Provider.of<ShareData>(context);

    // // Only send if imagePath is set
    // if (shareData.imagePath != null) {
    //   String? path = shareData.imagePath;

    //   // Clear after sending to avoid repeated calls
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     shareData.clearImagePath();
    //   });
    // }
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Container(
          height: MediaQuery.of(context).size.height / 2.3,
          width: MediaQuery.of(context).size.width / 1.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.green[300],
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,
              maxHeight: MediaQuery.of(context).size.height - 10,
            ),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.green[300],
              margin: EdgeInsets.all(3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              // For mobile/desktop, use file
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Image.network(
                      'http://192.168.0.199:5000/uploads/${widget.path}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.broken_image),
                    ),
                    // Image.file(
                    //   File(widget.path),
                    //   fit: BoxFit.cover,
                    //   width: double.infinity,
                    // ),
                  ),
                  widget.message.length > 1
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            widget.message,
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                        )
                      : Container(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      widget.time.toString(),
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
