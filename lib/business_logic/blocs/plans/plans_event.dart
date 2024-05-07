abstract class PlanEvents {}

class FetchPlanDataEvent extends PlanEvents {
  String planType;
  FetchPlanDataEvent({required this.planType});
}

class UpdateSelectionIndexEvent extends PlanEvents{
  int index;
  List<dynamic> plans;
  UpdateSelectionIndexEvent(this.index, this.plans);

}

class ContinueToPayEvent extends PlanEvents {
  int index;
  List<dynamic> plans;
  ContinueToPayEvent(this.index, this.plans);
}
