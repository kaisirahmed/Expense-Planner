import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {  

  //late String titleInput;
  //late String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'Last Seen Tutorial', amount: 95.00, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Jacket Black', amount: 58.99, date: DateTime.now())
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx =
        Transaction(
          title: txTitle, 
          amount: txAmount, 
          date: DateTime.now(),
          id: DateTime.now().toString(),
        );

        setState(() {
          _userTransactions.add(newTx); 
        });
  }


  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        onTap:() {}, 
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
        );
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.red,
        title: Text('Personal Expenses',),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: const Card(
                  color: Colors.blue,
                  child: Text('CHART'),
                  elevation: 5,
                ),
              ),
              TransactionList(_userTransactions),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
          ),
      );
  }
}

