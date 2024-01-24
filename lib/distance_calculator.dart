import 'dart:math';

  class GeoUtils {
  static const double earthRadius = 6371000; // Earth radius in meters

  static double degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  static double calculateDistance(
      double startLatitude,
      double startLongitude,
      double endLatitude,
      double endLongitude,
      ) {
    double dLat = degreesToRadians(endLatitude - startLatitude);
    double dLon = degreesToRadians(endLongitude - startLongitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degreesToRadians(startLatitude)) *
            cos(degreesToRadians(endLatitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }
}

