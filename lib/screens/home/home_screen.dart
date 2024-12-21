import 'package:book_tour_app/models/tour_model.dart';
import 'package:book_tour_app/screens/tour/tour_app.dart';
import 'package:book_tour_app/screens/widgets/button_paginate.dart';
import 'package:book_tour_app/services/tour_service.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  List<Tour> tours = [];
  String? nextCursor;
  String? prevCursor;

  @override
  void initState() {
    super.initState();
    _fetchTours(cursor: nextCursor, direction: 'next');
  }

  Future<void> _fetchTours({String? cursor, required String direction}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response =
          await TourService.getTour(cursor: cursor ?? '', direction: direction);
      setState(() {
        if (direction == 'next') {
          tours = response.datas;
        } else if (direction == 'prev') {
          tours = response.datas;
        }
        nextCursor = response.nextCursor;
        prevCursor = response.prevCursor;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tours'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: tours.length,
              itemBuilder: (context, index) {
                final tour = tours[index];
                final imageExists = tour.images.isNotEmpty;

                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: imageExists
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CldImageWidget(
                              publicId: tour.images[0],
                              width: 80,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.image_not_supported,
                            size: 40, color: Colors.grey),
                    title: Text(
                      tour.city,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF9900)),
                    ),
                    subtitle: Text(
                      "Attractions: ${tour.attractions}\nDuration: ${tour.days} days",
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TourApp(id: tour.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonPaginate(
                  buttonText: "Prev",
                  onPressed: prevCursor != null && !_isLoading
                      ? () {
                          _fetchTours(cursor: prevCursor, direction: 'prev');
                        }
                      : null,
                ),
                ButtonPaginate(
                  buttonText: "Next",
                  onPressed: nextCursor != null && !_isLoading
                      ? () {
                          _fetchTours(cursor: nextCursor, direction: 'next');
                        }
                      : null,
                )
              ],
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
