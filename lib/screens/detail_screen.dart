import 'package:flutter/material.dart';
import '../models/transactions.dart';

class DetailScreen extends StatelessWidget {
  final Transactions transaction;

  const DetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(transaction.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(transaction.imageUrl), // แสดงรูปภาพ
            const SizedBox(height: 10),
            Text(
              transaction.details,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'ยุค: ${transaction.era}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'ประเทศ: ${transaction.country}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
