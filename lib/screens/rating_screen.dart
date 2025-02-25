import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> customerReviews = [
    {
      'name': 'John Doe',
      'rating': 5.0,
      'comment':
          'Barbershop terbaik! Potongan rambut sangat rapi dan pelayanan ramah.',
      'date': '2025-02-23',
    },
    {
      'name': 'Jane Smith',
      'rating': 4.5,
      'comment':
          'Hasil cukur sangat bagus, tapi sedikit antre. Akan kembali lagi!',
      'date': '2025-02-22',
    },
    {
      'name': 'Michael Lee',
      'rating': 4.0,
      'comment': 'Pelayanan oke, tapi ruang tunggu perlu diperbaiki.',
      'date': '2025-02-20',
    },
    {
      'name': 'Sarah Connor',
      'rating': 5.0,
      'comment': 'Hasil cukur keren, cepat, dan profesional! 👍',
      'date': '2025-02-18',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Rating - Caster Barbershop')),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: customerReviews.length,
        itemBuilder: (context, index) {
          final review = customerReviews[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(review['date'],
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RatingBarIndicator(
                    rating: review['rating'],
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 20,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    review['comment'],
                    style: const TextStyle(fontSize: 14),
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
