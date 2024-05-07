import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spark/business_logic/blocs/location/location_bloc.dart';
import 'package:spark/business_logic/blocs/location/location_event.dart';
import 'package:spark/business_logic/blocs/location/location_state.dart';
import 'package:spark/config/routes/route_names.dart';
import 'package:spark/presentation/common/primary_button.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: BlocConsumer<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state is LocationPermissionDeniedState) {
              _showLocationPermissionDialog(context);
            }
            if (state is LocationPermissionPermanentlyDeniedState) {
              _showLocationSettingsDialog(context);
            }if(state is LocationPickedSuccessState){
              //make api call event and and store the data in local if needed
              Navigator.pushNamed(context, RouteNames.disclaimer);
            }
          },
          builder: (context, state) {
            if (state is LocationInitialState) {
              return _buildInitialLocationWidget(context);
            } else if (state is LocationPickedSuccessState) {
              return _buildLocationSuccessWidget(state.subLocality);
            } else if (state is LocationPickedFailureState) {
              return _buildLocationFailureWidget();
            } else {
              return _buildErrorWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildInitialLocationWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 60,
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.locationQ,
          maxLines: 2,
          softWrap: true,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.locationInfo,
          maxLines: 3,
          softWrap: true,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.greyColor,
              ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () async {
            context.read<LocationBloc>().add(PickLocationEvent());
          },
          child: const PrimaryButton(
            buttonHeight: 50,
            buttonWidth: 220,
            buttonString: 'Get Location',
            buttonColor: AppColors.primaryColor,
            textColor: AppColors.blackColor,
          ),
        ),
      ],
    );
  }

  void _showLocationPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text("Location Permission Required", style: Theme.of(context).textTheme.bodyLarge,),
          content:  Text("Please grant location permission to continue.",  style: Theme.of(context).textTheme.bodySmall,),
          actions: <Widget>[
            TextButton(
              child:  Text("OK",  style: Theme.of(context).textTheme.bodySmall,),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<LocationBloc>().add(DialogBoxAgreedEvent());
              },
            ),
          ],
        );
      },
    );
  }

  void _showLocationSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text("Location Permission Denied",  style: Theme.of(context).textTheme.bodyLarge,),
          content: Text("Please enable location permissions in app settings to continue.",  style: Theme.of(context).textTheme.bodySmall,),
          actions: <Widget>[
            TextButton(
              child:  Text("OK",  style: Theme.of(context).textTheme.bodySmall,),
              onPressed: () async {
                await Geolocator.openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildLocationSuccessWidget(String subLocality) {
    return Center(
      child: Text(subLocality),
    );
  }

  Widget _buildLocationFailureWidget() {
    return const Center(
      child: Text('Could not find location, try again later.'),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Text('Something went wrong'),
    );
  }
}
