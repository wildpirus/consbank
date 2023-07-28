import 'package:consbank/routes/welcome_routes.dart';
import 'package:consbank/ui/app/auth/login_page_ui.dart';
import 'package:consbank/ui/app/auth/register_page_ui.dart';
import 'package:consbank/ui/shared/primary_button.dart';
import 'package:consbank/ui/shared/white_container.dart';
import 'package:flutter/material.dart';
import 'package:consbank/styles/styles.dart';
import 'package:get/get.dart';

class WelcomePageUi extends StatelessWidget {
  const WelcomePageUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: ConsbankColors.primary,
            height: Get.height,
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Container(
                    decoration: gradientPrimaryDecorator,
                  ),
                  Column(
                    children: [_Logo(), Expanded(child: _Content())],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Get.height * 0.2,
        child: const Center(
          child: Text(
            'Consbank',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WhiteContainer(
        child: Container(
      constraints: BoxConstraints(minHeight: Get.height * 0.8),
      child: Column(
        children: [
          Expanded(child: SingleChildScrollView(child: welcomeRoutes.elementAt(_currentIndex))),
          Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black.withOpacity(0.09), offset: const Offset(10, 0), blurRadius: 15)
                ]),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: ConsbankColors.primary,
                  unselectedItemColor: Colors.grey,
                  selectedFontSize: 12,
                  unselectedFontSize: 11,
                  onTap: (value) => getWidgetPage(value),
                  items: [
                    BottomNavigationBarItem(
                      label: 'Registrate',
                      icon: Icon(Icons.app_registration, size: 30, color: ConsbankColors.primary),
                    ),
                    BottomNavigationBarItem(
                      label: 'Inicia Sesión',
                      icon: Icon(Icons.login, size: 30, color: ConsbankColors.primary),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  void getWidgetPage(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
