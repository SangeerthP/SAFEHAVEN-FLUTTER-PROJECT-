import 'package:flutter/material.dart';

class HomePageee extends StatelessWidget {
  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. Looney",
      "specialty": "Surgeon",
      "rating": 4.9,
      "image": "lib/images/doctor1.jpg"
    },
    {
      "name": "Dr. Smith",
      "specialty": "Cardiologist",
      "rating": 4.7,
      "image": "lib/images/doctor2.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.pink, // Changed to pink
        title: Text('Your Health is Our First Priority',
            style: TextStyle(fontSize: 16)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.notifications))],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            TextField(
              decoration: InputDecoration(
                hintText: "Search here...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Recommended Doctors
            Text("Recommended Doctors",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Column(
              children: doctors.map((doctor) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailPage(doctor: doctor),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(doctor["image"]),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(doctor["name"],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(doctor["specialty"],
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.yellow, size: 16),
                                  SizedBox(width: 5),
                                  Text("${doctor["rating"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class DoctorDetailPage extends StatefulWidget {
  final Map<String, dynamic> doctor;

  DoctorDetailPage({required this.doctor});

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;

  final List<String> dates = ["8 DEC", "9 DEC", "10 DEC", "11 DEC"];
  final List<String> times = ["8:00 AM", "9:00 AM", "10:00 AM", "11:00 AM"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink, // Pink color
        title: Text(widget.doctor["name"]),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(widget.doctor["image"]),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(widget.doctor["name"],
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(widget.doctor["specialty"],
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Patients: 1.8k", style: TextStyle(fontSize: 16)),
                Text("Experience: 10 yr", style: TextStyle(fontSize: 16)),
                Text("⭐ ${widget.doctor["rating"]}", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
            Text("Book Date",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(dates.length, (index) {
                return ChoiceChip(
                  label: Text(dates[index]),
                  selected: selectedDateIndex == index,
                  onSelected: (_) {
                    setState(() => selectedDateIndex = index);
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            Text("Book Time",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(times.length, (index) {
                return ChoiceChip(
                  label: Text(
                    times[index],
                    style: TextStyle(
                      color: selectedTimeIndex == index
                          ? Colors.red // Booked time is red
                          : Colors.green, // Available time is green
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selected: selectedTimeIndex == index,
                  selectedColor: Colors.pink[50], // Light pink background
                  onSelected: (_) {
                    setState(() => selectedTimeIndex = index);
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Appointment Booked Successfully!"),
                  ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink, minimumSize: Size(200, 50)),
                child: Text("Book Appointment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
