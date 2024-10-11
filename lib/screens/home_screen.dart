import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/transaction_provider.dart';
import 'detail_screen.dart';
import 'edit_screen.dart';
import '../models/transactions.dart';

class HomeScreen extends StatelessWidget {
  final String? era;

  const HomeScreen({Key? key, this.era}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactions = era == null
        ? Provider.of<TransactionProvider>(context).getTransaction()
        : Provider.of<TransactionProvider>(context).getTransactionByEra(era!);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(transaction: transaction),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              color: Colors.brown[100], // สีพื้นหลังของการ์ด
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: NetworkImage(transaction.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          transaction.title,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ยุค: ${transaction.era}',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, size: 20, color: Colors.brown),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditScreen(statement: transaction),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 20, color: Colors.brown),
                              onPressed: () {
                                _showDeleteConfirmationDialog(context, transaction);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Transactions transaction) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ยืนยันการลบ'),
          content: const Text('คุณแน่ใจหรือว่าต้องการลบข้อมูลนี้?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog
              },
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () {
                final provider = Provider.of<TransactionProvider>(context, listen: false);
                provider.deleteTransaction(transaction.keyID);
                Navigator.of(context).pop(); // ปิด Dialog
              },
              child: const Text('ลบ'),
            ),
          ],
        );
      },
    );
  }
}
