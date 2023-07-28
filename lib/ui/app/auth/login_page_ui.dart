import 'dart:io';

import 'package:consbank/bloc/profile/profile_bloc.dart';
import 'package:consbank/controllers/user_controller.dart';
import 'package:consbank/helpers/snack_bar_message.dart';
import 'package:consbank/ui/app/app_page_ui.dart';
import 'package:consbank/ui/shared/input.dart';
import 'package:consbank/ui/shared/primary_button.dart';
import 'package:consbank/ui/shared/title.dart';
import 'package:flutter/material.dart';
import 'package:consbank/styles/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginPageUi extends StatefulWidget {
  const LoginPageUi({super.key});

  @override
  State<LoginPageUi> createState() => _LoginPageUiState();
}

class _LoginPageUiState extends State<LoginPageUi> {
  final emailCtrl = TextEditingController();
  final pswCtrl = TextEditingController();
  late ProfileBloc _profileBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          ConsTitle(
            margin: const EdgeInsets.only(bottom: 30.0),
            text: 'Bienvenido',
            color: ConsbankColors.primary,
          ),
          Input(
            label: 'Email',
            type: TextInputType.number,
            controller: emailCtrl,
          ),
          Input(
            label: 'Contraseña',
            obscure: true,
            controller: pswCtrl,
          ),
          PrimaryButton(
            text: 'Iniciar sesión',
            color: ConsbankColors.primary,
            callback: () => login(context),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _profileBloc = context.read<ProfileBloc>();
    super.initState();
  }

  login(BuildContext context) async {
    if (emailCtrl.text.isEmpty || pswCtrl.text.isEmpty) return null;
    FocusScope.of(context).unfocus();
    EasyLoading.show(status: 'Iniciando sesión');
    try {
      UserController userController = Get.find<UserController>();
      final res = await userController.login(
        emailCtrl.text,
        pswCtrl.text,
      );
      _profileBloc.add(SetUser(res));
      Get.off(() => const AppPageUi());
    } on SocketException {
      SnackBarMessage(type: SnackBarMessage.DANGER, message: "Parece que tienes problemas de conexión").show();
    } on HttpException catch (err) {
      SnackBarMessage(type: SnackBarMessage.DANGER, message: err.message).show();
    } catch (err, s) {
      SnackBarMessage(type: SnackBarMessage.DANGER, message: "Error iniciando sesión", exception: err, stack: s).show();
    }
    EasyLoading.dismiss();
  }
}
