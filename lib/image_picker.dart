import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';  // For File


class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _image;

  // Create an instance of ImagePicker
  final ImagePicker _picker = ImagePicker();

  // Get the local directory where images can be stored
  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set the picked image to the File
      });
      // Save the image locally
      saveImageLocally(_image!);  // Pass the image to the save function
    }
  }

  // Function to capture an image from the camera
  Future<void> _captureImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set the captured image to the File
      });
      // Save the image locally
      saveImageLocally(_image!);  // Pass the image to the save function
    }
  }

  // Save the picked image to local storage
  Future<void> saveImageLocally(File imageFile) async {
    final directory = await getLocalPath();
    final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';  // Use unique file name
    final localImage = File('$directory/$fileName');

    // Copy the picked image to the local directory
    await imageFile.copy(localImage.path);
    setState(() {
      _image = localImage;
    });
    print('Image saved at: ${localImage.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Picker Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the image
            _image != null
                ? Image.file(_image!) // Display image if selected
                : Text('No image selected'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image from Gallery'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _captureImage,
                  child: Text('Capture Image from Camera'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
