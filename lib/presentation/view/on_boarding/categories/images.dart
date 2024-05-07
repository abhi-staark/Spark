import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_bloc.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_event.dart';
import 'package:spark/business_logic/blocs/onboard/onboard_state.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class PickImagesScreen extends StatelessWidget {
  const PickImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              AppStrings.onBoardingPhotos1,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    letterSpacing: 2,
                    color: AppColors.blackColor,
                    fontSize: 30,
                  ),
            ),
            Text(
              AppStrings.onBoardingpPhotos2,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    letterSpacing: 1,
                    color: AppColors.blackColor,
                    fontSize: 30,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppStrings.onBoardingPhotos3,
              maxLines: 4,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.blackColor.withOpacity(0.8),
                  letterSpacing: 0.11),
            ),
            const SizedBox(
              height: 20,
            ),

            //
           BlocBuilder<OnboardingBloc, OnboardingState>(builder: (context, state){
            if(state is ImagesInputState){
              return  SizedBox(
              height: 400,
              child: GridView.builder(
              itemCount: state.imageFiles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                     context.read<OnboardingBloc>().add(AddImageEvent(context, index));
                  },
                  child: ImageUploadContainer(file: state.imageFiles[index]));
              },
            )
            );
            }
            return const SizedBox();
           })
          ],
        ),
        //floating action button
        BlocBuilder<OnboardingBloc, OnboardingState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: AppColors.blackColor,
                onPressed: state is OnboardingLoadingState
                    ? () {}
                    : () {
                        // Dispatch event to Bloc
                        context.read<OnboardingBloc>().add(ImagesSubmittedEvent(context));
                      },
                child: state is OnboardingLoadingState
                    ? const CircularProgressIndicator(
                        color: AppColors.whiteColor,
                      )
                    : const Icon(
                        Icons.navigate_next,
                        color: AppColors.whiteColor,
                      ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class ImageUploadContainer extends StatelessWidget {
  final XFile? file;

  const ImageUploadContainer({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: file != null
          ? Image.file(
              File(file!.path),
              fit: BoxFit.cover,
            )
          : const Center(
              child: Icon(
                Icons.add,
                size: 40.0,
                color: Colors.grey,
              ),
            ),
    );
  }
}