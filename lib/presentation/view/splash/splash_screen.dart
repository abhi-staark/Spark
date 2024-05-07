import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/splash/splash_bloc.dart';
import 'package:spark/business_logic/blocs/splash/splash_events.dart';
import 'package:spark/business_logic/blocs/splash/splash_state.dart';
import 'package:spark/presentation/common/asset_image.dart';
import 'package:spark/config/routes/route_names.dart';
import 'package:spark/utils/constants/asset_path.dart';
import 'package:spark/utils/constants/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(AppStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.isSignedin) {
            Navigator.popAndPushNamed(context, RouteNames.landing);
          } else {
            Navigator.popAndPushNamed(context, RouteNames.login);
          }
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AssetImageWidget(
                imagePath: AssetPath.applogo,
                height: 50,
                width: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
