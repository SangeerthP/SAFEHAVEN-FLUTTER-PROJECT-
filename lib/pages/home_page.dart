import 'package:flutter/material.dart';
import 'sos_page.dart';
import 'info_page.dart';
import 'safe_places_page.dart'; // Import the new Safe Places page
import 'profile_page.dart';
// Import the Online Page (for medicine section)

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Pages for each tab
  final List<Widget> _pages = [
    SosPage(),
    InfoPage(),
    SafePlacesPage(),
    ProfilePage(),
  ];

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getAppBarTitle()), // Dynamic title based on the selected tab
        centerTitle: true,
        backgroundColor: Colors.pink, // Updated consistent app theme
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.pink, // Active icon color
        unselectedItemColor: Colors.grey, // Inactive icon color
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber_rounded),
            label: 'SOS Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Safe Places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Dynamic AppBar title based on the selected tab
  String getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'SOS Alerts';
      case 1:
        return 'Nearby Services';
      case 2:
        return 'Nearby Safe Places';
      case 3:
        return 'Profile';
      default:
        return 'Home';
    }
  }
}
