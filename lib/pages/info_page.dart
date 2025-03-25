import 'package:flutter/material.dart';
import 'package:mini/pages/docappoinment/doc.dart'; // Importing doc.dart
import 'medicine/online.dart'; // Importing online.dart for the medicine shop page

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Services')),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCard('Medicine Shops', Icons.local_pharmacy, context),
          _buildCard('Doctor Appointments', Icons.medical_services, context),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          if (title == 'Medicine Shops') {
            // Navigate to the OnlinePage (online.dart) when "Medicine Shops" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePagee()), // HomePagee is from online.dart
            );
          } else if (title == 'Doctor Appointments') {
            // Navigate to the HomePageee (defined in doc.dart)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePageee()), // HomePageee is from doc.dart
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
