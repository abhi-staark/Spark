
import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
     required this.errorMsg
  });
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(errorMsg),
    );
  }
}