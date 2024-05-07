import 'package:flutter/material.dart';
import 'package:spark/config/routes/route_names.dart';
import 'package:spark/presentation/view/authenticate/otp_screen.dart';
import 'package:spark/presentation/view/authenticate/phone_num_screen.dart';
import 'package:spark/presentation/view/disclaimer/disclaimer_screen.dart';
import 'package:spark/presentation/view/disclaimer/guidelines_screen.dart';
import 'package:spark/presentation/view/authenticate/login_screen.dart';
import 'package:spark/presentation/view/interests/interests_screen.dart';
import 'package:spark/presentation/view/landing/edit_profile_screen.dart';
import 'package:spark/presentation/view/landing/landing_screen.dart';
import 'package:spark/presentation/view/location/location_screen.dart';
import 'package:spark/presentation/view/on_boarding/on_boarding_screen.dart';
import 'package:spark/presentation/view/payments/plan_screen.dart';
import 'package:spark/presentation/view/splash/splash_screen.dart';

class AppRoutes {
  static Route<dynamic> ongenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      // case RouteNames.home:
      //   return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.phone:
        return MaterialPageRoute(builder: (_) => const PhoneNumberScreen());
      case RouteNames.otp:
        final args = settings.arguments.toString();
        return MaterialPageRoute(builder: (_) => OtpScreen(phoneNumber: args));
      case RouteNames.onBoarding:
        return MaterialPageRoute(builder: (_)=> const OnBoardingScreen());
      case RouteNames.interests:
        return MaterialPageRoute(builder: (_)=> const InterestsScreen());
      case RouteNames.location:
        return MaterialPageRoute(builder: (_)=>const LocationScreen());
      case RouteNames.disclaimer:
        return MaterialPageRoute(builder: (_)=> const DisclaimerScreen());
      case RouteNames.guidelines:
        return MaterialPageRoute(builder: (_)=> const GuideLinesScreen());
      case RouteNames.landing:
        return MaterialPageRoute(builder: (_)=> const LandingScreen());
      case RouteNames.editProfile:
        return MaterialPageRoute(builder: (_)=> const EditProfileScreen());
      case RouteNames.plans:
        final String planType= settings.arguments.toString();
        return MaterialPageRoute(builder: (_)=> PlansScreen( planType: planType,));
      // case RouteNames.payment:
      //   return MaterialPageRoute(builder: (_)=> const PaymentScreen());
      
      default:
        return MaterialPageRoute(
            builder: (_) => DefaultScreen(
                  routName: settings.name.toString(),
                ));
    }
  }
}

//In any other cases of route errors, the page is navigated to this screen showing error
class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key, required this.routName});
  final String routName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('No route found for $routName'),
      ),
    );
  }
}
