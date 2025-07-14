import 'dart:io';

import 'package:flutter/material.dart';

class ReplyImageCard extends StatefulWidget {
  final String path;
  final String message;
  final String time;
  //final String? image;
  const ReplyImageCard({super.key, required this.path, required this.message, required this.time});

  @override
  State<ReplyImageCard> createState() => _ReplyImageCardState();
}

class _ReplyImageCardState extends State<ReplyImageCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Container(
          height: MediaQuery.of(context).size.height / 2.3,
          width: MediaQuery.of(context).size.width / 1.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey,
          ),
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.all(3),
            color:  Colors.green[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Image.network(
                      //'http://192.168.0.199:5000/uploads/${widget.path}',
                      'https://chatserver-production-e87f.up.railway.app/uploads/${widget.path}',
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
                            overflow: TextOverflow.ellipsis,
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
    );
  }
}
