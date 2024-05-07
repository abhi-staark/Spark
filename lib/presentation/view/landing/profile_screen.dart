import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/profile/profile_bloc.dart';
import 'package:spark/business_logic/blocs/profile/profile_events.dart';
import 'package:spark/business_logic/blocs/profile/profile_states.dart';
import 'package:spark/config/routes/route_names.dart';
import 'package:spark/presentation/common/loader.dart';
import 'package:spark/presentation/view/landing/widgets/circle_image.dart';
import 'package:spark/presentation/view/landing/widgets/edit_button.dart';
import 'package:spark/presentation/view/landing/widgets/plans_container.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return BlocConsumer<ProfileBloc, ProfileStates>(
      listener: (context, state) {
        //only works when a change instate happens not intially
      },
      builder: ((context, state) {
        switch (state.runtimeType) {
          case ProfileInitialState:
            context.read<ProfileBloc>().add(
                LoadUserDetailsDataEvent()); //call loading because it is intial state
            return const LoaderWidget();
          case ProfileLoadingState:
            return const LoaderWidget();
          case ProfileLoadedState:
            return SafeArea(
              child: Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal :15, vertical: 10),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const SizedBox(
                      height: 20,
                    ),
                    //circular photo- name-age
                    Row(
                      children: [
                        const CircularImageWidget(
                          imageUrl:
                              'https://p1.pxfuel.com/preview/959/127/730/vacation-beach-sunset-palm-trees-beautiful-mobile-wallpaper.jpg',
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Smita, 23 🌟',
                                style: textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600)),
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                //navigate to edit profile page
                                Navigator.pushNamed(
                                    context, RouteNames.editProfile);
                              },
                              child: EditButton(textTheme: textTheme),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //premium-boost button
                    (state is ProfileLoadedState)
                        ? SizedBox(
                            height: 180,
                            child: ListView.builder(
                                //physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.premiumList.length,
                                itemBuilder: (context, index) {
                                  var item = state.premiumList[index];
                                  return PlansContainer(
                                      title: item['title'],
                                      description: item['description'],
                                      textTheme: textTheme);
                                }),
                          )
                        : const SizedBox(),
                    
                    const SizedBox(
                      height: 20,
                    ),
                    
                    //header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'What do you get',
                            style: textTheme.bodySmall!.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Premium',
                            style: textTheme.bodySmall!.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '       Boost',
                            style: textTheme.bodySmall!.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    
                    //listview builder
                    state is ProfileLoadedState
                        ? Expanded(
                            child: ListView.builder(
                            //physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.featuesList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var feature = state.featuesList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        feature['feature']
                                            .toString()
                                            .replaceAll('_', ' '),
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        softWrap: true,
                                        style: textTheme.bodySmall!.copyWith(
                                            color: AppColors.blackColor),
                                      ),
                                    ),
                                    Expanded(
                                      child: feature['premium_plan'] == true
                                          ? const Icon(Icons.check,
                                              color: AppColors.blackColor,
                                              size: 20)
                                          : Icon(Icons.check,
                                              color: AppColors.greyColor
                                                  .withOpacity(0.5),
                                              size: 20),
                                    ),
                                    Expanded(
                                      child: feature['boost_plan'] == true
                                          ? const Icon(Icons.check,
                                              color: AppColors.blackColor,
                                              size: 20)
                                          : Icon(Icons.check,
                                              color: AppColors.greyColor
                                                  .withOpacity(0.5),
                                              size: 20),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ))
                        : const SizedBox()
                    ],
                                ),
                  )),
            );
          case ProfileErrorState:
            if (state is ProfileErrorState) {
              return ErrorWidget(state.errorMessage);
            } else {
              return ErrorWidget(AppStrings.somethingWentWrongText);
            }
          default:
            return ErrorWidget('State error in ${state.runtimeType}');
        }
      }),
    );
  }
}
