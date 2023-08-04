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