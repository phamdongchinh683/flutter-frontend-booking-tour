import 'package:book_tour_app/models/tour_detail_info_model.dart';
import 'package:book_tour_app/screens/tour/booktoour/book_tour.dart';
import 'package:book_tour_app/services/tour_service.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:flutter/material.dart';

class TourApp extends StatefulWidget {
  final String id;

  const TourApp({super.key, required this.id});

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourApp> {
  bool _isLoading = true;
  TourDetailInfo? tour;

  @override
  void initState() {
    super.initState();
    _fetchTourDetails();
  }

  Future<void> _fetchTourDetails() async {
    try {
      final response = await TourService.getTourDetails(id: widget.id);
      setState(() {
        tour = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching tour details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9900),
        title: _isLoading
            ? const Text('Loading...')
            : Text(
                tour?.city ?? 'Tour Detail',
                style: const TextStyle(color: Colors.white),
              ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: tour == null
                  ? const Center(child: Text('No tour data available'))
                  : ListView(
                      children: [
                        if (tour!.images.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CldImageWidget(
                              publicId: tour!.images[0],
                              width: 400,
                              height: 250,
                            ),
                          ),
                        const SizedBox(height: 16),
                        Text(
                          'City: ${tour!.city}',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF9900)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Attractions: ${tour!.attractions}',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Duration: ${tour!.days} days',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Guide: ${tour!.guide.fullName.firstName} ${tour!.guide.fullName.lastName}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Prices:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF9900),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Adult Price: \$${tour!.prices.adult}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Child Price: \$${tour!.prices.child}',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookTourScreen(tourId: widget.id),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF9900),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Book Now',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Tour Highlights:',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF9900)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '• Explore famous attractions like ${tour!.attractions}.\n• Enjoy local cuisine and culture.\n• Visit the most beautiful landmarks in ${tour!.city}.',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Tour Dates:',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF9900)),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Available Dates: January 2024, February 2024, March 2024',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Customer Reviews:',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF9900)),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '★★★★☆ - "Amazing experience! The tour was well-organized and the guide was very informative."',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
            ),
      backgroundColor: const Color(0xFFFFFFFF),
    );
  }
}
