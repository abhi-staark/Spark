
import 'package:flutter/material.dart';
import 'package:spark/utils/constants/colors.dart';

class CircularImageWidget extends StatelessWidget {
  const CircularImageWidget({
    super.key,
    required this.imageUrl
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: Container(
            height: 73,
            width: 73,
            color: AppColors.greyColor,
          ),
        ),
        Positioned(
          top: 3,
          bottom: 3,
          left: 3,
          right: 3,
          child: ClipOval(
            child: SizedBox(
              height: 70,
              width: 70,
              child: Image.network(
               imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint(
                      "Error while showing image:$error ");
                  return const Icon(
                      Icons.error_outline_outlined);
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
