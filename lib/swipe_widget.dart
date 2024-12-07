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
    'http://172.26.242.140:9000/mybucket/uploaded-images/1733596117080-pexels-photo-799443.jpeg',
    'http://172.26.242.140:9000/mybucket/uploaded-images/1733596225027-pexels-photo-1366919.jpeg',
    'http://172.26.242.140:9000/mybucket/uploaded-images/1733596241180-pexels-photo-1535162.jpeg',
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

  // Method to trigger animation for left or right swipe using buttons
  void _triggerSwipeAnimation(bool swipeRight) {
    setState(() {
      if (swipeRight) {
        _tween.begin = Offset(0, 0);
        _tween.end = Offset(2.0, 0); // Swipe Right
      } else {
        _tween.begin = Offset(0, 0);
        _tween.end = Offset(-2.0, 0); // Swipe Left
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
      floatingActionButton: Align(
        alignment: Alignment.center, // Align to the left
        child: Padding(
          padding: const EdgeInsets.only(left: 0), // Customize left padding as needed
          child: Row(
            mainAxisSize: MainAxisSize.min, // Ensure row size is minimal
            children: [
              // Left swipe button
              FloatingActionButton(
                onPressed: () {
                  _triggerSwipeAnimation(false); // Trigger swipe left animation
                },
                child: Icon(Icons.arrow_back),
                heroTag: 'left-swipe-btn',
                backgroundColor: Colors.red,
              ),

              SizedBox(width: 32), // Space between the buttons
              // Right swipe button
              FloatingActionButton(
                onPressed: () {
                  _triggerSwipeAnimation(true); // Trigger swipe right animation
                },
                child: Icon(Icons.arrow_forward),
                heroTag: 'right-swipe-btn',
                backgroundColor: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}