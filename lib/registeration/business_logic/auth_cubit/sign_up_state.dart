abstract class SignUpState {}
//InitialState
class InitialState extends SignUpState {}
//ChangePasswordVisibilityState
class ChangePasswordVisibilityState extends SignUpState {}
//SignUpLoadingState
class SignUpLoadingState extends SignUpState {}
//SignUpSuccessState
class SignUpSuccessState extends SignUpState {
  final String uId;
  SignUpSuccessState(this.uId);
}
//SignUpErrorState
class SignUpErrorState extends SignUpState {
  final String? error;
  SignUpErrorState({this.error});
}
//CreateUserLoadingState
class CreateUserLoadingState extends SignUpState {}
//CreateUserSuccessState
class CreateUserSuccessState extends SignUpState {
  final String uId;
  CreateUserSuccessState(this.uId);
}
//CreateUserErrorState
class CreateUserErrorState extends SignUpState {}
//UpdatePasswordLoadingState
class UpdatePasswordLoadingState extends SignUpState {}
//UpdatePasswordSuccessState
class UpdatePasswordSuccessState extends SignUpState {}
//UpdatePasswordErrorState
class UpdatePasswordErrorState extends SignUpState {
  final String? error;
  UpdatePasswordErrorState({this.error});
}
