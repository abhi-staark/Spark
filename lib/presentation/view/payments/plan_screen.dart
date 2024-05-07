import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/plans/plans_bloc.dart';
import 'package:spark/business_logic/blocs/plans/plans_event.dart';
import 'package:spark/business_logic/blocs/plans/plans_state.dart';
import 'package:spark/presentation/common/appbar.dart';
import 'package:spark/presentation/common/primary_button.dart';
import 'package:spark/presentation/view/payments/plans_container.dart';
import 'package:spark/presentation/view/payments/widgets/success_animation.dart';
import 'package:spark/utils/constants/colors.dart';
import 'package:spark/utils/constants/strings.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key, required this.planType});
  final String planType;

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlanBloc>().add(FetchPlanDataEvent(planType: widget.planType));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            backgroundColor: AppColors.primaryColor, title: widget.planType),
        backgroundColor: AppColors.primaryColor,
        body: BlocConsumer<PlanBloc, PlanState>(
          listener: (context, state) {
            if (state is PlanPaymentSucessState) {
              showDialog(
                context: context,
                builder: (context) => const PaymentSuccessAnimation(),
              );
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case PlanInitialState:
              case PlanLoadingState:
                return const Center(child: CircularProgressIndicator());
              case PlanErrorState:
                return Center(
                    child: state is PlanErrorState
                        ? Text(state.errorMessage)
                        : const Text('Something went wrong'));
              case PlanPaymentSucessState:
                return Center(
                  child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          
                          builder: (context) => const PaymentSuccessAnimation(),
                        );
                      },
                      child: const Text('Payment success')),
                );
              case PlanLoadedState:
                //need to check here
                if (state is PlanLoadedState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.plans.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          context.read<PlanBloc>().add(
                                              UpdateSelectionIndexEvent(
                                                  index, state.plans));
                                        },
                                        child: PlansContainerWidget(
                                          planDuration: state.plans[index]
                                              ['duration'],
                                          planPrice: state.plans[index]
                                              ['price'],
                                          isSelected:
                                              index == state.selectedIndex,
                                        ),
                                      );
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                AppStrings.planDisclaimer,
                                maxLines: 2,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.greyColor),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: () async {
                                context.read<PlanBloc>().add(ContinueToPayEvent(
                                    state.selectedIndex, state.plans));
                              },
                              child: PrimaryButton(
                                  buttonHeight: 50,
                                  buttonWidth: 320,
                                  buttonString:
                                      'Get ${state.plans[state.selectedIndex]['duration']} for ${state.plans[state.selectedIndex]['price']} INR',
                                  buttonColor: AppColors.blackColor,
                                  textColor: AppColors.whiteColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              default:
                return const SizedBox();
            }
          },
        ));
  }
}
