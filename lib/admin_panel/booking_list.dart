import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingListPage extends StatelessWidget {
  const BookingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No bookings available.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final booking = snapshot.data!.docs[index];
              final data = booking.data() as Map<String, dynamic>;
              DateTime startTime = (data['startTime'] as Timestamp).toDate();
              DateTime endTime = (data['endTime'] as Timestamp).toDate();
              // Fetch expert name based on expertId
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('experts')
                    .doc(data['expertId'])
                    .get(),
                builder:
                    (context, AsyncSnapshot<DocumentSnapshot> expertSnapshot) {
                  if (expertSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (expertSnapshot.hasError) {
                    return Text('Error: ${expertSnapshot.error}');
                  }
                  if (!expertSnapshot.hasData || !expertSnapshot.data!.exists) {
                    return Text('Expert not found');
                  }
                  final expertData =
                      expertSnapshot.data!.data() as Map<String, dynamic>;
                  final expertName = expertData['name'];

                  // Determine text color based on booking status
                  Color textColor =
                      data['status'] == 'approved' ? Colors.green : Colors.red;

                  // Apply TextStyle to each Text widget
                  TextStyle textStyle = TextStyle(
                    letterSpacing: 1,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                    fontFamily: 'Schyler',
                  );

                  return Card(
                    child: ListTile(
                      title: Text(
                        'Expert: $expertName',
                        style: textStyle,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Time: ${startTime.toString()}',
                            style: textStyle,
                          ),
                          Text(
                            'End Time: ${endTime.toString()}',
                            style: textStyle,
                          ),
                          Text(
                            'Name: ${data['name']}',
                            style: textStyle,
                          ),
                          Text(
                            'Contact: ${data['contact']}',
                            style: textStyle,
                          ),
                          Text(
                            'Status: ${data['status']}',
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
