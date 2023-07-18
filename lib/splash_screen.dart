import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'qibla_viewmodel.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch Qibla data after a brief delay to simulate loading.
    Future.delayed(const Duration(seconds: 2), () {
      Provider.of<QiblaViewModel>(context, listen: false).fetchQiblaData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Customize the splash screen UI here.
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
