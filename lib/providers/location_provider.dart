import 'package:flutter/foundation.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:location/location.dart';

class UserLocation {
  final String? address;
  final String? city;
  final String? country;

  UserLocation({this.address, this.city, this.country});
}

class LocationProvider with ChangeNotifier {
  double? _longitude;
  double? _latitude;
  double? get longitude => _longitude;
  UserLocation? _userLocation;
  UserLocation? get userLocation => _userLocation;
  double? get latitude => _latitude;
  LocationData? _locationData;
  LocationData? get locationData {
    return _locationData;
  }

  Future<void> getCurrentLocation() async {
    //using location package
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    //GETTING CURRENT LOCATION OF USER

    _locationData = await location.getLocation();

    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: _locationData!.latitude!,
        longitude: _locationData!.longitude!,
        googleMapApiKey: "AIzaSyDIL1xyrMndlk2dSSSSikdobR8qDjz0jjQ");

    _userLocation = UserLocation(
      address: data.address,
      city: data.state,
      country: data.country,
    );

    notifyListeners();
  }

  void propertyLocation(double longitude, double latitude) {
    _longitude = longitude;
    _latitude = latitude;

    notifyListeners();
  }

  void clearLocation() {
    _longitude = null;
    _latitude = null;
    notifyListeners();
  }
}
