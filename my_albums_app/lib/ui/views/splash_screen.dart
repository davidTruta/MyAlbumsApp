import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _opacity = _opacity == 0.0 ? 1.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _opacity,
        curve: Curves.easeIn,
        duration: const Duration(seconds: 4),
        child: Center(
          child: Image.asset(
            'assets/images/splash_image.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
