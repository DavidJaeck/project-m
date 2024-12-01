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
          BottomNavigationBar(
            currentIndex: _selectedIndex,  // Current selected index
            onTap: _onItemTapped,  // Handle item tap
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("project_m"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SwipeAnimationExample(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("click"),
      ),
    );
  }
}


