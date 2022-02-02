import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './char_bar.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  final List<TransactionModel> recentTransactions;

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        TransactionModel transaction = recentTransactions[i];

        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalSum += transaction.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((element) {
            return Flexible(
              fit: FlexFit.tight,
              child: CharBar(
                element['day'],
                element['amount'],
                totalSpending == 00.00
                    ? 00.00
                    : element['amount'] / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
