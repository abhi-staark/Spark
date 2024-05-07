import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:spark/services/base_services.dart';

class AppServices extends BaseAppServices {
  @override
  Future<Position?> getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      // Location services are not enabled, show dialog to enable them
      // This could be a dialog or a snackbar prompting the user to enable location services
      debugPrint("Location services are disabled.");
      // Show dialog or snackbar to inform the user to enable location services
      //return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, request permissions
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, show dialog or snackbar explaining why location permissions are necessary
        // This could be a dialog or a snackbar explaining why location permissions are necessary
        debugPrint("Location permissions are denied.");
        // Show dialog or snackbar to explain why location permissions are necessary
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      // This could be a dialog informing the user that location permissions are required and directing them to app settings
      debugPrint("Location permissions are denied forever.");
      // Show dialog informing the user that location permissions are required and direct them to app settings
      await Geolocator.openAppSettings();
      return null;
    }

    // When we reach here, permissions are granted and we can continue accessing the position of the device
    return await Geolocator.getCurrentPosition();
  }

  @override
  bool isValidNumber(String phoneNumber, String number) {
    Country? country = getCountry(phoneNumber);
    if (country == null) {
      return false;
    }

    if (number.length < country.minLength) {
      return false;
    }

    if (number.length > country.maxLength) {
      return false;
    }

    return true;
  }

  @override
  Country? getCountry(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return null;
    }

    final validPhoneNumber = RegExp(r'^[+0-9]*[0-9]*$');

    if (!validPhoneNumber.hasMatch(phoneNumber)) {
      return null;
    }

    // Remove any non-digit characters from the phone number
    final phoneNumberDigitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Iterate over countries to find a match
    for (var country in countries) {
      // Check if the phone number starts with the country code (dialCode)
      if (phoneNumberDigitsOnly.startsWith(country.dialCode)) {
        return country;
      }
    }

    return null; // No country found for the given phone number
  }

  @override
  Future<XFile?> pickImageFromGallery() async {
    final picker = ImagePicker();
    XFile? imageFile;
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFile = pickedFile;
      }
    } catch (error) {
      //throw error
      return imageFile;
    }
    return imageFile;
  }

  @override
  String calculateAge(String birthDateStr) {
    int birthYear = int.parse(birthDateStr.substring(4));
    int currentYear = DateTime.now().year;
    return (currentYear - birthYear).toString();
  }
}
