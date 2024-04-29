import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gemini_bot/home/home_screen.dart';
import 'package:gemini_bot/onboard/api_key.dart';
import 'package:gemini_bot/util/share_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _controller.repeat(reverse: true);

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Prefs.getBool("api_key_set")
                ? HomeScreen()
                // const ChatRoomPage()
                : const ApiKeyScreen(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Align(
              child: ScaleTransition(
                scale: Tween(begin: 0.95, end: 1.0).animate(CurvedAnimation(
                    parent: _controller, curve: Curves.elasticOut)),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: AssetImage("assets/logo.png"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
