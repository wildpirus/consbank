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

class RegisterPageUi extends StatefulWidget {
  const RegisterPageUi({super.key});

  @override
  State<RegisterPageUi> createState() => _RegisterPageUiState();
}

class _RegisterPageUiState extends State<RegisterPageUi> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final idNumberCtrl = TextEditingController();
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
            text: 'Regístrese',
            color: ConsbankColors.primary,
          ),
          Input(
            label: 'Nombre',
            type: TextInputType.text,
            controller: nameCtrl,
          ),
          Input(
            label: 'Email',
            type: TextInputType.text,
            controller: emailCtrl,
          ),
          Input(
            label: '# de Identificación',
            type: TextInputType.number,
            controller: idNumberCtrl,
          ),
          Input(
            label: 'Contraseña',
            obscure: true,
            controller: pswCtrl,
          ),
          PrimaryButton(
            text: 'Registrarse',
            color: ConsbankColors.primary,
            callback: () => register(context),
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

  register(BuildContext context) async {
    if (emailCtrl.text.isEmpty || pswCtrl.text.isEmpty || nameCtrl.text.isEmpty || idNumberCtrl.text.isEmpty) return null;
    FocusScope.of(context).unfocus();
    EasyLoading.show(status: 'Iniciando sesión');
    try {
      UserController userController = Get.find<UserController>();
      final res = await userController.addUser({
        'name': nameCtrl.text,
        'email': emailCtrl.text,
        'idNumber': idNumberCtrl.text,
        'password': pswCtrl.text,
      });
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
