import 'package:flutter/material.dart';

abstract class BasePermissionService {
  Future requestPhotosPermission();

  Future<bool> handlePhotosPermission(BuildContext context);

  Future requestCameraPermission();

  Future<bool> requestStoragePermission(BuildContext context);

  void showPermissionAlert(BuildContext context,String title, String message);

}