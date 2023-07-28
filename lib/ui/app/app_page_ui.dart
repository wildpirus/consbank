import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:consbank/bloc/profile/profile_bloc.dart';
import 'package:consbank/controllers/user_controller.dart';
import 'package:consbank/helpers/snack_bar_message.dart';
import 'package:consbank/models/user_model.dart';
import 'package:consbank/routes/app_routes.dart';
import 'package:consbank/styles/consbank_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPageUi extends StatefulWidget {
  const AppPageUi({Key? key}) : super(key: key);

  @override
  _AppPageUiState createState() => _AppPageUiState();
}

class _AppPageUiState extends State<AppPageUi> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ConsbankColors.whiteSecondary,
          body: ColorfulSafeArea(
            color: Colors.white,
            child: Stack(
              children: const [_Content()],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class _Content extends StatefulWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  __ContentState createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        appRoutes.elementAt(_currentIndex),
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
                    label: 'Home',
                    icon: Icon(Icons.home_filled, size: 30, color: ConsbankColors.primary),
                  ),
                  BottomNavigationBarItem(
                    label: 'Historial créditos',
                    icon: Icon(Icons.wallet, size: 30, color: ConsbankColors.primary),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void getWidgetPage(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
