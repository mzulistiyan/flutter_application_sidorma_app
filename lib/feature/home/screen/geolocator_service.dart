import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  final Geolocator geo = Geolocator();

  Stream<Position> getCurrentLocation() {
    var locationOptions = const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 10);
    return Geolocator.getPositionStream(locationSettings: locationOptions);
  }

  Future<Position> getInitialLocation() async {
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
}
