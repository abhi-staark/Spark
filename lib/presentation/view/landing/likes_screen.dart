import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/likes/likes_events.dart';
import 'package:spark/business_logic/blocs/likes/likes_bloc.dart';
import 'package:spark/business_logic/blocs/likes/likes_states.dart';
import 'package:spark/presentation/common/asset_svg.dart';
import 'package:spark/utils/constants/asset_path.dart';
import 'package:spark/utils/constants/colors.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LikesBloc>().add(LoadLikesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikesBloc, LikeStates>(builder: ((context, state) {
      if (state is LikesInitialState || state is LikesLoadingSate) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is LikesErrorState) {
        return const Center(
          child: Text('Something went wrong'),
        );
      }
      if (state is LikesLoadedState) {
        return Scaffold(
          body: Column(
            children: [
              //yellow container
              Container(
                height: 250,
                color: AppColors.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //texts
                    ClipOval(
                        child: Container(
                            height: 50,
                            width: 50,
                            color: AppColors.whiteColor,
                            child: const Icon(
                              Icons.favorite,
                              color: AppColors.blackColor,
                              size: 20,
                            ))),
                    const SizedBox(
                      height: 10,
                    ),
                    //
                    Text(
                      'Interested in you',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'When someone swipes right on you, you\'ll be able to find them right here',
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),

              //if list is empty suggest compliment
              //it it is fill show who liked the photo


              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AssetSvgWidget(
                        iconPath: AssetPath.sandClockIcon, height: 80, width: 80),
                    const SizedBox(
                      height: 20,
                    ),
                    //title
                    Text(
                      'Get time Savy',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    //tips
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'The best time for you to use Spark is between 7 to 11pm',
                        maxLines: 3,
                        softWrap: true,
                    
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        );
      } else {
        return const Center(
          child: Text('Something went wrong'),
        );
      }
    }));
  }
}
