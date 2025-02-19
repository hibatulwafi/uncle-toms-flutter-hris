import 'package:flutter/material.dart';
import 'attendance_screen.dart';
import 'leave_screen.dart';
import 'schedule_screen.dart';
import 'payroll_screen.dart';
import 'approval_screen.dart';
import 'employee_master_screen.dart';
import 'attendance_list_screen.dart';

void main() {
  runApp(HRISApp());
}

class HRISApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> dashboardItems = [
    {
      'title': 'Attendance',
      'icon': Icons.access_time,
      'color': Colors.orange,
      'route': AttendanceScreen()
    },
    {
      'title': 'Leave',
      'icon': Icons.beach_access,
      'color': Colors.green,
      'route': LeaveScreen()
    },
    {
      'title': 'Schedule',
      'icon': Icons.calendar_today,
      'color': Colors.blue,
      'route': ScheduleScreen()
    },
    {
      'title': 'Payroll',
      'icon': Icons.monetization_on,
      'color': Colors.red,
      'route': PayrollScreen()
    },
    {
      'title': 'Your Rating',
      'icon': Icons.star,
      'color': Colors.amber,
      'route': PayrollScreen()
    },
  ];

  final List<Map<String, dynamic>> adminItems = [
    {
      'title': 'Approval',
      'icon': Icons.check_circle,
      'color': Colors.purple,
      'route': ApprovalScreen()
    },
    {
      'title': 'Karyawan',
      'icon': Icons.people,
      'color': Colors.teal,
      'route': EmployeeMasterScreen()
    },
    {
      'title': 'Absensi',
      'icon': Icons.list,
      'color': Colors.deepOrange,
      'route': AttendanceListScreen()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader("John Doe", "Software Engineer"),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildCheckInWarning(
                    DateTime(2025, 2, 18, 8, 30)), // Clock In jam 08:30
                SizedBox(height: 10),
                _buildSectionTitle('Menu Utama'),
                _buildDashboardGrid(context, dashboardItems),
                SizedBox(height: 20),
                _buildSectionTitle('Admin Panel'),
                _buildDashboardGrid(context, adminItems),
                SizedBox(height: 20),
                _buildAnnouncements(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader(String name, String position) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?img=3'),
              ),
              SizedBox(width: 12), // Beri jarak antara avatar dan teks
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome,',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    position, // Menampilkan jabatan
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.notifications,
              color: Colors.white, size: 28), // Tambahan ikon notifikasi
        ],
      ),
    );
  }

  Widget _buildCheckInWarning(DateTime? clockInTime) {
    DateTime now = DateTime.now();
    Duration workDuration =
        clockInTime != null ? now.difference(clockInTime) : Duration.zero;

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clock In: ${clockInTime != null ? "${clockInTime.hour}:${clockInTime.minute}" : "Belum Clock In"}',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  'Durasi Bekerja: ${workDuration.inHours}h ${workDuration.inMinutes.remainder(60)}m',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  'Jangan lupa untuk melakukan Attend Out!',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAnnouncements() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('📢 Holiday & Leave Notice',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(
              'Cuti bersama akan berlangsung pada 25-26 Desember 2024. Harap atur jadwal cuti Anda sebelumnya.'),
          SizedBox(height: 10),
          Text('💰 Payroll Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(
              'Gaji bulan ini akan dibayarkan pada 30 Desember 2024. Pastikan informasi rekening Anda sudah diperbarui.'),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_time), label: 'Attendance'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'Profile'),
      ],
    );
  }
}

Widget _buildDashboardGrid(
    BuildContext context, List<Map<String, dynamic>> items) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // Ubah menjadi 3 kolom
      crossAxisSpacing: 8, // Kurangi jarak antar kolom agar lebih rapat
      mainAxisSpacing: 8, // Kurangi jarak antar baris agar lebih rapat
    ),
    itemCount: items.length,
    itemBuilder: (context, index) {
      return DashboardCard(
        title: items[index]['title'],
        icon: items[index]['icon'],
        color: items[index]['color'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => items[index]['route']),
          );
        },
      );
    },
  );
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        shadowColor: color.withOpacity(0.4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color.withOpacity(0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.all(12), // Kurangi padding agar lebih kecil
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white), // Kecilkan ukuran ikon
              SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14, // Kecilkan ukuran teks
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
