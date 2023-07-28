import 'package:consbank/bloc/profile/profile_bloc.dart';
import 'package:consbank/controllers/user_controller.dart';
import 'package:consbank/helpers/snack_bar_message.dart';
import 'package:consbank/models/user_model.dart';
import 'package:consbank/styles/consbank_colors.dart';
import 'package:consbank/ui/shared/dropdown_input.dart';
import 'package:consbank/ui/shared/input2.dart';
import 'package:consbank/ui/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'dart:math';
import 'package:intl/intl.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key}) : super(key: key);

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  User? user;

  int _selectedCreditType = 0;
  final creditTypeList = [
    'Selecciona el tipo de crédito',
    'Crédito de vehículo',
    'Crédito de vivienda',
    'Crédito de libre inversión',
  ];
  final salaryCtrl = TextEditingController();
  final shareCtrl = TextEditingController();
  final monthCtrl = TextEditingController();

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
              Icon(Icons.warning_rounded, size: 20, color: ConsbankColors.primary),
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
            label: '¿Qué tipo de crédito deseas realizar?',
            isRequired: false,
            items: creditTypeList,
            value: _selectedCreditType,
            onChanged: (value) {
              setState(() {
                _selectedCreditType = int.parse(value.toString());
              });
            },
          ),
          Input2(
            label: '¿Cuál es tu salario base?',
            controller: salaryCtrl,
            type: TextInputType.number,
            hint: 'Digita tu salario para calcular el préstamo que necesitas',
            onChanged: (value) {
              if (value.isNotEmpty) {
                String stringValue = value.replaceAll(RegExp(r'[^\d]'), '');
                double doubleValue = double.tryParse(stringValue) ?? 0.0;
                String formattedValue = NumberFormat.simpleCurrency(decimalDigits: 2).format(doubleValue / 100);
                salaryCtrl.value = TextEditingValue(
                  text: formattedValue,
                  selection: TextSelection.collapsed(offset: formattedValue.length),
                );
              }
            },
          ),
          Input2(
            readOnly: true,
            controller: shareCtrl,
            type: TextInputType.number,
          ),
          Input2(
            label: '¿A cuántos meses?',
            controller: monthCtrl,
            type: TextInputType.number,
            hint: 'Elige un plazo de 12 hasta 84 meses',
          ),
          const SizedBox(height: 15),
          PrimaryButton(
            text: 'Simular',
            color: ConsbankColors.primary,
            callback: _simulateCredit,
          ),
        ],
      ),
    );
  }

  void _simulateCredit() {
    double interestRate = 0.0;
    if (_selectedCreditType == 1) {
      // Crédito de vehículo (3%)
      interestRate = 3.0;
    } else if (_selectedCreditType == 2) {
      // Crédito de vivienda (1%)
      interestRate = 1.0;
    } else if (_selectedCreditType == 3) {
      // Crédito de libre inversión (3.5%)
      interestRate = 3.5;
    }
    context.read<ProfileBloc>().add(NewAmortization(
          parseStringToDouble(shareCtrl.text),
          interestRate,
          int.tryParse(monthCtrl.text) ?? 0,
        ));

    Get.toNamed('/amortization');
    /*double salary = double.tryParse(salaryCtrl.text) ?? 0.0;
    int selectedMonths = int.tryParse(monthCtrl.text) ?? 0;
    double maxLoanAmount = (salary * 7) / 15;

    

    double monthlyInterest = interestRate / 100 / 12;
    double numerator = maxLoanAmount * monthlyInterest;
    num denominator = 1 - pow(1 + monthlyInterest, -selectedMonths);
    double monthlyPayment = numerator / denominator;

    setState(() {
      shareCtrl.text = formatCurrency(monthlyPayment);
    });*/
  }

  String formatCurrency(double amount) {
    final formatter = NumberFormat.simpleCurrency(decimalDigits: 2);
    return formatter.format(amount);
  }

  @override
  void initState() {
    super.initState();
    salaryCtrl.addListener(_syncControllers);
    getProfileData();
  }

  void getProfileData() async {
    try {
      user = UserController.currentUser;
    } catch (err) {
      SnackBarMessage(
        type: SnackBarMessage.DANGER,
        message: 'Error cargando información de usuario',
        marginBottom: 70,
      ).show();
    }
  }

  void _syncControllers() {
    String currency1 = salaryCtrl.text;
    String currency2 = shareCtrl.text;

    if (currency1.isNotEmpty && currency1 != currency2) {
      double doubleValue = parseStringToDouble(currency1);
      doubleValue = (doubleValue * 7) * 0.15;
      String formattedValue = NumberFormat.simpleCurrency(decimalDigits: 2).format(doubleValue / 100);

      if (shareCtrl.text != formattedValue) {
        shareCtrl.text = formattedValue;
      }
    }
  }

  double parseStringToDouble(String value) {
    String stringValue = value.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(stringValue) ?? 0.0;
  }
}
