import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spark/business_logic/blocs/landing/landing_bloc.dart';
import 'package:spark/business_logic/blocs/landing/landing_event.dart';
import 'package:spark/business_logic/blocs/landing/landing_state.dart';
import 'package:spark/presentation/view/landing/chat_screen.dart';
import 'package:spark/presentation/view/landing/home_screen.dart';
import 'package:spark/presentation/view/landing/likes_screen.dart';
import 'package:spark/presentation/view/landing/profile_screen.dart';
import 'package:spark/utils/constants/asset_path.dart';
import 'package:spark/utils/constants/colors.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LandingBloc, LandingStates>(
        builder: (context, state) {
          return IndexedStack(
            index: state.currentIndex,
            children: const [
              ProfileScreen(),
              //SubscriptionScreen(),
              HomeScreen(),
              LikesScreen(),
              ChatScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<LandingBloc, LandingStates>(
        builder: (context, state) {
          if (state is LandingLoadedState) {
            return BottomNavigationBar(
              iconSize: 40.0,
              type: BottomNavigationBarType.shifting,
              currentIndex: state.currentIndex,
              selectedItemColor: AppColors.blackColor,
              unselectedItemColor: AppColors.greyColor,
              elevation: 0,
              onTap: (index) {
                context
                    .read<LandingBloc>()
                    .add(UpdateBottomNavItemEventItem(index));
              },
              items: [
                buildBottomNavigationBarItem(
                  iconPath: AssetPath.profileIcon,
                  tooltip: 'Profile',
                  active: state.currentIndex == 0,
                ),
                // buildBottomNavigationBarItem(
                //   iconPath: AssetPath.walletIcon,
                //   tooltip: 'Subscription',
                //   active: state.currentIndex == 1,
                // ),
                buildBottomNavigationBarItem(
                  iconPath: AssetPath.homeIcon,
                  tooltip: 'Home',
                  active: state.currentIndex == 2,
                ),
                buildBottomNavigationBarItem(
                  iconPath: AssetPath.likeIcon,
                  tooltip: 'Likes',
                  active: state.currentIndex == 3,
                ),
                buildBottomNavigationBarItem(
                  iconPath: AssetPath.chatIcon,
                  tooltip: 'Chats',
                  active: state.currentIndex == 4,
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

}

BottomNavigationBarItem buildBottomNavigationBarItem({
  required String iconPath,
  required String tooltip,
  required bool active,
}) {
  return BottomNavigationBarItem(
    icon: SizedBox(
      height: 30,
      width: 30,
      child: SvgPicture.asset(
        iconPath,
        color: active?AppColors.blackColor: AppColors.greyColor,
        fit: BoxFit.contain,
      ),
    ),
    label: '',
    tooltip: tooltip,
  );
}
