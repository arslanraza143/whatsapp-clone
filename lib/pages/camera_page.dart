import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

import 'package:whatsapp_clone/screens/camera_view.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPage();
}

class _CameraPage extends State<CameraPage> {
  bool _isFrontCamera = false;
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isRecording = false;
  Timer? _recordingTimer;
  Duration _recordDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![0], ResolutionPreset.high);
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isFrontCamera = true;
        });
      }
    }
  }

  Future<void> _initRareCamera() async {
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![1], ResolutionPreset.ultraHigh);
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isFrontCamera = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    final XFile file = await _controller!.takePicture();
    
    if (!mounted) return;
    Navigator.push( 
      context,
      MaterialPageRoute(
        builder: (context) => CameraView(image: File(file.path)),
      ),
    );
  }

  Future<void> _startVideoRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    setState(() {
      _isRecording = true;
      _recordDuration = Duration.zero;
    });
    await _controller!.startVideoRecording();
    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _recordDuration += Duration(seconds: 1);
      });
    });
  }

  Future<void> _stopVideoRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    final XFile file = await _controller!.stopVideoRecording();
    _recordingTimer?.cancel();
    setState(() {
      _isRecording = false;
      _recordDuration = Duration.zero;
    });
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraView(video: File(file.path)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Stack(
      children: [
        CameraPreview(_controller!),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: GestureDetector(
              onPanUpdate: (details) {},
              onTap: _capturePhoto,
              onLongPress: _startVideoRecording,
              onLongPressUp: _stopVideoRecording,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color.fromARGB(82, 68, 65, 65),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.clear, color: Colors.white, size: 40),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: _isRecording ? Colors.red : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 4),
                      ),
                      child: Icon(
                        _isRecording ? Icons.videocam : Icons.camera_alt,
                        color: _isRecording ? Colors.white : Colors.black,
                        size: 36,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color.fromARGB(82, 68, 65, 65),
                      child: IconButton(
                        onPressed: () {
                          _isFrontCamera ? _initRareCamera() : _initCamera();
                        },
                        icon: Icon(
                          Icons.flip_camera_android_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Icon(Icons.rotate_90_degrees_ccw),

        if (_isRecording)
          // Text(
          //   _formatDuration(_recordDuration),
          //   style: TextStyle(
          //     color: Colors.red,
          //     fontSize: 18,
          //    ),
          // ),
          Positioned(
            top: 40,
            left: MediaQuery.of(context).size.width / 2 - 60, // Centered
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.transparent,
                // Mask anything behind
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _recordDuration.inSeconds % 2 == 0
                      ? Icon(
                          Icons.fiber_manual_record,
                          color: Colors.red,
                          size: 18,
                        )
                      : Icon(
                          Icons.fiber_manual_record,
                          color: Colors.white,
                          size: 18,
                        ),
                  SizedBox(width: 5),
                  Material(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: _formatDuration(_recordDuration),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import 'package:whatsapp_clone/screens/camera_view.dart';

// class CameraPage extends StatefulWidget {
//   const CameraPage({super.key});

//   @override
//   State<CameraPage> createState() => _CameraPage();
// }

// class _CameraPage extends State<CameraPage> {
//   File? _image;
//   bool _cameraTried = false;
//   @override
//   void initState() {
//     super.initState();
//     _pickImageFromCamera();
//   }

//   Future<void> _pickImageFromCamera() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(
//       source: ImageSource.camera,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         _cameraTried = true;
//         //Navigator.push(context, MaterialPageRoute(builder: (context) => CameraView()))
//       });
//     } else {
//       Navigator.pop(context); // Always pop, regardless of result
//     }
//   }

  

//   Future<void> _pickImageFromGallery() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         _cameraTried = true;
//       });
//     } else {
//       Navigator.pop(context); // Always pop, regardless of result
//     }
//   }

//   Future<void> _videoFromCamera() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickVideo(
//       source: ImageSource.camera,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         _cameraTried = true;
//       });
//     } else {
//       Navigator.pop(context); // Always pop, regardless of result
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _image != null
//             ? CameraView(image: _image)
//             : _cameraTried
//             ? Text('No image captured')
//             : CircularProgressIndicator(),
//       ),

//       // Center(
//       //   child: _image != null
//       //       ?
//       //         Image.file(_image!)

//       //       : _cameraTried
//       //       ? Text('No image captured')
//       //       : CircularProgressIndicator(),
//       // ),
//     );
//   }
// }


