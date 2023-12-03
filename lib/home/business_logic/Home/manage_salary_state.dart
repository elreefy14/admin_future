part of 'manage_salary_cubit.dart';

@immutable
abstract class ManageSalaryState {}

class ManageSalaryInitial extends ManageSalaryState {}
//GetUsersLoadingState
class GetUsersLoadingState extends ManageSalaryState {}
//GetUsersSuccessState
class GetUsersSuccessState extends ManageSalaryState {}
//GetUsersErrorState
class GetUsersErrorState extends ManageSalaryState {
  final String error;
  GetUsersErrorState(this.error);
}
//PaySalaryLoadingState
class PaySalaryLoadingState extends ManageSalaryState {}
//PaySalarySuccessState
class PaySalarySuccessState extends ManageSalaryState {}
//PaySalaryErrorState
class PaySalaryErrorState extends ManageSalaryState {
  final String error;
  PaySalaryErrorState(this.error);
}
//PayBonusLoadingState
class PayBonusLoadingState extends ManageSalaryState {}
//PayBonusSuccessState
class PayBonusSuccessState extends ManageSalaryState {}
//PayBonusErrorState
class PayBonusErrorState extends ManageSalaryState {
  final String error;
  PayBonusErrorState(this.error);
}
//PayBonusSuccessStateWithoutInternet
class PayBonusSuccessStateWithoutInternet extends ManageSalaryState {}
//Stop
class Stop extends ManageSalaryState {}
//PaySalarySuccessStateWithoutInternet
class PaySalarySuccessStateWithoutInternet extends ManageSalaryState {}
//UpdateUserInfoLoadingState
class UpdateUserInfoLoadingState extends ManageSalaryState {}
//UpdateUserInfoSuccessState
class UpdateUserInfoSuccessState extends ManageSalaryState {}
//UpdateUserInfoErrorState
class UpdateUserInfoErrorState extends ManageSalaryState {
  final String error;
  UpdateUserInfoErrorState(this.error);
}
//GetSchedulesLoadingState
class GetSchedulesLoadingState extends ManageSalaryState {}
//GetSchedulesSuccessState
class GetSchedulesSuccessState extends ManageSalaryState {}
//GetSchedulesErrorState
class GetSchedulesErrorState extends ManageSalaryState {
  final String error;
  GetSchedulesErrorState(this.error);
}
//GenerateRandomSchedulesLoadingState
class GenerateRandomSchedulesLoadingState extends ManageSalaryState {}
//GenerateRandomSchedulesSuccessState
class GenerateRandomSchedulesSuccessState extends ManageSalaryState {}
//GenerateRandomSchedulesErrorState
class GenerateRandomSchedulesErrorState extends ManageSalaryState {
  final String error;
  GenerateRandomSchedulesErrorState(this.error);
}
//GetSchedulesForDayLoadingState
class GetSchedulesForDayLoadingState extends ManageSalaryState {}
//GetSchedulesForDaySuccessState
class GetSchedulesForDaySuccessState extends ManageSalaryState {}
//GetSchedulesForDayErrorState
class GetSchedulesForDayErrorState extends ManageSalaryState {
  final String error;
  GetSchedulesForDayErrorState(this.error);
}
//DeleteScheduleLoadingState
class DeleteScheduleLoadingState extends ManageSalaryState {}
//DeleteScheduleSuccessState
class DeleteScheduleSuccessState extends ManageSalaryState {}
//DeleteScheduleErrorState
class DeleteScheduleErrorState extends ManageSalaryState {
  final String error;
  DeleteScheduleErrorState(this.error);
}
//ChangeSelectedDayIndexState
class ChangeSelectedDayIndexState extends ManageSalaryState {
  final int selectedDayIndex;
  ChangeSelectedDayIndexState(this.selectedDayIndex);
}//UpdateSchedulesLoadingState
//UpdateSchedulesLoadingState
class UpdateSchedulesLoadingState extends ManageSalaryState {}
//UpdateSchedulesSuccessState
class UpdateSchedulesSuccessState extends ManageSalaryState {}
//ChangeIsGreyState
class ChangeIsGreyState extends ManageSalaryState {
  final bool isGrey;
  ChangeIsGreyState(this.isGrey);
}//UpdateListOfUsersState
//UpdateListOfUsersState
class UpdateListOfUsersState extends ManageSalaryState {
  final List<UserModel> listOfUsers;
  UpdateListOfUsersState(this.listOfUsers);
}//UpdateListOfSchedulesState
//ChangeIsCoachState
class ChangeIsCoachState extends ManageSalaryState {
  final bool isCoach;
  ChangeIsCoachState(this.isCoach);
}//UpdateListOfSchedulesState
//ShowRollbackButtonState
class ShowRollbackButtonState extends ManageSalaryState {
  
}//UpdateListOfSchedulesState
//UpdateShowRollbackButtonLoadingState
class UpdateShowRollbackButtonLoadingState extends ManageSalaryState {
  
}//UpdateListOfSchedulesState
//UpdateShowRollbackButtonSuccessState
class UpdateShowRollbackButtonSuccessState extends ManageSalaryState {
  
}//UpdateListOfSchedul// esState
//DeleteUserLoadingState
class DeleteUserLoadingState extends ManageSalaryState {

}//UpdateListOfSchedulesState
//DeleteUserSuccessState
class DeleteUserSuccessState extends ManageSalaryState {

}//UpdateListOfSchedulesState
//DeleteUserErrorState
class DeleteUserErrorState extends ManageSalaryState {
  final String error;
  DeleteUserErrorState(this.error);
}//UpdateListOfSchedulesState
//ReduceSessionsLoadingState
class ReduceSessionsLoadingState extends ManageSalaryState {

}//UpdateListOfSchedulesState
//ReduceSessionsSuccessState
class ReduceSessionsSuccessState extends ManageSalaryState {

}//UpdateListOfSchedulesState
//ReduceSessionsErrorState
class ReduceSessionsErrorState extends ManageSalaryState {
  final String error;
  ReduceSessionsErrorState(this.error);
}//UpdateListOfSchedulesState
//AddSessionsLoadingState
class AddSessionsLoadingState extends ManageSalaryState {

}//UpdateListOfSchedulesState
//AddSessionsSuccessState
class AddSessionsSuccessState extends ManageSalaryState {

}//UpdateListOfSchedulesState
//AddSessionsErrorState
class AddSessionsErrorState extends ManageSalaryState {
  final String error;
  AddSessionsErrorState(this.error);
}//UpdateListOfSchedulesState
//RollbackSalarySuccessStateWithoutInternet
class RollbackSalarySuccessStateWithoutInternet extends ManageSalaryState {

}//UpdateListOfSchedulesState