import 'package:consbank/bloc/profile/profile_bloc.dart';
import 'package:consbank/models/user_model.dart';
import 'package:consbank/styles/consbank_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CreditHistoryUi extends StatelessWidget {
  const CreditHistoryUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return _Content(
          user: state.user!,
        );
      },
    );
  }
}

class _Content extends StatefulWidget {
  final User user;

  const _Content({
    required this.user,
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
    for (int i = 1; i <= 10; i++) {
      tableData.add({
        'loanAmount': '',
        'date': '',
        'numberOfPayments': '',
        'interestRate': '',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const Text(
            'Historial de créditos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const Text(
            'Aqui encontrarás tu historial de créditos y el registro de todas tus simulaciones',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: Get.height * 0.6,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Monto de crédito')),
                    DataColumn(label: Text('Fecha')),
                    DataColumn(label: Text('No. de cuotas')),
                    DataColumn(label: Text('Interés')),
                  ],
                  rows: tableData.map((data) {
                    return DataRow(cells: [
                      DataCell(Text(data['loanAmount'].toString())),
                      DataCell(Text(data['date'].toString())),
                      DataCell(Text(data['numberOfPayments'].toString())),
                      DataCell(Text(data['interestRate'].toString())),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
