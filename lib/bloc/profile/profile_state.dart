part of 'profile_bloc.dart';

ProfileState profileStateFromJson(String str) => ProfileState.fromJson(json.decode(str) as Map<String, dynamic>);
String profileStateToJson(ProfileState profileState) => json.encode(profileState.toJson());

@immutable
class ProfileState {
  final User? user;

  const ProfileState({
    this.user,
  });

  ProfileState copyWith({
    User? user,
  }) =>
      ProfileState(
        user: user ?? this.user,
      );

  factory ProfileState.fromJson(Map<String, dynamic> json) => ProfileState(
        user: User.fromJson(json["user"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}
