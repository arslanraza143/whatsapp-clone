import 'dart:async';
import 'dart:io';

import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

import 'package:whatsapp_clone/pages/share_data.dart';

class CameraView extends StatefulWidget {
  final File? image;
  final File? video;
  //final String? message;
  //const CameraView(XFile file, {super.key, this.image, this.video});
  const CameraView({super.key, this.image, this.video});
  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  TextEditingController _controller = TextEditingController();
  int _rotationAngle = 0;
  bool imagerotated = false;
  VideoPlayerController? _videoController;
  bool isPlay = true;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (widget.video != null) {
      _videoController = VideoPlayerController.file(widget.video!)
        ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
          _videoController!.setLooping(Platform.isAndroid);
        });
      _videoController!.addListener(() {
        if (_videoController!.value.isInitialized) {
          setState(() {
            _currentPosition = _videoController!.value.position;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Captured Image'),
        actions: [
          IconButton(
            icon: Icon(Icons.crop_rotate),
            onPressed: () {
              // Handle the action for saving or using the captured image
              // For example, you might want to save it to a gallery or send it
              //Navigator.pop(context, image); // Return the image to the previous screen
              _rotateImage();
            },
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.emoji_emotions_outlined),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.title)),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Center(
                child: widget.image != null
                    ? Container(
                        //width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 200,
                        child: Transform.rotate(
                          angle: _rotationAngle * math.pi / 180,
                          child: Image.file(widget.image!, fit: BoxFit.cover),
                        ),
                      )
                    : widget.video != null &&
                          _videoController != null &&
                          _videoController!.value.isInitialized
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            if (isPlay) {
                              _videoController!.pause();
                              isPlay = false;
                            } else {
                              _videoController!.play();
                              isPlay = true;
                            }
                          });
                        },
                        onLongPress: () {
                          _videoController!.setPlaybackSpeed(1.25);
                        },

                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 200,
                          child: AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          ),
                        ),
                      )
                    : Center(child: Text('No image captured')),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  //padding: EdgeInsets.only(right: 250),
                  color: Colors.black54,

                  width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: 16.0,
                  //   vertical: 8.0,
                  // ),
                  child: TextFormField(
                    maxLines: 5,
                    controller: _controller,
                    minLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),

                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      suffixIcon: CircleAvatar(
                        radius: 5, // Small radius
                        backgroundColor: Colors.teal,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            print('send tapped');
                            Provider.of<ShareData>(
                              context,
                              listen: false,
                            ).setImagePath(
                              widget.image!.path,
                              _controller.text.trim(),
                            );
                            // Go back to specific_chat_screen
                            //Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Container(), // Assuming _pickImageFromGallery is in CameraPage
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Colors.white,
                        ),
                      ),
                      hintText: 'Add a caption...',
                      hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
                      // border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              widget.video != null
                  ? Positioned(
                      top: 0,
                      left: 170,
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            _formatDuartion(_currentPosition),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              if (widget.video != null &&
                  _videoController != null &&
                  _videoController!.value.isInitialized)
                Positioned(
                  left: 170,
                  bottom: 400,
                  child: Container(
                    child: isPlay
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _videoController!.pause();
                                isPlay = false;
                              });
                            },
                            icon: Icon(
                              Icons.pause,
                              size: 50,
                              color: Colors.black26,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                _videoController!.play();
                                isPlay = true;
                              });
                            },
                            icon: Icon(
                              Icons.play_arrow,
                              size: 50,
                              color: Colors.black26,
                            ),
                          ),
                  ),
                ),
              Positioned(
                bottom: 200,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text('', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _rotateImage() async {
    setState(() {
      _rotationAngle = (_rotationAngle + 90) % 360;
    });
  }

  String _formatDuartion(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconnds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconnds";
  }
}
