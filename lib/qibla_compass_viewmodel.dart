import 'package:flutter/foundation.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';

enum QiblaCompassStatus {
  loading,
  locationDenied,
  locationDeniedForever,
  locationServiceDisabled,
  locationServiceEnabled,
  unknownError,
}

class QiblaCompassViewModel extends ChangeNotifier {
  QiblaCompassStatus _status = QiblaCompassStatus.loading;
  QiblaCompassStatus get status => _status;

  QiblahDirection? _qiblahDirection;
  QiblahDirection? get qiblahDirection => _qiblahDirection;

  void fetchQiblahDirection() async {
    _status = QiblaCompassStatus.loading;
    notifyListeners();

    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled && locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _status = s.enabled ? QiblaCompassStatus.locationServiceEnabled : QiblaCompassStatus.locationDenied;
    } else {
      _status = locationStatus.enabled ? QiblaCompassStatus.locationServiceEnabled : QiblaCompassStatus.locationServiceDisabled;
    }

    if (_status == QiblaCompassStatus.locationServiceEnabled) {
      final qiblahDirection = await FlutterQiblah.qiblahStream.first;
      _qiblahDirection = qiblahDirection;
    }
    notifyListeners();
  }

  void checkLocationPermissionStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled && locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _status = s.enabled ? QiblaCompassStatus.locationServiceEnabled : QiblaCompassStatus.locationDenied;
    } else {
      _status = locationStatus.enabled ? QiblaCompassStatus.locationServiceEnabled : QiblaCompassStatus.locationServiceDisabled;
    }

    notifyListeners();
  }
}
