import '../../data/schedules.dart';

abstract class HomeState {}
//InitialState
class InitialState extends HomeState {}
//GetSchedulesLoadingState
class GetSchedulesLoadingState extends HomeState {}
//GetSchedulesSuccessState
class GetSchedulesSuccessState extends HomeState {}
//GetSchedulesErrorState
class GetSchedulesErrorState extends HomeState {
  final String error;
  GetSchedulesErrorState({required this.error});
}
//detectedBeaconsSuccessState
class DetectedBeaconsSuccessState extends HomeState {}
//ClearDetectedBeaconsSuccessState
class ClearDetectedBeaconsSuccessState extends HomeState {}
//ChangePasswordVisibilityState
class ChangePasswordVisibilityState extends HomeState {}
//PeriodicAlarmSuccessState
class PeriodicAlarmSuccessState extends HomeState {}
//StartScanningLoadingState
class StartScanningLoadingState extends HomeState {}
//StartScanningSuccessState
class StartScanningSuccessState extends HomeState {}
//GenerateQrImageSuccessState
class GenerateQrImageSuccessState extends HomeState {}
//GenerateQrImageErrorState
class GenerateQrImageErrorState extends HomeState {
  final String error;
  GenerateQrImageErrorState({required this.error});
}
//GenerateQrImageLoadingState
class GenerateQrImageLoadingState extends HomeState {}
//LoadingState
class LoadingState extends HomeState {}
//emit(GetAllSchedulesForSpecificCoachSuccessState(schedules: schedules));
class GetAllSchedulesForSpecificCoachSuccessState extends HomeState {
  final List<SchedulesModel> schedules;
  GetAllSchedulesForSpecificCoachSuccessState({required this.schedules});
}
//GetAllSchedulesForSpecificCoachErrorState
class GetAllSchedulesForSpecificCoachErrorState extends HomeState {
  final String error;
  GetAllSchedulesForSpecificCoachErrorState({required this.error});
}
//AddScheduleToCoachCollectionSuccessState
class AddScheduleToCoachCollectionSuccessState extends HomeState {}
//AddScheduleToCoachCollectionErrorState
class AddScheduleToCoachCollectionErrorState extends HomeState {
  final String error;
  AddScheduleToCoachCollectionErrorState({required this.error});
}
//StoreSchedulesInSharedPreferencesSuccessState
class StoreSchedulesInSharedPreferencesSuccessState extends HomeState {}
//StoreSchedulesInSharedPreferencesErrorState
class StoreSchedulesInSharedPreferencesErrorState extends HomeState {
  final String error;
  StoreSchedulesInSharedPreferencesErrorState({required this.error});
}
//ChangeBottomNavState
class ChangeBottomNavState extends HomeState {}
//GetUserDataLoadingState
class GetUserDataLoadingState extends HomeState {}
//GetUserDataSuccessState
class GetUserDataSuccessState extends HomeState {}
//GetUserDataErrorState
class GetUserDataErrorState extends HomeState {
  final String error;
  GetUserDataErrorState({required this.error});
}
class EditUserDataLoadingState extends HomeState {}
//EditUserDataSuccessState
class EditUserDataSuccessState extends HomeState {}
//EditUserDataErrorState
class EditUserDataErrorState extends HomeState {
  final String error;
  EditUserDataErrorState(this.error);
}
//UploadProfilePicSuccessState
class UploadProfilePicSuccessState extends HomeState {}
//UploadProfilePicErrorState
class UploadProfilePicErrorState extends HomeState {}
//GetProfilePicSuccessState
class GetProfilePicSuccessState extends HomeState {}
//GetProfilePicErrorState
class GetProfilePicErrorState extends HomeState {}
//GetNotificationsSuccessState
class GetNotificationsSuccessState extends HomeState {
  final List notifications;
  GetNotificationsSuccessState({required this.notifications});
}
//GetNotificationsLoadingState
class GetNotificationsLoadingState extends HomeState {}
//GetUserDataErrorState
class GetNotificationsErrorState extends HomeState {
  final String error;
  GetNotificationsErrorState({required this.error});
}