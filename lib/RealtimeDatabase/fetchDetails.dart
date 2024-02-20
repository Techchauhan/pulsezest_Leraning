import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pulsezest_testing/RealtimeDatabase/updateDetails.dart';

class FetchDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetched Details"),
      ),
      body: DetailsList(),
    );
  }
}

class DetailsList extends StatefulWidget {
  @override
  _DetailsListState createState() => _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
  late DatabaseReference _ref;
  late List<Map<dynamic, dynamic>> _details;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('posts');
    _details = [];
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    try {
      DataSnapshot snapshot = (await _ref.once()).snapshot;
      setState(() {
        _details = [];
        var snapshotValue = snapshot.value as Map<dynamic, dynamic>?;
        if (snapshotValue != null) {
          snapshotValue.forEach((key, value) {
            // Adding the 'id' field to the details map
            value['id'] = key;
            _details.add(value);
          });
        }
      });
    } catch (error) {
      print("Error fetching details: $error");
    }
  }

  Future<void> _deleteData(String id) async {
    try {
      await _ref.child(id).remove();
      setState(() {
        _details.removeWhere((detail) => detail['id'] == id);
      });
    } catch (error) {
      print("Error deleting data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _details.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: _details.length,
      itemBuilder: (context, index) {
        var detail = _details[index];
        return ListTile(
          title: Text(detail['name'] + " " + detail['lastName'] ?? ''),
          subtitle: Text('Num: ' + detail['Number'] ?? ''),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Navigate to the UpdateDetailsPage and pass the detail
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateDetailsPage(
                        details: detail,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Call delete function when delete button is pressed
                  _deleteData(detail['id']);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
