part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class SetUser extends ProfileEvent {
  final User? user;
  SetUser(this.user);
}

class NewAmortization extends ProfileEvent {
  final double loanAmount;
  final double interestRate;
  final int numberOfPayments;
  NewAmortization(this.loanAmount, this.interestRate, this.numberOfPayments);
}
