import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_text_button.dart';

class NewTrasacrtion extends StatefulWidget {
  const NewTrasacrtion(this.addTransaction, {Key? key}) : super(key: key);

  final Function addTransaction;

  @override
  State<NewTrasacrtion> createState() => _NewTrasacrtionState();
}

class _NewTrasacrtionState extends State<NewTrasacrtion> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitHandler() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final titleValue = _titleController.text;
    final amountValue = double.parse(_amountController.text);

    if (titleValue.isEmpty || amountValue <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(titleValue, amountValue, _selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                // onChanged: (val) => titleInput = val,
                onSubmitted: (_val) => _submitHandler,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                // onChanged: (val) => amountInput = val,
                onSubmitted: (_val) => _submitHandler,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date chosen!'
                            : 'Picked date: ${DateFormat.yMd().format(_selectedDate!)}',
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date', _openDatePicker),
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      child: const Text('Add Transaction'),
                      color: Theme.of(context).primaryColor,
                      onPressed: _submitHandler,
                    )
                  : ElevatedButton(
                      child: const Text('Add Transaction'),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        textStyle: TextStyle(
                          color: Theme.of(context).textTheme.button?.color,
                        ),
                      ),
                      onPressed: _submitHandler,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
