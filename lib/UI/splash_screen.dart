import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home_page.dart';

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
    _controller = AnimationController(
      // duration: Duration(seconds: 0),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Lottie.asset('lib/assets/splash.json',
            controller: _controller,
            height: MediaQuery.of(context).size.height * 1,
            animate: true, onLoaded: (composition) {
      _controller
        ..duration = composition.duration
        ..forward().whenComplete(() => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(date: DateTime.now(),)),
            ));
    }));
  }
}
