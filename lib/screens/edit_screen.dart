import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transactions.dart';
import '../provider/transaction_provider.dart';

class EditScreen extends StatefulWidget {
  final Transactions statement; // รับข้อมูลที่ต้องการแก้ไข

  const EditScreen({Key? key, required this.statement}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController detailsController;
  late TextEditingController countryController;
  late TextEditingController imageUrlController;
  String? selectedEra;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.statement.title);
    detailsController = TextEditingController(text: widget.statement.details);
    countryController = TextEditingController(text: widget.statement.country);
    imageUrlController = TextEditingController(text: widget.statement.imageUrl);
    selectedEra = widget.statement.era; // ค่าเริ่มต้นสำหรับ Dropdown
  }

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    countryController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขสถานที่'),
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
                    var updatedStatement = Transactions(
                      keyID: widget.statement.keyID, // ใช้ค่า keyID เดิม
                      title: titleController.text,
                      details: detailsController.text,
                      country: countryController.text,
                      era: selectedEra ?? widget.statement.era, // ตรวจสอบค่า era
                      imageUrl: imageUrlController.text,
                    );

                    var provider = Provider.of<TransactionProvider>(context, listen: false);
                    provider.updateTransaction(updatedStatement);
                    Navigator.pop(context); // กลับไปหน้าหลัก
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
