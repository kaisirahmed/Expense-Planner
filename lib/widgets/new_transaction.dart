import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void _submitData(){
    if(_amountController.text.isEmpty){
      return;  
    }
    final enteredTitle = _titleController.text;
  final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null){
      return;
    }

    widget.addTx(  
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now()
      ).then((pickedDate) {
        if(pickedDate == null){
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });        
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   amountInput = val;
              // },
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  // ignore: unnecessary_null_comparison
                  Expanded(
                    child:Text(
                      _selectedDate == null 
                      ? 'No Date choosen' 
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                  ),                  
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: const Text(
                      'Choose Date', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        ),
                      ), 
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),            
            RaisedButton(
              child: const Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button?.color,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}
