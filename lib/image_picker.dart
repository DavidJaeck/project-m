import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';  // For File

class ImagePickerExample extends StatefulWidget {
  @override
  _ImagePickerExampleState createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _image;

  // Create an instance of ImagePicker
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set the picked image to the File
      });
    }
  }

  // Function to capture an image from the camera
  Future<void> _captureImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set the captured image to the File
      });
    }
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
