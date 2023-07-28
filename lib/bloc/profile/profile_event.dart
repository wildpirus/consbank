part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class SetUser extends ProfileEvent {
  final User? user;
  SetUser(this.user);
}
