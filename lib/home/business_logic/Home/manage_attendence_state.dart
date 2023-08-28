import 'package:flutter/cupertino.dart';

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
//AttendanceChangedState
class AttendanceChangedState extends ManageAttendenceState {
//updatedFinishedValue
  final bool updatedFinishedValue;
  AttendanceChangedState(this.updatedFinishedValue);
}
//GenerateQRCodeLoadingState
class GenerateQRCodeLoadingState extends ManageAttendenceState {}
//GenerateQRCodeSuccessState
class GenerateQRCodeSuccessState extends ManageAttendenceState {
  final Widget qrCode;
  GenerateQRCodeSuccessState(this.qrCode);
}
//GetNearestSceduleLoadingState
class GetNearestSceduleLoadingState extends ManageAttendenceState {}
//GetNearestSceduleSuccessState
class GetNearestSceduleSuccessState extends ManageAttendenceState {
 // final Map<String, dynamic> schedule;
  //GetNearestSceduleSuccessState(this.schedule);
}
//GetNearestScheduleLoadingState
class GetNearestScheduleLoadingState extends ManageAttendenceState {}
//GetNearestScheduleSuccessState
class GetNearestScheduleSuccessState extends ManageAttendenceState {
  //
  //emit(GetNearestScheduleSuccessState(
 // nearestSchedule: nearestSchedule,
  //));
  //final SchedulesModel nearestSchedule;
  //GetNearestScheduleSuccessState(this.nearestSchedule);
}
//GetNearestScheduleErrorState
class GetNearestScheduleErrorState extends ManageAttendenceState {
  final String error;
  GetNearestScheduleErrorState(this.error);
}
//GetUserDataLoadingState
class GetUserDataLoadingState extends ManageAttendenceState {}
//GetUserDataSuccessState
class GetUserDataSuccessState extends ManageAttendenceState {

}


//GetUserDataErrorState
class GetUserDataErrorState extends ManageAttendenceState {
  final String error;
  GetUserDataErrorState(this.error);
}

