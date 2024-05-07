import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentRepo {
  Map<String, dynamic>? paymentIntentData;
  Future makePayment(String amount) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, 'INR');
      debugPrint("parendata: ${paymentIntentData!['client_secret']}");

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
        // Set to true for custom flow
        customFlow: false,
        // Main params
        merchantDisplayName: 'Flutter Stripe Store Demo',
        paymentIntentClientSecret: paymentIntentData!['client_secret'],

        // Customer keys
        //customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        //customerId: paymentIntentData!['customer'],
        // Extra options
        // applePay: const PaymentSheetApplePay(
        //   merchantCountryCode: 'US',
        // ),
        googlePay: const PaymentSheetGooglePay(
          merchantCountryCode: 'IN',
          testEnv: true,
        ),
        style: ThemeMode.system,
      ))
          .then((value) async {
        await displayPaymentSheet();
        debugPrint("paid successfully: $value");
      }).onError((error, stackTrace) {
        debugPrint("Error makePayment: $error");
      });
    } catch (error) {
      paymentIntentData = null;
      debugPrint("Error makePayment: $error");
      rethrow;
    }
  }

  Future createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": calculateAmount(amount).toString(),
        "currency": currency,
       // "payment_method": card,
        //"payment_method_types": ["card"],

      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            "Authorization": "Bearer ${dotenv.env['secretKey']}",
            "Contnt-Type": "application/x-www-form-urlencoded"
          });

      debugPrint("status code: ${response.statusCode}");
      debugPrint("response body: ${response.body}");

      return jsonDecode(response.body.toString());
    } catch (error) {
      debugPrint("Error createPaymentIntent: $error");
      rethrow;
    }
  }

  calculateAmount(String amount) {
    final price = int.parse(amount)*100;
    return price;
  }

  Future displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async{
        paymentIntentData = null;
        debugPrint("paid succssfully");
        debugPrint("paid value $value");

        Stripe.instance.confirmPaymentSheetPayment();
      }).onError((error, stackTrace) {
        debugPrint("Error makePayment: $error");
      });
    } on StripeException catch (error) {
      debugPrint("strike exception $error");
    }
  }
}
