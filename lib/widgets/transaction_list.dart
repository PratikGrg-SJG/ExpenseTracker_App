import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print("buiild() TransactionList");
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return transactions.isEmpty
            ? Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.7,
                    // color: Colors.red,
                    child: Image.asset(
                      "lib/images/no-results-found.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.3,
                    child: Text(
                      "No Expenses added yet!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    // color: Colors.grey[100],
                    elevation: 0,
                    margin: EdgeInsets.symmetric(
                      vertical: 1,
                      horizontal: 5,
                    ),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (ctx) {
                              deleteTx(transactions[index].id);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text("Rs ${transactions[index].amount}"),
                            ),
                          ),
                        ),
                        title: Text(
                          transactions[index].title!,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date!),
                        ),

                        //if you want it on card itself below is the code

                        // trailing: IconButton(
                        //   icon: Icon(Icons.delete),
                        //   color: Theme.of(context).errorColor,
                        //   onPressed: () => deleteTx(transactions[index].id),
                        // ),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              );
      },
    );
  }
}
