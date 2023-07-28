import 'package:consbank/bloc/profile/profile_bloc.dart';
import 'package:consbank/helpers/snack_bar_message.dart';
import 'package:consbank/styles/consbank_colors.dart';
import 'package:consbank/ui/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:math';
import 'package:excel/excel.dart';

class AmortizationTable extends StatelessWidget {
  const AmortizationTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return _Content(
          loanAmount: state.loanAmount ?? 0,
          interestRate: state.interestRate ?? 0,
          numberOfPayments: state.numberOfPayments ?? 0,
        );
      },
    );
  }
}

class _Content extends StatefulWidget {
  final double loanAmount;
  final double interestRate;
  final int numberOfPayments;

  const _Content({
    required this.loanAmount,
    required this.interestRate,
    required this.numberOfPayments,
  });

  @override
  __ContentState createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    _generateAmortizationTable();
  }

  void _generateAmortizationTable() {
    double principal = widget.loanAmount;
    double monthlyInterest = widget.interestRate / 100 / 12;
    double monthlyPayment = (widget.loanAmount * monthlyInterest) / (1 - pow(1 + monthlyInterest, -widget.numberOfPayments));

    for (int i = 1; i <= widget.numberOfPayments; i++) {
      double interest = principal * monthlyInterest;
      double principalPayment = monthlyPayment - interest;
      principal -= principalPayment;

      tableData.add({
        'Saldo Inicial': principal + principalPayment,
        'Número de la cuota': i,
        'Cuota': monthlyPayment.toStringAsFixed(2),
        'Interés': interest.toStringAsFixed(2),
        'Abono a capital': principalPayment.toStringAsFixed(2),
        'Saldo del periodo': principal.toStringAsFixed(2),
      });
    }
  }

  void _exportToExcel() async {
    try {
      var directory = await getExternalStorageDirectory();
      var excel = Excel.createExcel();
      var sheet = excel['Amortization Table'];
      sheet.appendRow([
        'Saldo Inicial',
        'Número de la cuota',
        'Cuota',
        'Interés',
        'Abono a capital',
        'Saldo del periodo',
      ]);

      for (var data in tableData) {
        sheet.appendRow([
          data['Saldo Inicial'],
          data['Número de la cuota'],
          data['Cuota'],
          data['Interés'],
          data['Abono a capital'],
          data['Saldo del periodo'],
        ]);
      }
      String outputFile = "${directory!.path}/amortization-table-${DateTime.now().toIso8601String()}.xlsx";
      List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File(join(outputFile))
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        _openExcelFile(outputFile);
      } else {
        SnackBarMessage(
          type: SnackBarMessage.DANGER,
          message: 'Error guardando archivo',
          marginBottom: 70,
        ).show();
      }
    } catch (error) {
      SnackBarMessage(type: SnackBarMessage.DANGER, message: "Error inesperado, vuelva a intentarlo", marginBottom: 70).show();
    }
  }

  Future<void> _openExcelFile(String filePath) async {
    try {
      await OpenFile.open(filePath, type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    } catch (e) {
      SnackBarMessage(type: SnackBarMessage.DANGER, message: "Error inesperado, vuelva a intentarlo", marginBottom: 70).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.7,
                        child: Text(
                          'Resultado de tu simulador de crédito',
                          style: TextStyle(fontSize: 20, color: ConsbankColors.primary),
                        ),
                      ),
                      const Icon(Icons.notifications_on_outlined, size: 30),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Te presentamos en tu tabla de amortización el resultado del movimiento de tu crédito',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Tabla de créditos',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.filter_alt_rounded, size: 30),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.6,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Saldo Inicial')),
                            DataColumn(label: Text('Número de la cuota')),
                            DataColumn(label: Text('Cuota')),
                            DataColumn(label: Text('Interés')),
                            DataColumn(label: Text('Abono a capital')),
                            DataColumn(label: Text('Saldo del periodo')),
                          ],
                          rows: tableData.map((data) {
                            return DataRow(cells: [
                              DataCell(Text(data['Saldo Inicial'].toString())),
                              DataCell(Text(data['Número de la cuota'].toString())),
                              DataCell(Text(data['Cuota'].toString())),
                              DataCell(Text(data['Interés'].toString())),
                              DataCell(Text(data['Abono a capital'].toString())),
                              DataCell(Text(data['Saldo del periodo'].toString())),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PrimaryButton(
                    text: 'Descargar Tabla',
                    color: ConsbankColors.primary,
                    callback: _exportToExcel,
                  ),
                  PrimaryButton(
                    padding: const EdgeInsets.all(2),
                    color: ConsbankColors.primary,
                    outline: true,
                    text: 'Guardar Amortización',
                    callback: _exportToExcel,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
