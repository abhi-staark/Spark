import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spark/business_logic/blocs/location/location_event.dart';
import 'package:spark/business_logic/blocs/location/location_state.dart';
import 'package:spark/services/app_services.dart';

class LocationBloc extends Bloc<LocationEvents, LocationState> {
  LocationBloc() : super(LocationInitialState()) {
    on<PickLocationEvent>((event, emit) => pickLocationEvent(event, emit));
    on<DialogBoxAgreedEvent>(
        (event, emit) => dialogBoxAgreedEvent(event, emit));
  }
  pickLocationEvent(
      PickLocationEvent event, Emitter<LocationState> emit) async {
    AppServices appServices = AppServices();
    try {
      Position? currentPosition = await appServices.getCurrentLocation();
      if (currentPosition != null) {
        debugPrint("${currentPosition.latitude}, ${currentPosition.longitude}");
        List<Placemark> placemarks = await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude);
        //String place = placemarks[0].toString();
        //debugPrint("place $place");
        if (placemarks.isNotEmpty) {
          Placemark firstPlacemark = placemarks[0];

          String locality = firstPlacemark.locality ??
              ''; // If locality is null, assign an empty string
          String sublocality = firstPlacemark.subLocality ??
              ''; // If sublocality is null, assign an empty string

          debugPrint('Locality: $locality');
          debugPrint('Sublocality: $sublocality');
          emit(LocationPickedSuccessState(
              currentPosition, locality, sublocality));
        } else {
          //current position null
          emit(LocationPickedFailureState("Failed to detect corrent position"));
        }
      } else {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.deniedForever) {
          emit(LocationPermissionPermanentlyDeniedState());
        } else {
          emit(LocationPermissionDeniedState());
        }
      }
    } catch (error) {
      emit(LocationPickedFailureState(error.toString()));
    }
  }

  dialogBoxAgreedEvent(
      DialogBoxAgreedEvent event, Emitter<LocationState> emit) {
    emit(LocationInitialState());
  }
}
