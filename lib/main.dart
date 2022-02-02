import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: const TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: Colors.amber,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TransactionModel> _items = [];
  List<TransactionModel> get _recentItems => _items
      .where(
        (element) => element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        ),
      )
      .toList();

  void _addTransaction(String newTitle, double newAmount, DateTime newDate) {
    final newTransaction = TransactionModel(
      id: DateTime.now().toString(),
      title: newTitle,
      amount: newAmount,
      date: newDate,
    );

    setState(() {
      _items.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _items.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_builderContext) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: NewTrasacrtion(_addTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Flutter Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(_recentItems),
            TransactionList(_items, _deleteTransaction),
          ],
        ),
      ),
    );
  }
}
