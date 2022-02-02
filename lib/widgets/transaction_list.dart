import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionEmptyState extends StatelessWidget {
  const TransactionEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'No transaction added yet!',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 200,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}

class TransactionListView extends StatelessWidget {
  const TransactionListView(this.items, this.deleteItem, {Key? key})
      : super(key: key);

  final List<TransactionModel> items;
  final Function deleteItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, index) {
        TransactionModel item = items[index];

        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: FittedBox(
                    child: Text('\$${item.amount.toStringAsFixed(2)}'),
                  )),
            ),
            title: Text(
              item.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              DateFormat.yMMMEd().format(item.date),
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            trailing: IconButton(
              onPressed: () => deleteItem(item.id),
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ),
        );

        // return Card(
        //   child: Row(
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.symmetric(
        //           vertical: 10,
        //           horizontal: 15,
        //         ),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             color: Theme.of(context).primaryColor,
        //             width: 2,
        //           ),
        //         ),
        //         padding: const EdgeInsets.all(10),
        //         child: Text(
        //           '\$${item.amount.toStringAsFixed(2)}',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 20,
        //             color: Theme.of(context).primaryColor,
        //           ),
        //         ),
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             item.title,
        //             style: Theme.of(context).textTheme.headline6,
        //           ),
        //           Text(
        //             DateFormat.yMMMEd().format(item.date),
        //             style: const TextStyle(
        //               fontWeight: FontWeight.w300,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }
}

class TransactionList extends StatelessWidget {
  const TransactionList(this.items, this.deleteItem, {Key? key})
      : super(key: key);

  final List<TransactionModel> items;
  final Function deleteItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: items.isEmpty
          ? const TransactionEmptyState()
          : TransactionListView(items, deleteItem),
    );
  }
}
