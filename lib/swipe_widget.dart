import 'package:flutter/material.dart';


class SwipeAnimationExample extends StatefulWidget {
  @override
  _SwipeAnimationExampleState createState() => _SwipeAnimationExampleState();
}

class _SwipeAnimationExampleState extends State<SwipeAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<Offset> _tween;
  late Animation<Offset> _animation;

  final double _swipeThreshold = 50.0; // Minimum velocity for a swipe

  // List of images (you can swap these based on your needs)
  List<String> images = [
    'https://images.pexels.com/photos/1212487/pexels-photo-1212487.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/799443/pexels-photo-799443.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1535162/pexels-photo-1535162.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  ];

  int currentImageIndex = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 70),
      vsync: this,
    );

    // Set an initial animation (will update dynamically later)
    _tween = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0));
    _animation = _tween.animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSwipe(double velocity) {
    setState(() {
      if (velocity > 0) {
        // Swipe Right
        _tween.begin = Offset(0, 0);
        _tween.end = Offset(2.0, 0);
      } else {
        // Swipe Left
        _tween.begin = Offset(0, 0);
        _tween.end = Offset(-2.0, 0);
      }

      // Move to the next image in the list after swipe
      currentImageIndex = (currentImageIndex + 1) % images.length;
    });

    _controller.reset(); // Reset the animation controller
    _controller.forward(); // Start the animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          final velocity = details.primaryVelocity ?? 0.0;

          // Trigger animation only if the velocity exceeds the threshold
          if (velocity.abs() > _swipeThreshold) {
            _onSwipe(velocity);
          }
        },
        child: Center(
          child: Stack(
            alignment: Alignment.center, // Align the images at the center
            children: [
              // Background image
              Positioned.fill(
                child: Image.network(
                  images[(currentImageIndex + 1) % images.length], // Next image in line
                  fit: BoxFit.cover,
                ),
              ),
              // The animated image on top
              SlideTransition(
                position: _animation,
                child: Image.network(
                  images[currentImageIndex], // Current image to swipe
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.reverse(); // Reset the animation when FAB is clicked
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}