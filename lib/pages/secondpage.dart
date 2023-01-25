import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SecondPage extends StatelessWidget {
  SecondPage({super.key, required this.counter});
  int counter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Second Page')),
        body: Center(child: Text('A számláló értéke: $counter')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            counter++;
            int result = counter;
            Navigator.pop(context, result);
          },
          tooltip: 'Second Page',
          child: const Icon(Icons.add),
        ));
  }
}
