import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qibla_app/splash_screen.dart';
import 'qibla_viewmodel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QiblaViewModel(),
      child: const MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
