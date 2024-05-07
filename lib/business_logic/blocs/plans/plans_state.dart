abstract class PlanState {}

class PlanInitialState extends PlanState {}

class PlanLoadingState extends PlanState {}

class PlanErrorState extends PlanState {
  String errorMessage;
  PlanErrorState(this.errorMessage);

}

class PlanLoadedState extends PlanState {
  List plans;
  int selectedIndex;
  PlanLoadedState({required this.plans, this.selectedIndex=0});
}

class PlanLoadingErrorState extends PlanState {
  String errorMessage;
  PlanLoadingErrorState(this.errorMessage);
}

class PlanPaymentSucessState extends PlanState{}

class PlanPaymentFailureState extends PlanState{}