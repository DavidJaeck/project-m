import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';  // For getting the local directory

class ImageDisplayWidget extends StatefulWidget {
  @override
  _ImageDisplayWidgetState createState() => _ImageDisplayWidgetState();
}

class _ImageDisplayWidgetState extends State<ImageDisplayWidget> {
  File? _image;  // This will hold the image file

  // Load the image file from the local storage
  Future<void> _loadImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final List<FileSystemEntity> files = await Directory(directory.path).list().toList();

      // Filter files to get only image files (you can add more image extensions as needed)
      final List<FileSystemEntity> imageFiles = files.where((file) {
        final String filePath = file.path.toLowerCase();
        return filePath.endsWith('.jpg') ||
            filePath.endsWith('.jpeg') ||
            filePath.endsWith('.png') ||
            filePath.endsWith('.gif') ||
            filePath.endsWith('.bmp') ||
            filePath.endsWith('.webp');
      }).toList();

      // Print the list of image file paths
      for (var imageFile in imageFiles) {
        print('Found image: ${imageFile.path}');
      }
      final imagePath = '${directory.path}/1733769619610.jpg';  // Replace with your actual image filename
      final imageFile = File(imagePath);

      if (await imageFile.exists()) {
        setState(() {
          _image = imageFile;  // Assign the image to the file object
        });
      } else {
        setState(() {
          _image = null;  // If image doesn't exist, set it to null
        });
      }
    } catch (e) {
      print('Error loading image: $e');
      setState(() {
        _image = null;  // In case of an error, reset to null
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImage();  // Load the image when the widget is created
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _image == null
          ? Text('No image available.')  // Display message if no image
          : Image.file(_image!),  // Display the image if available
    );
  }
}
