import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_bloc.dart';
import 'package:spark/business_logic/blocs/interests/interests_event.dart';
import 'package:spark/business_logic/blocs/interests/interests_state.dart';
import 'package:spark/config/routes/route_names.dart';
import 'package:spark/presentation/view/interests/categories/about.dart';
import 'package:spark/presentation/view/interests/categories/drink.dart';
import 'package:spark/presentation/view/interests/categories/education.dart';
import 'package:spark/presentation/view/interests/categories/fields.dart';
import 'package:spark/presentation/view/interests/categories/political.dart';
import 'package:spark/presentation/view/interests/categories/smoke.dart';
import 'package:spark/presentation/view/interests/categories/star_sign.dart';
import 'package:spark/presentation/view/interests/categories/workout.dart';
import 'package:spark/utils/constants/colors.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InterestsBloc>().add(LoadInterestsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<InterestsBloc, InterestsState>(
          listenWhen: (previous, current) => current!=previous,//not working
          listener: (context, state) {
          debugPrint("state.runtimeType.toString()");
          debugPrint(state.runtimeType.toString());
          debugPrint('------------');
          //final navigation or other states handling here
          if (state is InterestsInitialState) {
            debugPrint(state.runtimeType.toString());
            context.read<InterestsBloc>().add(LoadInterestsEvent());
          }if(state is IntrestsSavedSuccessState){
            Navigator.pushNamed(context, RouteNames.location);
          }
        }, 
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: state.progress,
                backgroundColor: Colors.grey,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.blackColor),
              ),
              //build below screens
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: buildScreen(state),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget buildScreen(InterestsState state) {
    switch (state.runtimeType) {
      case InterestsInitialState:
        return const Scaffold(
          body: Center(
            child: Text('Data Loading'),
          ),
        );
      case FieldsInputState:
        return const FieldsScreen();
      case WorkoutInputState:
        return const WorkoutScreen();
      case StarSignInputState:
        return const StarSignScreen();
      case EducationInputState:
        return const EducationScreen();
      case DrinkInputState:
        return const DrinkScreen();
      case SmokeInputState:
        return const SmokeScreen();
      case PoliticalInputState:
        return const PoliticalScreen();
      case AboutInputState:
        return const AboutScreen();
      case InterestsLoadingState:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: AppColors.blackColor,
            ),
          ),
        );
      default:
        return const Center(
          child: Text('Something went wrong'),
        );
    }
  }
}
