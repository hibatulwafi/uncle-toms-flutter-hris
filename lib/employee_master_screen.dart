import 'package:flutter/material.dart';

class EmployeeMasterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leave')),
      body: Center(
        child: Text(
          'Leave Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
