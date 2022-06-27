//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
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
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).headline6,
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: Colors.amber),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  

  //late String titleInput;
  //late String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'Last Seen Tutorial', amount: 107.00, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'Jacket Black', amount: 58.99, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime choosenDate) {
    final newTx =
        Transaction(
          title: txTitle, 
          amount: txAmount, 
          date: choosenDate,
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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        //backgroundColor: Colors.red,
       title: const Text(
            'Expense Planner',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
        ),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
          )
        ],
      );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height - 
                appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.4, 
                child: Chart(_recentTransactions),
                ),
              TransactionList(_userTransactions, _deleteTransaction),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
           onPressed: () => _startAddNewTransaction(context),
          ),
      );
  }
}

