import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:qibla_app/qibla_model.dart';

class QiblaViewModel extends ChangeNotifier {
  final QiblaModel _model = QiblaModel();

  Position? _userLocation;
  double _qiblaDirection = 0.0;
  double _compassHeading = 0.0;

  Position? get userLocation => _userLocation;
  double get qiblaDirection => _qiblaDirection;
  double get compassHeading => _compassHeading;

  QiblaViewModel() {
    // Start listening for compass updates when the QiblaViewModel is created.
    FlutterCompass.events?.listen(_updateCompassHeading);
  }

  void _updateCompassHeading(CompassEvent event) {
    // Update the _compassHeading with the new compass heading value.
    _compassHeading = event.heading!;
    notifyListeners();
  }

  Future<void> fetchQiblaData() async {
    _userLocation = await _model.getCurrentLocation();
    _qiblaDirection = await _model.getQiblaDirection(_userLocation!);
    notifyListeners();
  }
}
