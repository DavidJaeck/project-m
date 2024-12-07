import 'package:flutter/material.dart';
import 'swipe_widget.dart';
import 'nav_bar.dart';
import 'image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;  // Tracks the currently selected index in the bottom navbar

  // List of widgets corresponding to the bottom nav items
  List<Widget> _widgetOptions = [
    SwipeAnimationExample(), // Displayed when Home tab is selected
    ImagePickerExample(), // Placeholder for Search
    Center(child: Text("Profile Screen")), // Placeholder for Profile
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
