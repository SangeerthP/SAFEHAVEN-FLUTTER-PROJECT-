import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SosPage extends StatefulWidget {
  @override
  _SosPageState createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  List<Map<String, String>> savedContacts = [];
  final String infobipApiKey = "fca867d96870a0683546199558000c17-4b40b90e-9c60-4efa-affc-227321b4e3e8"; // Replace with your Infobip API key
  final String senderId = "InfoSMS"; // Replace with your registered Sender ID or "InfoSMS" for testing
  final String baseUrl = "https://lq6vw5.api.infobip.com/sms/2/text/single"; // Updated full endpoint URL

  void _showAddContactDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Emergency Contact'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Contact Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty) {
                  setState(() {
                    savedContacts.add({
                      'name': nameController.text,
                      'phone': phoneController.text,
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Contact Added Successfully!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteContact(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Contact'),
          content: Text('Are you sure you want to delete this contact?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  savedContacts.removeAt(index);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Contact Deleted')),
                );
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Send SOS message using Infobip API
  void _sendSosMessage() async {
    if (savedContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No contacts to send SOS message.')),
      );
      return;
    }

    String message = "SOS Alert! I need help. Please contact me immediately.";
    for (var contact in savedContacts) {
      String phone = contact['phone']!;
      try {
        final response = await http.post(
          Uri.parse(baseUrl),
          headers: {
            'Authorization': 'App $infobipApiKey',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            "from": senderId,
            "to": [phone], // Infobip expects an array for the "to" field
            "text": message,
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 202) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('SOS Message Sent to ${contact['name']}!')),
          );
        } else {
          // Log the error for debugging
          print('Error: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to send message to ${contact['name']}: ${response.body}',
              ),
            ),
          );
        }
      } catch (error) {
        // Catch HTTP or connection errors
        print('HTTP error: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Alerts'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddContactDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _sendSosMessage,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          'SOS',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Tap to Send SOS Message',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Saved Contacts',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: savedContacts.isEmpty
                      ? Center(child: Text('No contacts added yet'))
                      : ListView.builder(
                          itemCount: savedContacts.length,
                          itemBuilder: (context, index) {
                            final contact = savedContacts[index];
                            return ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                                backgroundColor: Colors.pink[100],
                              ),
                              title: Text(contact['name']!),
                              subtitle: Text(contact['phone']!),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _confirmDeleteContact(index);
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
