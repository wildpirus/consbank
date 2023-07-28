import 'package:consbank/ui/app/app_page_ui.dart';
import 'package:consbank/ui/app/auth/welcome_page_ui.dart';
import 'package:get/route_manager.dart';

final List<GetPage<dynamic>> pages = [
  GetPage(name: '/welcome', page: () => const WelcomePageUi()),
  GetPage(name: '/app', page: () => const AppPageUi()),
];
