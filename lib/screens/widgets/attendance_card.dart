import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  final String checkInTime;
  final String checkOutTime;
  final String warningMessage;
  final bool isCheckedOut;

  const AttendanceCard({
    Key? key,
    required this.checkInTime,
    required this.checkOutTime,
    required this.warningMessage,
    this.isCheckedOut = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String todayDate = "2 Maret 2025";

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tanggal Hari Ini
            Text(
              todayDate,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const Divider(),

            // Header: "Check-in | Check-out"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeaderText("Check-in"),
                _buildHeaderText("Check-out"),
              ],
            ),
            const SizedBox(height: 8),

            // Data: "08:02 | -- : --"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeText(checkInTime),
                _buildTimeText(isCheckedOut ? checkOutTime : "-- : --"),
              ],
            ),
            const SizedBox(height: 12),

            // Warning Message (hanya tampil jika belum check-out)
            if (!isCheckedOut)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.warning, color: Colors.orange, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    warningMessage,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Text Styling untuk Header "Check-in | Check-out"
  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    );
  }

  // Text Styling untuk Waktu Check-in / Check-out
  Widget _buildTimeText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20, // Lebih besar
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
