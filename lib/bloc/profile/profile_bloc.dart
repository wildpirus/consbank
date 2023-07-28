import 'dart:convert';

import 'package:consbank/controllers/user_controller.dart';
import 'package:consbank/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(UserController.getProfileState()) {
    on<SetUser>(setUser);
  }

  void setUser(SetUser event, emit) async {
    UserController.currentUser = event.user;
    emit(state.copyWith(user: event.user));
  }
}
