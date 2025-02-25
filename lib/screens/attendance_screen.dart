import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<Map<String, dynamic>> _attendanceHistory = [];

  Future<void> _takeAttendance(String type) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      Position position = await _determinePosition();
      String timestamp = DateTime.now().toLocal().toString();

      setState(() {
        _attendanceHistory.add({
          'type': type,
          'time': timestamp.substring(11, 16), // Format HH:MM
          'date': timestamp.substring(0, 10), // Format YYYY-MM-DD
          'photo': File(pickedFile.path),
          'location': '${position.latitude}, ${position.longitude}',
        });
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Tombol Camera Check-in & Check-out
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _takeAttendance('Check-in'),
                icon: const Icon(Icons.camera_alt),
                label: const Text("Check-in"),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () => _takeAttendance('Check-out'),
                icon: const Icon(Icons.camera_alt),
                label: const Text("Check-out"),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // List Riwayat Attendance
          Expanded(
            child: _attendanceHistory.isEmpty
                ? const Center(child: Text("Belum ada riwayat attendance"))
                : ListView.builder(
                    itemCount: _attendanceHistory.length,
                    itemBuilder: (context, index) {
                      final data = _attendanceHistory[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(data['photo'],
                                width: 60, height: 60, fit: BoxFit.cover),
                          ),
                          title: Text(
                            '${data['type']} - ${data['time']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('📍 ${data['location']}'),
                          trailing: Text(
                            data['date'],
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
