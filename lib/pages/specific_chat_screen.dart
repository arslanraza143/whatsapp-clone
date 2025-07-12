import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/custom_ui/own_image_card.dart';
import 'package:whatsapp_clone/custom_ui/own_message_card.dart';
import 'package:whatsapp_clone/custom_ui/reply_image_card.dart';
import 'package:whatsapp_clone/custom_ui/reply_message_card.dart';
import 'package:whatsapp_clone/models/chat_custom_card_model.dart';
import 'package:whatsapp_clone/models/message_model.dart';
import 'package:whatsapp_clone/pages/camera_page.dart';
import 'package:whatsapp_clone/pages/dummy.dart';
import 'package:whatsapp_clone/pages/open_file.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatsapp_clone/pages/share_data.dart';
import 'package:whatsapp_clone/screens/camera_view.dart';

class SpecificChatScreen extends StatefulWidget {
  const SpecificChatScreen({super.key, required this.chatCustomCard});
  final ChatCustomCard chatCustomCard;

  @override
  State<SpecificChatScreen> createState() => _SpecificChatScreenState();
}

class _SpecificChatScreenState extends State<SpecificChatScreen> {
  int popTime = 0;
  late XFile? file;
  ScrollController _scrollController = ScrollController();
  List<MessageModel> messages = [];
  bool isSend = false;
  late IO.Socket socket; // create instance
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();

