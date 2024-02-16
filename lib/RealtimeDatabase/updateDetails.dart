import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UpdateDetailsPage extends StatefulWidget {
  final Map<dynamic, dynamic> details;

  UpdateDetailsPage({required this.details});

  @override
  _UpdateDetailsPageState createState() => _UpdateDetailsPageState();
}

class _UpdateDetailsPageState extends State<UpdateDetailsPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _numberController;
  late DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.details['firstName']);
    _lastNameController = TextEditingController(text: widget.details['lastName']);
    _numberController = TextEditingController(text: widget.details['Number']);
    _ref = FirebaseDatabase.instance.reference().child('posts');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  void _updateDetails() {
    try {
      // Extracting the ID from details map
      var id = widget.details['id'];
      _ref.child(id).update({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'Number': _numberController.text,
      }).then((_) {
        Navigator.of(context).pop(); // Pop the update page after successful update
      }).catchError((error) {
        print("Failed to update details: $error");
        // Handle error, show snackbar, etc.
      });
    } catch (e) {
      print("Exception occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Number'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _updateDetails,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
