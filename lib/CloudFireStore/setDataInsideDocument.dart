import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetDataInDocumentPage extends StatefulWidget {
  @override
  _SetDataInDocumentPageState createState() => _SetDataInDocumentPageState();
}

class _SetDataInDocumentPageState extends State<SetDataInDocumentPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Data In Document'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _setDataInDocument();
              },
              child: Text('Set Data'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setDataInDocument() async {
    try {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      // Check if any field is empty
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      // Set data in Cloud Firestore document
      await _firestore.collection('users').doc('f4a0dL2znnhOQfpZZrgJ').collection('school').doc().set({
        'SchoolName': name,
        'SchoolEmail': email,
        'password': password,
      });

      // Clear input fields
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();

      // Show success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Data set successfully in document.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      print('Error setting data in document: $error');
      // Show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while setting data in document. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
