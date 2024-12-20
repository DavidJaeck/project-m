import 'package:flutter/material.dart';

import 'swipe_widget.dart';
import 'nav_bar.dart';
import 'image_picker.dart';
import 'saved_image.dart';

class DefaultScreen extends StatefulWidget {
  final VoidCallback logoutCallback;

  const DefaultScreen({required this.logoutCallback});

  @override
  _DefaultScreenState createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  int _selectedIndex = 0;  // Tracks the currently selected index in the bottom navbar


  // List of widgets corresponding to the bottom nav items
  List<Widget> _widgetOptions = [
    SwipeAnimationExample(), // Displayed when Home tab is selected
    ImagePickerExample(), // Placeholder for Search
    ImageDisplayWidget()
  ];

  // Called when an item is tapped in the bottom nav bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe Animation with Navbar"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),  // Render widget based on selected index
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,  // Pass the current index
        onTap: _onItemTapped,  // Handle item taps
      ),
    );
  }
}