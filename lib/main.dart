import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/transaction_provider.dart';
import 'screens/home_screen.dart';
import 'screens/form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'สถานที่สำคัญ',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WonderS'),
          bottom: const TabBar(
            tabs: [
              Tab(text: "ทั้งหมด"),
              Tab(text: "ยุคโบราณ"),
              Tab(text: "ยุคกลาง"),
              Tab(text: "ยุคใหม่"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            HomeScreen(era: 'โบราณ'),
            HomeScreen(era: 'ยุคกลาง'),
            HomeScreen(era: 'ยุคใหม่'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
