import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:provider/provider.dart';
import '../provider/transaction_provider.dart';
import 'edit_screen.dart';

class DetailScreen extends StatelessWidget {
  final Transactions transaction;

  const DetailScreen({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(transaction.title, style: const TextStyle(color: Colors.brown)),
        backgroundColor: Colors.brown[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.brown),
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
            icon: const Icon(Icons.delete, color: Colors.brown),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('ยืนยันการลบ'),
                  content: const Text('คุณแน่ใจหรือไม่ว่าต้องการลบข้อมูลนี้?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // ปิด dialog
                      },
                      child: const Text('ยกเลิก'),
                    ),
                    TextButton(
                      onPressed: () {
                        // ลบข้อมูลที่เลือก
                        Provider.of<TransactionProvider>(context, listen: false).deleteTransaction(transaction.keyID);
                        Navigator.of(context).pop(); // ปิด dialog
                        Navigator.of(context).pop(); // กลับไปที่หน้าหลัก
                      },
                      child: const Text('ยืนยัน'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: NetworkImage(transaction.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                transaction.title,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              const SizedBox(height: 8),
              Text(
                'รายละเอียด: ${transaction.details}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'ยุค: ${transaction.era}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'ประเทศ: ${transaction.country}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
