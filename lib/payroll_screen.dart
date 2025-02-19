import 'package:flutter/material.dart';

class PayrollScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payroll')),
      body: Center(
        child: Text(
          'Payroll Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
