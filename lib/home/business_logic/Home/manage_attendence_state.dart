import '../../data/schedules.dart';

abstract class ManageAttendenceState {}
//InitialState
class InitialState extends ManageAttendenceState {}
//GetSchedulesForAdminLoadingState
class GetSchedulesForAdminLoadingState extends ManageAttendenceState {}
//GetSchedulesForAdminSuccessState
class GetSchedulesForAdminSuccessState extends ManageAttendenceState {
}
//GetSchedulesForAdminErrorState
class GetSchedulesForAdminErrorState extends ManageAttendenceState {
  final String error;
  GetSchedulesForAdminErrorState(this.error);
}
