import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;
import 'package:flutter_compass/flutter_compass.dart';

class QiblaModel {
  Future<Position> getCurrentLocation() async {
    // Check if location permissions are granted. If not, request them.
    if (await Permission.location.isGranted) {
      if (kDebugMode) {
        print("permission is granted");
      }
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } else {
      var status = await Permission.location.request();
      if (status.isGranted) {
        return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      } else {
        throw Exception("Location permissions are required to use the app.");
      }
    }
  }

  Future<double> getQiblaDirection(Position userLocation) async {
    // Coordinates of Mecca (latitude and longitude in degrees)
    const double meccaLatitude = 21.4225;
    const double meccaLongitude = 39.8262;
    // Convert latitude and longitude from degrees to radians
    final double userLatitudeRad = userLocation.latitude * math.pi / 180.0;
    final double userLongitudeRad = userLocation.longitude * math.pi / 180.0;
    const double meccaLatitudeRad = meccaLatitude * math.pi / 180.0;
    const double meccaLongitudeRad = meccaLongitude * math.pi / 180.0;
    // Calculate the Qibla direction using the haversine formula
    final double deltaLongitude = meccaLongitudeRad - userLongitudeRad;
    final double y = math.sin(deltaLongitude);
    final double x = math.cos(userLatitudeRad) * math.tan(meccaLatitudeRad) -
        math.sin(userLatitudeRad) * math.cos(deltaLongitude);
    double qiblaDirectionRad = math.atan2(y, x);

    // Convert the Qibla direction from radians to degrees
    double qiblaDirectionDegrees = qiblaDirectionRad * 180.0 / math.pi;
    // Adjust the Qibla direction to be between 0 and 360 degrees
    if (qiblaDirectionDegrees < 0) {
      qiblaDirectionDegrees += 360.0;
    }
    // This calculation will depend on the formula or method you choose to use.
    // For simplicity, I'll assume you have the calculation logic in place.
    return qiblaDirectionDegrees;
  }
}
