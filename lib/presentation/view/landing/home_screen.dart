import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:spark/business_logic/blocs/home/home_bloc.dart';
import 'package:spark/business_logic/blocs/home/home_event.dart';
import 'package:spark/business_logic/blocs/home/home_state.dart';
import 'package:spark/business_logic/models/user.dart';
import 'package:spark/presentation/view/landing/widgets/action_button.dart';
import 'package:spark/utils/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadMatchesEvent());
  }

  bool onSwipe(User user, CardSwiperDirection direction) {
    switch (direction.name) {
      case 'left':
        context.read<HomeBloc>().add(LeftSwipeEvent(user: user));
      case 'right':
        context.read<HomeBloc>().add(RightSwipeEvent(user: user));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {
        debugPrint("${state.runtimeType}");
        if (state is HomeInitialState) {
          context.read<HomeBloc>().add(LoadMatchesEvent());
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeInitialState:
          case HomeLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case HomeErrorState:
            return const Center(
              child: Text('Something went wrong, try again'),
            );
          case HomeLoadedState:
            if (state is HomeLoadedState) {
              return SafeArea(
                child: Scaffold(
                  body: CardSwiper(
                      padding: EdgeInsets.zero,
                      onSwipe: (previousIndex, currentIndex, direction) =>
                          onSwipe(state.matchesList[previousIndex], direction),
                      allowedSwipeDirection: const AllowedSwipeDirection.only(
                          left: true, right: true,),
                      isLoop: false,
                      onEnd: () =>
                          context.read<HomeBloc>().add(ReachedEndOfListEvent()),
                      cardsCount: state.matchesList.length,
                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      image: DecorationImage(
                                        image: NetworkImage(state
                                            .matchesList[index].profilePicUrl),
                                        fit: BoxFit.cover,
                                        onError: (exception, stackTrace) {
                                          debugPrint(
                                              "Exception showing imagwe: $exception");
                                        },
                                      ),
                                    ),
                                    //name age and place
                                    child: SizedBox(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.matchesList[index].userName,
                                              style: textTheme.displayMedium!
                                                  .copyWith(
                                                      color:
                                                          AppColors.whiteColor),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              state.matchesList[index].age,
                                              style: textTheme.displaySmall!
                                                  .copyWith(
                                                      color:
                                                          AppColors.whiteColor),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              state.matchesList[index].locality,
                                              style: textTheme.bodySmall!
                                                  .copyWith(
                                                      color:
                                                          AppColors.whiteColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              //more info and profile
                              Container(
                                height: 1200,
                                color: AppColors.primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'About Me',
                                        style: textTheme.bodyLarge!.copyWith(
                                            color: AppColors.greyColor),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      //about info
                                      Text(
                                        state.matchesList[index].aboutUser,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: textTheme.bodyLarge!.copyWith(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'My Basics',
                                        style: textTheme.bodyLarge!.copyWith(
                                            color: AppColors.greyColor),
                                      ),
                                      SizedBox(
                                        height: 120,
                                        child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(), //make it not scrollable
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 2),
                                          itemCount: state
                                              .matchesList[index].basics.length,
                                          itemBuilder: (context, basicsIndex) =>
                                              buildBasicItem(state
                                                  .matchesList[index]
                                                  .basics[basicsIndex]),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      //my interests
                                      Text(
                                        'My Interests',
                                        style: textTheme.bodyLarge!.copyWith(
                                            color: AppColors.greyColor),
                                      ),
                                      SizedBox(
                                        height: 120,
                                        child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(), //make it not scrollable
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 2),
                                          itemCount: state.matchesList[index]
                                              .interests.length,
                                          itemBuilder: (context,
                                                  interestsIndex) =>
                                              buildBasicItem(state
                                                  .matchesList[index]
                                                  .interests[interestsIndex]),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),
                                      //other photos
                                      SizedBox(
                                        height: 400,
                                        child: ListView.builder(
                                            itemCount: state.matchesList[index]
                                                .moreImages.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder:
                                                (context, moreImageIndex) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                  state.matchesList[index]
                                                          .moreImages[
                                                      moreImageIndex],
                                                  fit: BoxFit.contain,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(Icons
                                                        .error_outline_outlined);
                                                  },
                                                ),
                                              );
                                            }),
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      //location
                                      Text(
                                        '📍 My Location',
                                        style: textTheme.bodyLarge!.copyWith(
                                            color: AppColors.greyColor),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${state.matchesList[index].subLocality},  ${state.matchesList[index].locality}',
                                        style: textTheme.titleMedium!.copyWith(
                                            color: AppColors.greyColor),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                //events
                                              },
                                              child: const ActionButton(
                                                height: 60,
                                                icon: Icons.close,
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                              onTap: () {},
                                              child: const ActionButton(
                                                height: 60,
                                                icon: Icons.check,
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: InkWell(
                                            onTap: () {
                                              //super swipe
                                            },
                                            child: const ActionButton(
                                              height: 70,
                                              icon: Icons.star,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              );
            } else {
              return Center(
                child: Text('State error in ${state.runtimeType}'),
              );
            }
        }
        return Center(
          child: Text('State error in ${state.runtimeType}'),
        );
      },
    );
  }
}

Widget buildBasicItem(String value) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          value,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    ),
  );
}
