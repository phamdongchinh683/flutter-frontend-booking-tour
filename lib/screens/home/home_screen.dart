import 'package:book_tour_app/models/tour_model.dart';
import 'package:book_tour_app/screens/tour/tour_app.dart';
import 'package:book_tour_app/services/tour_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  List<Tour> tours = [];
  String? nextCursor = '';
  String? prevCursor = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchTours(cursor: nextCursor);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (nextCursor != null) {
        _fetchTours(cursor: nextCursor); 
      }
    }
  }

  Future<void> _fetchTours({String? cursor}) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await TourService.getTour(
        cursor: cursor ?? '',
        direction: 'next',
      );
      setState(() {
        tours.addAll(response.datas);
        nextCursor = response.nextCursor;
        prevCursor = response.prevCursor;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching tours: $e');
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
              Navigator.pushNamed(context, '/signup');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: tours.length + 1,
              itemBuilder: (context, index) {
                if (index == tours.length) {
                  return _isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink();
                }

                final tour = tours[index];
                final publicId = tour.images[0]!;
                return ListTile(
                  title: Text(tour.city),
                  subtitle: Text(tour.attractions),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TourApp(id: tour.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
