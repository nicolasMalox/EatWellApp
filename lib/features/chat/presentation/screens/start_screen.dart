import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

// StartScreen displays the introductory screen for the EatWell app.
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin {
  // Animation controller for the logo animation.
  late AnimationController _controller;
  // Animation value for translating the "Start" button.
  late Animation<double> _animation;
  // List of slogans to display in a rotating fashion.
  final List<String> slogans = [
    "🍏 Eat what you love, just healthier!",
    "🥗 Same taste, better nutrition!",
    "🍽️ Your favorite meals, made healthy!",
    "💚 Healthy swaps, same cravings!",
    "🥑 Enjoy what you love, guilt-free!",
    "🍔 Better ingredients, same flavors!",
    "🥦 Smart eating, delicious living!",
    "🍎 Nutritious. Delicious. Effortless.",
  ];

  // Index to keep track of the current slogan being displayed.
  int _currentSloganIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initializing the animation controller.
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    // Setting up the animation for the "Start" button to bob up and down.
    _animation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    // Starting the rotation of slogans.
    _startSloganRotation();
  }

  @override
  void dispose() {
    // Disposing the animation controller when the widget is removed.
    _controller.dispose();
    super.dispose();
  }

  // Method to rotate slogans every 2 seconds.
  void _startSloganRotation() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentSloganIndex = (_currentSloganIndex + 1) % slogans.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Displaying the logo in the center.
            Expanded(
              child: Center(
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CupertinoColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.systemGrey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/eatwell_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Switching between slogans using AnimatedSwitcher for smooth transitions.
            AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: Text(
                slogans[_currentSloganIndex],
                key: ValueKey(_currentSloganIndex),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.systemGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            // "Start" button that moves up and down with the animation.
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -_animation.value),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: CupertinoButton.filled(
                      onPressed: () => context.push('/chat'),
                      child: Text("Start"),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
