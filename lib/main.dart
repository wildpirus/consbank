import 'dart:async';

import 'package:consbank/bloc/profile/profile_bloc.dart';
import 'package:consbank/routes/routes.dart';
import 'package:consbank/styles/styles.dart';
import 'package:consbank/ui/shared/background_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import './controllers/user_controller.dart';
import './domain/repositories/user_repository.dart';
import 'package:loggy/loggy.dart';
import './domain/use_case/user_manager.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => UserRepository(), fenix: true);
    Get.lazyPut(() => UserManager(), fenix: true);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  runApp(const ConsbankApp());
}

class ConsbankApp extends StatefulWidget {
  const ConsbankApp({Key? key}) : super(key: key);

  @override
  _ConsbankAppState createState() => _ConsbankAppState();
}

class _ConsbankAppState extends State<ConsbankApp> with WidgetsBindingObserver {
  StreamSubscription<String?>? streamLinkSubscription;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileBloc()),
      ],
      child: BackgroundApp(
        child: GetMaterialApp(
            initialBinding: InitialBinding(),
            title: 'Consbank',
            theme: ConsbankThemes.ligth,
            initialRoute: UserController.isLoggedIn ? 'app' : 'welcome',
            getPages: pages,
            builder: (BuildContext context, Widget? child) {
              return FlutterEasyLoading(child: child);
            }),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    streamLinkSubscription?.cancel();
    super.dispose();
  }
}
