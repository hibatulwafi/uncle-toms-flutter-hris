import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'attendance_screen.dart';
import 'leave_screen.dart';
import 'schedule_screen.dart';
import 'payroll_screen.dart';
import 'approval_screen.dart';
import 'employee_master_screen.dart';
import 'attendance_list_screen.dart';
import 'rating_screen.dart';
import 'profile_screen.dart';

import 'widgets/dashboard_card.dart';
import 'widgets/header_widget.dart';
import 'widgets/nav_bottom_bar.dart';

class DashboardScreen extends StatefulWidget {
  final String userRole;
  final String name;
  final String position;

  const DashboardScreen({
    Key? key,
    required this.userRole,
    required this.name,
    required this.position,
  }) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildDashboardView(),
      AttendanceScreen(),
      ProfileScreen(
        userRole: widget.userRole,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Menampilkan halaman sesuai index
      bottomNavigationBar: NavBottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildDashboardView() {
    List<Map<String, dynamic>> dashboardItems = [
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
        'route': RatingScreen()
      },
    ];

    List<Map<String, dynamic>> adminItems = [
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

    return Column(
      children: [
        HeaderWidget(name: widget.name, position: widget.position),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildSectionTitle('Menu Utama'),
              _buildDashboardGrid(context, dashboardItems),
              if (widget.userRole == "admin") ...[
                const SizedBox(height: 20),
                _buildSectionTitle('Admin Panel'),
                _buildDashboardGrid(context, adminItems),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDashboardGrid(
      BuildContext context, List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
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
}