  @override
  initState() {
    super.initState();

    // Listen for changes in ShareData when image will send
    Provider.of<ShareData>(
      context,
      listen: false,
    ).addListener(_onShareDataChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chat = Provider.of<ShareData>(context, listen: false).sourceChat;
      connect(chat);
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false; // Hide emoji picker when text field is focused
        });
      }
    });
  }

  void connect(ChatCustomCard? chat) {
    socket = IO.io(
      //"https://aa09a796-8ac1-40e3-8d0f-c5329eeebf88-00-2lqyeysxiwbq0.sisko.replit.dev/",
      "http://192.168.0.199:5000/",
      <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      },
    );
    socket.connect();
    socket.onConnect((data) {
      print("Socket Connected");
      //data from the socket
      socket.on("message", (msg) {
        print(msg);
        setMessage(msg['message'], 'destination', msg['path']);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(microseconds: 200),
          curve: Curves.easeOut,
        );
      });
    });
    print(socket.connected);
    socket.emit("signin", chat!.id);
  }

  void sendMessage(String message, int sourceId, int targetId, String path) {
    setMessage(message, 'source', path);
    socket.emit('message', {
      'message': message,
      'sourceId': sourceId,
      'targetId': targetId,
      'path': path,
    });
  }

  //to show the msg/phots locally on the indivial chat page
  void setMessage(String message, String type, String path) {
    MessageModel messageModel = MessageModel(
      path: path,
      type: type,
      message: message,
      time: DateTime.now().toString().substring(11, 16),
    );
    setState(() {
      messages.add(messageModel);
    });
  }

  void _onShareDataChanged() {
    final shareData = Provider.of<ShareData>(context, listen: false);
    if (shareData.imagePath != null) {
      ImageSend(shareData.imagePath!, shareData.message!);
      // Optionally clear after sending

      shareData.clearImagePath();
    }
  }

  void ImageSend(String path, String message) async {
    //final shareData = Provider.of<ShareData>(context, listen: false);
    print('this is the caption: $message');
    var request = http.MultipartRequest(
      "post",
      Uri.parse("http://192.168.0.199:5000/routes/addImage"),
    );
    request.files.add(await http.MultipartFile.fromPath('img', path));
    request.headers.addAll({"content-type": "multipart/form-data"});
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = jsonDecode(httpResponse.body);
    // Get the image path returned by the server
    String serverImagePath = data['path']; // Make sure your server returns this

    print("this is the final:$serverImagePath");
    print(response.statusCode);
    setMessage(message, 'source', serverImagePath);

    socket.emit("message", {
      "message": message,
      "sourceId": Provider.of<ShareData>(
        context,
        listen: false,
      ).sourceChat!.id!,
      "targetId": widget.chatCustomCard.id,
      "path": serverImagePath,
    });

    for (int i = 1; i < popTime; i++) {
      Navigator.pop(context);
    }
    setState(() {
      popTime = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<ShareData>(context).sourceChat;
    // final shareData = Provider.of<ShareData>(context);
    // String? path = shareData.imagePath!;
    // Only send if imagePath is set
    // if (shareData.imagePath != null) {
    //   String? path = shareData.imagePath!;
    //   //ImageSend(shareData.imagePath!);
    //   // Clear after sending to avoid repeated calls
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     shareData.clearImagePath();
    //   });
    // }
    return Stack(
      children: [
        Image.asset(
          'assets/whatsapp_background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            titleSpacing: 0.0, // Remove default title spacing
            leadingWidth: 70,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // Handle tap on the back button
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ), // Back button icon
                ),
                CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 20.0, // Adjust the radius as needed
                  child: SvgPicture.asset(
                    widget.chatCustomCard.icon!,
                    height: 25,
                    width: 25,
                  ),
                ),
              ],
            ),
            title: InkWell(
              onTap: () {
                // Handle tap on the title
                print('Contact tapped');
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.chatCustomCard.name!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          'Online',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Color(0xFF075E54),
            // Primary color for AppBar
            actions: [
              IconButton(
                icon: Icon(Icons.video_call),
                onPressed: () {
                  // Handle video call action
                },
              ),
              IconButton(
                icon: Icon(Icons.call),
                onPressed: () {
                  // Handle voice call action
                },
              ),
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'view_contact',
                      child: Text('View Contact'),
                    ),
                    PopupMenuItem(
                      value: 'media_visibility',
                      child: Text('Media Visibility'),
                    ),
                    PopupMenuItem(value: 'search', child: Text('Search')),
                    PopupMenuItem(
                      value: 'mute_notifications',
                      child: Text('Mute Notifications'),
                    ),
                    PopupMenuItem(
                      value: 'block_contact',
                      child: Text('Block Contact'),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () async {
                if (show) {
                  setState(() {
                    show = false; // Hide emoji picker when popping the screen
                  });
                  return false; // Prevent pop
                }
                return true; // Allow pop
              },
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 160,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index == messages.length)
                          return Container(height: 70);
                        if (messages[index].type == 'source') {
                          if (messages[index].path != null &&
                              messages[index].path!.isNotEmpty) {
                            print('image path${messages[index].path}');
                            return OwnImageCard(
                              path: messages[index].path!,
                              message: messages[index].message,
                              time: messages[index].time,
                              // DateTime.tryParse(messages[index].time) ??
                              // DateTime.now(),
                              //DateTime.tryParse(messages[index].time) ?? DateTime.now(),
                            );
                          } else {
                            return OwnMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        } else {
                          if (messages[index].path != null &&
                              messages[index].path!.isNotEmpty) {
                            print('image path${messages[index].path}');
                            return ReplyImageCard(
                              path: messages[index].path!,
                              message: messages[index].message,
                              time: messages[index].time,
                              // DateTime.tryParse(messages[index].time) ??
                              // DateTime.now(),
                              //DateTime.tryParse(messages[index].time) ?? DateTime.now(),
                            );
                          } else {
                            return ReplyMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 55,
                              child: Card(
                                margin: EdgeInsets.only(
                                  bottom: 8,
                                  right: 5,
                                  left: 5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    25,
                                  ),
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        isSend = true;
                                      });
                                    } else {
                                      setState(() {
                                        isSend = false;
                                      });
                                    }
                                  },
                                  controller: textEditingController,

                                  textAlignVertical: TextAlignVertical.center,

                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,

                                    hintText: 'Type a message',
                                    contentPadding: EdgeInsets.all(5),
                                    prefixIcon: IconButton(
                                      icon: Icon(Icons.emoji_emotions),
                                      onPressed: () {
                                        focusNode.unfocus();
                                        focusNode.canRequestFocus = false;
                                        // Handle emoji action
                                        setState(() {
                                          show = !show;
                                        });
                                      },
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.attach_file),
                                          onPressed: () {
                                            // Handle attachment action
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (builder) =>
                                                  bottomsheet(),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.camera_alt),
                                          onPressed: () {
                                            setState(() {
                                              popTime = 3;
                                            });
                                            // Handle camera action
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CameraPage(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),

                              child: CircleAvatar(
                                radius: 23.0, // Adjust the radius as needed
                                backgroundColor: Color(0xFF075E54),
                                child: IconButton(
                                  icon: isSend
                                      ? Icon(Icons.send, color: Colors.white)
                                      : Icon(Icons.mic, color: Colors.white),
                                  onPressed: () {
                                    if (isSend &&
                                        textEditingController.text.length > 1) {
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position
                                            .maxScrollExtent,
                                        duration: Duration(microseconds: 200),
                                        curve: Curves.easeOut,
                                      );
                                      sendMessage(
                                        textEditingController.text,
                                        chat!.id!,
                                        widget.chatCustomCard.id!,
                                        '',
                                      );
                                      textEditingController.clear();
                                      setState(() {
                                        isSend = false;
                                      });
                                    }

                                    // Handle send action
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        show ? emojiPicker() : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconButton(
                  color: Color(0xFF075E54),
                  icon: Icons.file_open_rounded,
                  onPressed: () {
                    // Handle camera action
                    //Navigator.pop(context);
                    pickFile();
                  },
                  text: Text('Documents'),
                ),
                iconButton(
                  color: Color.fromARGB(255, 175, 14, 14),
                  icon: Icons.camera_alt,
                  onPressed: () {
                    setState(() {
                      popTime = 4;
                    });
                    // Handle camera action
                    //Navigator.pop(context);
                    //CameraPage();
                    print('Camera button pressed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraPage()),
                    );
                  },
                  text: Text('Camera'),
                ),
                iconButton(
                  color: Color.fromARGB(255, 73, 6, 59),
                  icon: Icons.image,
                  onPressed: () async {
                    setState(() {
                      popTime = 3;
                    });
                    // Handle image action
                    // Navigator.pop(context);
                    file = await pickPhoto();
                    if (file != null) {
                      //File fileAsFile = File(file!.path);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) =>
                              CameraView(image: File(file!.path)),
                        ),
                      );
                    } else {
                      print('No file selected');
                    }

                    //print('this is the file path' + file.path);
                  },
                  text: Text('Gallery'),
                ),
                //       CircleAvatar(
                //         radius: 25.0, // Adjust the radius as needed
                //         backgroundColor: Color(0xFF075E54),
                //         child: Column(
                //           children: [
                //             IconButton(
                //               icon: Icon(Icons.file_open_rounded, color: Colors.white),
                //               onPressed: () {
                //                 // Close the bottom sheet
                //               },
                //             ),
                //             Text(
                //               'Document',
                //               style: TextStyle(color: Colors.black, fontSize: 12),
                //             ),
                //           ],
                //         ),
                //       ),
                //       CircleAvatar(
                //         radius: 25.0, // Adjust the radius as needed
                //         backgroundColor: Color.fromARGB(255, 175, 14, 14),
                //         child: IconButton(
                //           icon: Icon(Icons.camera_alt, color: Colors.white),
                //           onPressed: () {
                //             // Handle camera action
                //             Navigator.pop(context);
                //           },
                //         ),
                //       ),
                //       CircleAvatar(
                //         radius: 25.0, // Adjust the radius as needed
                //         backgroundColor: Color.fromARGB(255, 73, 6, 59),
                //         child: IconButton(
                //           icon: Icon(Icons.image, color: Colors.white),
                //           onPressed: () {
                //             // Handle image action
                //             Navigator.pop(context);
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     CircleAvatar(
                //       radius: 25.0, // Adjust the radius as needed
                //       backgroundColor: Color.fromARGB(255, 168, 115, 1),
                //       child: IconButton(
                //         icon: Icon(Icons.headphones, color: Colors.white),
                //         onPressed: () {
                //           // Close the bottom sheet
                //         },
                //       ),
                //     ),
                //     CircleAvatar(
                //       radius: 25.0, // Adjust the radius as needed
                //       backgroundColor: Color.fromARGB(255, 1, 119, 21),
                //       child: IconButton(
                //         icon: Icon(Icons.location_on, color: Colors.white),
                //         onPressed: () {
                //           // Handle camera action
                //           Navigator.pop(context);
                //         },
                //       ),
                //     ),
                //     CircleAvatar(
                //       radius: 25.0, // Adjust the radius as needed
                //       backgroundColor: Color.fromARGB(255, 35, 49, 177),
                //       child: IconButton(
                //         icon: Icon(Icons.person, color: Colors.white),
                //         onPressed: () {
                //           // Handle image action
                //           Navigator.pop(context);
                //         },
                //       ),
                //     ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconButton(
                  color: Color.fromARGB(255, 168, 115, 1),
                  icon: Icons.headphones,
                  onPressed: () {
                    // Handle headphones action
                    //Navigator.pop(context);
                    pickAudio();
                  },
                  text: Text('Audio'),
                ),
                iconButton(
                  color: Color.fromARGB(255, 1, 119, 21),
                  icon: Icons.location_on,
                  onPressed: () {
                    // Handle location action
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dummy()),
                    );
                  },
                  text: Text('Location'),
                ),
                iconButton(
                  color: Color.fromARGB(255, 35, 49, 177),
                  icon: Icons.person,
                  onPressed: () {
                    // Handle contact action
                    Navigator.pop(context);
                  },
                  text: Text('Contact'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget iconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
    required Text text,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25.0, // Adjust the radius as needed
          backgroundColor: color,
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 5), // Add some space between icon and text
        Text(
          text.data ?? '',
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ],
    );
  }

  Widget emojiPicker() {
    return EmojiPicker(
      config: Config(
        height: 256,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          // Issue: https://github.com/flutter/flutter/issues/28894
          emojiSizeMax:
              28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.20
                  : 1.0),
        ),
        viewOrderConfig: const ViewOrderConfig(
          top: EmojiPickerItem.categoryBar,
          middle: EmojiPickerItem.emojiView,
          bottom: EmojiPickerItem.searchBar,
        ),
        skinToneConfig: const SkinToneConfig(),
        categoryViewConfig: const CategoryViewConfig(),
        bottomActionBarConfig: const BottomActionBarConfig(),
        searchViewConfig: const SearchViewConfig(),
      ),
      onEmojiSelected: (category, emoji) {
        print(emoji);
        setState(() {
          textEditingController.text += emoji.emoji;
          // Keep focus on the text field
        });
      },
    );
  }
}
