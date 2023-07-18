import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'qibla_viewmodel.dart';

class MainScreen extends StatelessWidget {
  bool get isCompassUnreliable => false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<QiblaViewModel>(context);
    final qiblaDirection = viewModel.qiblaDirection;
    final compassHeading = viewModel.compassHeading;

    // Check if the compass sensor is unreliable.
 //   bool isCompassUnreliable = compassHeading == 0.0;

    // Show a pop-up dialog to the user if the compass sensor is unreliable.
    if (isCompassUnreliable) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Compass Sensor Unreliable'),
              content: const Text( 'Wave your device in a figure of 8 pattern to calibrate the compass.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Qibla App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add a compass-like needle to point to the Qibla direction.
            Transform.rotate(
              angle: compassHeading * (3.14159265359 / 180),
              child: Image.asset('assets/compass_needle.png'),
            ),
            const SizedBox(height: 20),
            Text(
              'Qibla Direction: ${qiblaDirection.toStringAsFixed(2)}°',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
