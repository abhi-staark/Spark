
import 'package:flutter/material.dart';

class PlansRepo {
  Future<List<dynamic>> fetchPlanDataApi(String planType) async {
    List<Map<String, String>> premiumPlans = [
      {
        "duration": "1 Week",
        "price": "20",
      },
      {
        "duration": "2 Weeks",
        "price": "40",
      },
      {
        "duration": "1 Month",
        "price": "100",
      },
      {
        "duration": "2 Month",
        "price": "190",
      },
    ];

    List<Map<String, String>> boostPlans = [
      {
        "duration": "1 Week",
        "price": "20",
      },
      {
        "duration": "2 Weeks",
        "price": "40",
      },
      {
        "duration": "1 Month",
        "price": "100",
      },
      {
        "duration": "2 Month",
        "price": "190",
      },
    ];
    try {
      Future.delayed(const Duration(seconds: 3));
      if (planType == 'Premium') {
        return premiumPlans;
      } else {
        return boostPlans;
      }
    } catch (e) {
      debugPrint("Error: $e");
      rethrow;
      ///throw SocketException(e.toString());
    }
  }
}
