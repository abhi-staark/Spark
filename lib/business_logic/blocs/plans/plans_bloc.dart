import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spark/business_logic/blocs/plans/plans_event.dart';
import 'package:spark/business_logic/blocs/plans/plans_state.dart';
import 'package:spark/business_logic/repositories/payment_repo.dart';
import 'package:spark/business_logic/repositories/plans_repo.dart';

class PlanBloc extends Bloc<PlanEvents, PlanState>{
  PlanBloc(): super(PlanInitialState()){
    on<FetchPlanDataEvent>((event, emit) => fetchPlanDataEvent(event, emit));
    on<UpdateSelectionIndexEvent>((event, emit) => updateSelectionIndexEvent(event, emit));
    on<ContinueToPayEvent>((event, emit) => selectedPlanEvent(event, emit),);
  }
  
  fetchPlanDataEvent(FetchPlanDataEvent event, Emitter<PlanState> emit) async{
    //emit loading
    emit(PlanLoadingState());
    //repo api call and get a listof plans data
    //emit loaded or faliure along with it
   try{
     PlansRepo plansRepo= PlansRepo();
    emit(PlanLoadedState(plans: await plansRepo.fetchPlanDataApi(event.planType)));
   }catch(error){
    PlanLoadingErrorState(error.toString());
   }
  }

  //update index
  updateSelectionIndexEvent(UpdateSelectionIndexEvent event, Emitter<PlanState> emit){
    emit(PlanLoadedState(plans: event.plans, selectedIndex: event.index));
  }


  //selected plan event
  selectedPlanEvent(ContinueToPayEvent event, Emitter<PlanState> emit)async{
    debugPrint("selected index: ${event.index}");
    debugPrint("Slected plan : ${event.plans[event.index]}");
    debugPrint("Slected plan : ${event.plans[event.index]['price']}");
    emit(PlanLoadedState(plans: event.plans, selectedIndex: event.index));
    //debugPrint("key : ${dotenv.env['KEY']}");
    try{
      PaymentRepo paymentRepo = PaymentRepo();
     await paymentRepo.makePayment(event.plans[event.index]['price']).then((value) {
      emit(PlanPaymentSucessState());
     });

    }catch(error){
       emit(PlanErrorState(error.toString()));
      debugPrint("Error selectedPlanEvent: $error");
    }

  }

}