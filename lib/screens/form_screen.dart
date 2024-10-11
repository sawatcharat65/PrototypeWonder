import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transactions.dart';
import '../provider/transaction_provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  final countryController = TextEditingController();
  final imageUrlController = TextEditingController();

  String selectedEra = 'โบราณ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มสถานที่'),
        backgroundColor: Colors.brown[100],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ชื่อสถานที่'),
                controller: titleController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'รายละเอียดสถานที่'),
                controller: detailsController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ประเทศ'),
                controller: countryController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedEra,
                items: const [
                  DropdownMenuItem(value: 'โบราณ', child: Text('ยุคโบราณ')),
                  DropdownMenuItem(value: 'ยุคกลาง', child: Text('ยุคกลาง')),
                  DropdownMenuItem(value: 'ยุคใหม่', child: Text('ยุคใหม่')),
                ],
                decoration: const InputDecoration(labelText: 'ยุค'),
                onChanged: (value) {
                  setState(() {
                    selectedEra = value!;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'URL ของรูปภาพ'),
                controller: imageUrlController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอก URL ของรูปภาพ';
                  }
                  return null;
                },
              ),
              TextButton(
                child: const Text('บันทึกข้อมูล'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var newStatement = Transactions(
                      title: titleController.text,
                      details: detailsController.text,
                      country: countryController.text,
                      era: selectedEra,
                      imageUrl: imageUrlController.text,
                    );

                    var provider = Provider.of<TransactionProvider>(context, listen: false);
                    provider.addTransaction(newStatement);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
