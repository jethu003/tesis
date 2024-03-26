import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingListAdmin extends StatelessWidget {
  const BookingListAdmin({Key? key}) : super(key: key);

  void updateBookingStatus(String bookingId, String newStatus) {
    FirebaseFirestore.instance.collection('bookings').doc(bookingId).update({
      'status': newStatus,
    }).then((value) {
      print('Booking status updated successfully.');
    }).catchError((error) {
      print('Failed to update booking status: $error');
    });
  }

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
              return Card(
                child: ListTile(
                  title: Text('Expert: ${data['expertId']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Start Time: ${startTime.toString()}'),
                      Text('End Time: ${endTime.toString()}'),
                      Text('Name: ${data['name']}'),
                      Text('Contact: ${data['contact']}'),
                      Text('Status: ${data['status']}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Update Booking Status'),
                          content: Text(
                              'Are you sure you want to approve this booking?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                updateBookingStatus(booking.id, 'approved');
                                Navigator.pop(context);
                              },
                              child: Text('Approve'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Approve'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
