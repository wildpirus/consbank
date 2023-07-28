import 'package:consbank/controllers/user_controller.dart';
import 'package:consbank/helpers/snack_bar_message.dart';
import 'package:consbank/models/user_model.dart';
import 'package:consbank/styles/consbank_colors.dart';
import 'package:consbank/ui/shared/dropdown_input.dart';
import 'package:consbank/ui/shared/input.dart';
import 'package:flutter/material.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  User? user;

  int _selectedCreditType = 0;
  final creditTypeList = [
    'Selecciona el tipo de crédito',
  ];
  final salaryCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hola ${user?.name ?? ''} 👋',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const Icon(Icons.notifications_on_outlined, size: 30),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Simulador de crédito',
                style: TextStyle(fontSize: 20, color: ConsbankColors.primary),
              ),
              Icon(Icons.warning_rounded, size: 20, color: ConsbankColors.primary)
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            'Ingresa los datos para tu crédito según lo necesites',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          DropdownInput(
            label: '¿Que tipo de crédito deseas realizar?',
            isRequired: false,
            items: creditTypeList,
            value: _selectedCreditType,
            onChanged: (value) {
              setState(() {
                _selectedCreditType = int.parse(value.toString());
              });
            },
          ),
          const SizedBox(height: 10),
          Input(
            label: '¿Cuanto es tu salario base?',
            controller: salaryCtrl,
            type: TextInputType.number,
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  void getProfileData() async {
    try {
      user = UserController.currentUser;
    } catch (err) {
      SnackBarMessage(type: SnackBarMessage.DANGER, message: 'Error cargando información de usuario', marginBottom: 70).show();
    }
  }
}
