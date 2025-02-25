import 'package:flutter/material.dart';
import 'dart:io';

class ApprovalScreen extends StatefulWidget {
  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  List<Map<String, dynamic>> pendingApprovals = [
    {
      'name': 'John Doe',
      'type': 'Check-in',
      'time': '08:02',
      'date': '2025-02-24',
      'photo': File('path/to/photo.jpg'), // Dummy file path
      'location': '37.7749° N, 122.4194° W',
    },
    {
      'name': 'Jane Smith',
      'type': 'Check-out',
      'time': '17:05',
      'date': '2025-02-24',
      'photo': File('path/to/photo.jpg'),
      'location': '37.7749° N, 122.4194° W',
    },
  ];

  void _approveAttendance(int index) {
    setState(() {
      pendingApprovals.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attendance Approved ✅')),
    );
  }

  void _rejectAttendance(int index) {
    setState(() {
      pendingApprovals.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attendance Rejected ❌')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Approval')),
      body: pendingApprovals.isEmpty
          ? const Center(child: Text("Tidak ada data untuk di-approve"))
          : ListView.builder(
              itemCount: pendingApprovals.length,
              itemBuilder: (context, index) {
                final data = pendingApprovals[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(data['photo'],
                          width: 60, height: 60, fit: BoxFit.cover),
                    ),
                    title: Text(
                      '${data['name']} - ${data['type']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('🕒 ${data['time']} 📅 ${data['date']}'),
                        Text('📍 ${data['location']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check_circle,
                              color: Colors.green),
                          onPressed: () => _approveAttendance(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          onPressed: () => _rejectAttendance(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
