import 'package:geolocator/geolocator.dart';
import 'package:intl_phone_field/countries.dart';

abstract class BaseAppServices{
  //location service
  Future<Position?> getCurrentLocation();

  //notification service

  bool isValidNumber(String phoneNumber, String number);
  Country? getCountry(String phoneNumber);
  Future<void> pickImageFromGallery();
  String calculateAge(String birthDateStr);
}