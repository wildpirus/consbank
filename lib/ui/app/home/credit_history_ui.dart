import 'package:consbank/bloc/profile/profile_bloc.dart';
import 'package:consbank/models/user_model.dart';
import 'package:flutter/material.dart';
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
  int _selectedRowIndex = -1;

  double parseStringToDouble(String value) {
    String stringValue = value.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(stringValue) ?? 0.0;
  }

  List<DataRow> _buildRows() {
    List<Map<String, dynamic>> data = [];

    return data.map((item) {
      final index = data.indexOf(item);
      final selected = index == _selectedRowIndex;

      return DataRow(
        selected: selected,
        onSelectChanged: (value) {
          setState(() {
            _selectedRowIndex = selected ? -1 : index;
          });

          if (value == true) {
            context.read<ProfileBloc>().add(NewAmortization(
                  parseStringToDouble(item['loanAmount']),
                  item['interestRate'],
                  int.tryParse(item['numberOfPayments']) ?? 0,
                ));
            Get.toNamed('/amortization');
          }
        },
        cells: [
          DataCell(Text(item['loanAmount'].toString())),
          DataCell(Text(item['date'].toString())),
          DataCell(Text(item['numberOfPayments'].toString())),
          DataCell(Text(item['interestRate'].toString())),
        ],
      );
    }).toList();
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
                  rows: _buildRows(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
