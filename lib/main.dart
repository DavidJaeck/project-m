import 'package:flutter/material.dart';
import 'swipe_widget.dart';
import 'nav_bar.dart';

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
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SwipeAnimationExample(),  // The swipe widget remains at the top
          ),
          // The bottom navigation bar is placed at the bottom
          CustomBottomNavBar(
            currentIndex: _selectedIndex, // Pass the current index
            onTap: _onItemTapped,  // Handle item taps
          ),
        ],
      ),
    );
  }
}

