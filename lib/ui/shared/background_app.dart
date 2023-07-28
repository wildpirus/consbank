import 'dart:async';
import 'package:consbank/bloc/profile/profile_bloc.dart';
import 'package:consbank/controllers/user_controller.dart';
import 'package:consbank/models/user_model.dart';
import 'package:consbank/ui/app/auth/welcome_page_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class BackgroundApp extends StatefulWidget {
  final Widget child;

  const BackgroundApp({Key? key, required this.child}) : super(key: key);

  @override
  _BackgroundAppState createState() => _BackgroundAppState();
}

class _BackgroundAppState extends State<BackgroundApp> with WidgetsBindingObserver {
  StreamSubscription<dynamic>? _connectityListiner,
      _bockedAddListiner,
      _bockedRmListiner,
      _releaseListiner,
      _statusListiner,
      _profileListiner;
  late ProfileBloc _profileBloc;
  bool isOrderActive = false;
  bool locationActive = false;
  bool isUserInit = false;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _profileBloc = context.read<ProfileBloc>();
  }

  @override
  void dispose() {
    _connectityListiner?.cancel();
    _bockedAddListiner?.cancel();
    _bockedRmListiner?.cancel();
    _releaseListiner?.cancel();
    _statusListiner?.cancel();
    _profileListiner?.cancel();
    _profileBloc.close();
    super.dispose();
  }

  void initUser() async {
    if (UserController.isLoggedIn) {
      isUserInit = true;
      User? user = UserController.currentUser;
      if (user != null) _profileBloc.add(SetUser(user));
    }
  }
}
