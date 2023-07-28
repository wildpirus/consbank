part of 'profile_bloc.dart';

ProfileState profileStateFromJson(String str) => ProfileState.fromJson(json.decode(str) as Map<String, dynamic>);
String profileStateToJson(ProfileState profileState) => json.encode(profileState.toJson());

@immutable
class ProfileState {
  final User? user;
  final double? loanAmount;
  final double? interestRate;
  final int? numberOfPayments;

  const ProfileState({
    this.user,
    this.loanAmount,
    this.interestRate,
    this.numberOfPayments,
  });

  ProfileState copyWith({
    User? user,
    double? loanAmount,
    double? interestRate,
    int? numberOfPayments,
  }) =>
      ProfileState(
        user: user ?? this.user,
        loanAmount: loanAmount ?? this.loanAmount,
        interestRate: interestRate ?? this.interestRate,
        numberOfPayments: numberOfPayments ?? this.numberOfPayments,
      );

  factory ProfileState.fromJson(Map<String, dynamic> json) => ProfileState(
        user: User.fromJson(json["user"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}
