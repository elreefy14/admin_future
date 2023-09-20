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
}