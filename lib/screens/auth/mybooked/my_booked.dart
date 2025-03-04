import 'package:book_tour_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class MyBooked extends StatefulWidget {
  @override
  _BookedToursScreenState createState() => _BookedToursScreenState();
}

class _BookedToursScreenState extends State<MyBooked> {
  late Future<List<Map<String, dynamic>>> _bookedTours;

  @override
  void initState() {
    super.initState();
    _bookedTours = AuthService().myBookedTour();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Booked Tours')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _bookedTours,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(
                    '${snapshot.error.toString().substring(26).toString().substring(15)}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tours booked yet.'));
          }

          final bookedTours = snapshot.data!;

          return ListView.builder(
            itemCount: bookedTours.length,
            itemBuilder: (context, index) {
              final tour = bookedTours[index];
              final tourId = tour['_id'];
              final guideId = tour['guide_id'];
              final numberOfVisitors = tour['number_visitors'];
              final startTour = DateTime.parse(tour['start_tour']);
              final startTime = tour['time']['start_time'];
              final endTime = tour['time']['end_time'];
              final city =
                  tour['tour_id'] != null ? tour['tour_id']['city'] : 'N/A';

              return ListTile(
                title: Text('Tour ID: $tourId'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('City: $city'),
                    Text('Guide ID: ${guideId ?? 'Not Assigned'}'),
                    Text('Number of Visitors: $numberOfVisitors'),
                    Text('Start Tour: ${startTour.toLocal()}'),
                    Text('Start Time: $startTime'),
                    Text('End Time: $endTime'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
