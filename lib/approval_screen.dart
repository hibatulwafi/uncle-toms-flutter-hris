import 'package:flutter/material.dart';

class ApprovalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: Center(
        child: Text(
          'Attendance Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
