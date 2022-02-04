import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './new_transaction.dart';
// import './transaction_list.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<TransactionModel> items = [];

  void _addTransaction(String newTitle, double newAmount) {
    final newTransaction = TransactionModel(
      id: DateTime.now().toString(),
      title: newTitle,
      amount: newAmount,
      date: DateTime.now(),
    );

    setState(() {
      items.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTrasacrtion(_addTransaction),
        // TransactionList(items),
      ],
    );
  }
}
