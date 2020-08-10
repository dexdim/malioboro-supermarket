import 'package:flutter/material.dart';
//import 'package:scoped_model/scoped_model.dart';
import 'ScopeManage.dart';

class Counter extends StatefulWidget {
  final Data data;
  Counter({this.data});
  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  static int counter = 1;
  @override
  Widget build(BuildContext context) {
    //return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      SizedBox(height: 100),
      GestureDetector(
        onTap: () {
          setState(() {
            counter -= 1;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.orange[200]),
          ),
          child: Icon(Icons.remove),
        ),
      ),
      SizedBox(width: 15.0),
      Text(
        "$counter",
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(width: 15.0),
      GestureDetector(
        onTap: () {
          setState(() {
            counter += 1;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.orange[200]),
          ),
          child: Icon(Icons.add),
        ),
      ),
    ]);
  }
}
