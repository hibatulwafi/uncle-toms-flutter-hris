import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatelessWidget {
  final List<Map<String, dynamic>> scheduleList = [
    {
      'title': 'Cuti Bersama Lebaran',
      'date': DateTime(2025, 4, 8),
      'description': 'Libur nasional untuk merayakan Hari Raya Idul Fitri.',
      'icon': Icons.beach_access,
      'color': Colors.green,
    },
    {
      'title': 'Meeting Bulanan',
      'date': DateTime(2025, 3, 1),
      'description': 'Evaluasi kinerja tim dan strategi bulan depan.',
      'icon': Icons.meeting_room,
      'color': Colors.blue,
    },
    {
      'title': 'Pelatihan Barber Caster',
      'date': DateTime(2025, 2, 28),
      'description': 'Pelatihan teknik cukur terbaru dan pelayanan pelanggan.',
      'icon': Icons.school,
      'color': Colors.orange,
    },
    {
      'title': 'Libur Tahun Baru',
      'date': DateTime(2025, 1, 1),
      'description': 'Libur nasional untuk perayaan Tahun Baru.',
      'icon': Icons.celebration,
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jadwal Kegiatan')),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: scheduleList.length,
        itemBuilder: (context, index) {
          final schedule = scheduleList[index];
          final formattedDate =
              DateFormat('dd MMMM yyyy').format(schedule['date']);

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: schedule['color'].withOpacity(0.2),
                child: Icon(schedule['icon'], color: schedule['color']),
              ),
              title: Text(schedule['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formattedDate,
                      style: const TextStyle(color: Colors.grey)),
                  Text(schedule['description']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
