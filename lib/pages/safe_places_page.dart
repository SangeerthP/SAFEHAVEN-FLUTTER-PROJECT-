import 'package:flutter/material.dart';

class SafePlacesPage extends StatefulWidget {
  const SafePlacesPage({super.key});

  @override
  State<SafePlacesPage> createState() => _SafePlacesPageState();
}

class _SafePlacesPageState extends State<SafePlacesPage> {
  String selectedOption = "Police Station";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Row(
        children: [
          // Left Side Menu
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            color: Colors.orange[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Nearby Safe Places',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildOptionTile("Police Station"),
                _buildOptionTile("Hospital"),
                _buildOptionTile("Petrol Pump"),
              ],
            ),
          ),

          // Right Side Content
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _getImagePath(selectedOption),
                    height: 500,
                    width: 450,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 250,
                        color: Colors.red,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    selectedOption,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(String option) {
    return ListTile(
      title: Text(
        option,
        style: TextStyle(
          color: selectedOption == option ? Colors.orange : Colors.black,
          fontWeight:
              selectedOption == option ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        setState(() {
          selectedOption = option;
        });
      },
    );
  }

  String _getImagePath(String option) {
    switch (option) {
      case "Police Station":
        return "lib/images/police.jpg";
      case "Hospital":
        return "lib/images/hospital.jpg";
      case "Petrol Pump":
        return "lib/images/petrol.jpg";
      default:
        return "lib/images/police.jpg";
    }
  }
}
