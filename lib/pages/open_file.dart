import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> pickFile() async {
  final result = await FilePicker.platform.pickFiles(type: FileType.any);
  if (result != null && result.files.single.path != null) {
    String filePath = result.files.single.path!;
    // final OpenResult = await OpenFilex.open(filePath);
    // print('Result: ${OpenResult.message}');
  }
}

// Future<void> pickImage() async {
//   final result = await FilePicker.platform.pickFiles(type: FileType.image);
//   if (result != null && result.files.single.path != null) {
//     String filePath = result.files.single.path!;
//   }
// }

Future<XFile?> pickPhoto() async {
  ImagePicker _picker = ImagePicker();
  XFile? file;
  file = await _picker.pickImage(source: ImageSource.gallery);
  return file;
}

Future<void> pickAudio() async {
  final result = await FilePicker.platform.pickFiles(type: FileType.audio);
  if (result != null && result.files.single.path != null) {
    String filePath = result.files.single.path!;
  }
}

Future<void> getCurrentLocation() async {
  String locationText;
  var status = await Permission.location.request();
  if (status.isGranted) {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    locationText =
        'Latitute: ${position.latitude}\n Longitude: ${position.longitude}';
  } else {
    locationText = "location permission denied";
  }
}
