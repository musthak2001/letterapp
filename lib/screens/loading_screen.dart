import 'package:flutter/material.dart';
import 'dart:ui';

/// Loading Screen that shows a blurred background with a spinner and animated text.
/// Automatically navigates to '/homeScreen' after 5 seconds.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    // After 5 seconds, navigate to HomeScreen
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/homeScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background blur layer with gradient overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Centered content: spinner + animated text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                // Circular progress indicator
                CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                  strokeWidth: 4,
                ),

                SizedBox(height: 25),

                // Animated loading text
                AnimatedLoadingText(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated text that fades in and out to indicate loading
class AnimatedLoadingText extends StatefulWidget {
  const AnimatedLoadingText({super.key});

  @override
  State<AnimatedLoadingText> createState() => _AnimatedLoadingTextState();
}

class _AnimatedLoadingTextState extends State<AnimatedLoadingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller to manage the fade effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // Tween animation from 0.4 to 1.0 opacity
    _opacityAnimation =
        Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    // Dispose controller to free resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: const Text(
        'Generating your email...',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
