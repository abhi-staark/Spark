import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_event.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController aboutController= TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            //header text
            Text(
              AppStrings.aboutQ,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    letterSpacing: 1,
                    color: AppColors.blackColor,
                    fontSize: 30,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            //header bio info
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                AppStrings.aboutDescription,
                maxLines: 4,
                softWrap: true,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      letterSpacing: 1,
                      color: AppColors.blackColor,
                    ),
              ),
            ),
         const SizedBox(
              height: 30,
            ),
            //text field contains about info screen
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.greyColor)),
              child: TextField(
                controller: aboutController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'Enter more about you.',
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w400, color: AppColors.greyColor,)
                ),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal)
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        context.read<InterestsBloc>().add(AboutInterestSubmittedEvent(context, aboutController.text.trim()));
        },
        backgroundColor: AppColors.blackColor,
        child: const Icon(
          Icons.navigate_next,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
