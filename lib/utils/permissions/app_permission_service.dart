import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spark/utils/permissions/base_permission_service.dart';

class ApplicationPermissions extends BasePermissionService{
  @override
  Future<bool> requestStoragePermission(BuildContext context) async{
    var storageStatus = await Permission.storage.request();
    if (storageStatus.isGranted) {
      // Storage permission granted, proceed with your logic
      return true;
    } else if (storageStatus.isPermanentlyDenied) {
      // Storage permission permanently denied, user need to open app settings and provide permissions manually
      // showPermissionAlert(
      //     context,'permissionRequiredText', 'cameraPermissionRequiredText');
          return false;
    } else {
      // You can handle other permission status cases if needed
      return false;
    }
  }

  @override
  Future<bool> handlePhotosPermission(BuildContext context) {
    // TODO: implement handlePhotosPermission
    throw UnimplementedError();
  }

  @override
  Future requestCameraPermission() {
    // TODO: implement requestCameraPermission
    throw UnimplementedError();
  }

  @override
  Future requestPhotosPermission() {
    // TODO: implement requestPhotosPermission
    throw UnimplementedError();
  }



  
     @override
    void showPermissionAlert(BuildContext context,String title, String message) {
    final TextTheme textTheme=Theme.of(context).textTheme;
      AlertDialog(
        title: Text(title, style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),),
        content: Text(message,  style: textTheme.bodyMedium!.copyWith()),
        actions: [
          TextButton(
            onPressed: () async {
              
              await openAppSettings();
              Navigator.pop(context);
             
            },
            child:  Text('OK',  style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),),
          ),
        ],
    );
  }

}