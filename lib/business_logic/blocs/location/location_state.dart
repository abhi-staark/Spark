import 'package:geolocator/geolocator.dart';

abstract class LocationState{}

class LocationInitialState extends LocationState{}

class LocationPickedSuccessState extends LocationState{
  Position? currentPosition;
  String locality;
  String subLocality;
  LocationPickedSuccessState(this.currentPosition, this.locality, this.subLocality);
}

class LocationPermissionDeniedState extends LocationState{}

class LocationPermissionPermanentlyDeniedState extends LocationState{}

class LocationPickedFailureState extends LocationState{
  String errorMessage;
  LocationPickedFailureState(this.errorMessage);

}