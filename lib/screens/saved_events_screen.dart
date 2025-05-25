import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event.dart';
import '../utils/app_colors.dart';
import 'event_details_screen.dart';

class SavedEventsScreen extends StatefulWidget {
  const SavedEventsScreen({super.key});

  @override
  State<SavedEventsScreen> createState() => _SavedEventsScreenState();
}

class _SavedEventsScreenState extends State<SavedEventsScreen> {
  List<Event> _savedEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedEvents();
  }

  Future<void> _loadSavedEvents() async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final savedEventIds = prefs.getStringList('saved_events') ?? [];
    
    // For demo purposes, we'll create a larger collection of sample events
    // In a real app, you would fetch these from a database or API
    final allEvents = [
      Event(
        id: '1',
        title: 'Tech Summit 2024',
        description: 'Join us for the biggest tech event of the year featuring the latest innovations and industry leaders.',
        imageUrl: 'https://picsum.photos/200/200?random=1',
        date: DateTime.now().add(const Duration(days: 15)),
        location: 'University Auditorium',
        price: 'Rp 100.000',
        registeredCount: 120,
        category: 'Technology',
      ),
      Event(
        id: '2',
        title: 'Spring Festival',
        description: 'Celebrate the arrival of spring with music, food, and fun activities for everyone.',
        imageUrl: 'https://picsum.photos/200/200?random=2',
        date: DateTime.now().add(const Duration(days: 30)),
        location: 'University Garden',
        price: 'Rp 50.000',
        registeredCount: 85,
        category: 'Festival',
      ),
      Event(
        id: '3',
        title: 'Job Fair',
        description: 'Connect with top employers and explore career opportunities across various industries.',
        imageUrl: 'https://picsum.photos/200/200?random=3',
        date: DateTime.now().add(const Duration(days: 45)),
        location: 'Business Building',
        price: 'Free',
        registeredCount: 200,
        category: 'Career',
      ),
      Event(
        id: '123',
        title: 'Tech Summit 2024',
        description: 'Sample event description for Tech Summit 2024.',
        imageUrl: 'https://picsum.photos/200/200?random=4',
        date: DateTime.now().add(const Duration(days: 15)),
        location: 'University Campus',
        price: 'Rp 50.000',
        registeredCount: 75,
        category: 'Technology',
      ),
      Event(
        id: '4',
        title: 'Art Exhibition',
        description: 'Explore stunning artwork from talented university students.',
        imageUrl: 'https://picsum.photos/200/200?random=5',
        date: DateTime.now().add(const Duration(days: 10)),
        location: 'Art Building Gallery',
        price: 'Rp 25.000',
        registeredCount: 45,
        category: 'Arts',
      ),
      Event(
        id: '5',
        title: 'Coding Workshop',
        description: 'Learn the basics of Flutter development in this hands-on workshop.',
        imageUrl: 'https://picsum.photos/200/200?random=6',
        date: DateTime.now().add(const Duration(days: 5)),
        location: 'Engineering Building, Room 101',
        price: 'Rp 25.000',
        registeredCount: 15,
        category: 'Technology',
      ),
      Event(
        id: '6',
        title: 'Study Group',
        description: 'Join our weekly study group to prepare for midterm exams.',
        imageUrl: 'https://picsum.photos/200/200?random=7',
        date: DateTime.now().add(const Duration(days: 8)),
        location: 'Library, Study Room 3',
        price: 'Free',
        registeredCount: 8,
        category: 'Education',
      ),
    ];
    
    // Debug info
    print('Saved event IDs: $savedEventIds');
    
    // Filter to only show saved events
    _savedEvents = allEvents.where((event) => savedEventIds.contains(event.id)).toList();
    
    // Debug info
    print('Found ${_savedEvents.length} saved events');
    for (var event in _savedEvents) {
      print('Saved event: ${event.id} - ${event.title}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Saved Events', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        actions: [
          // Add a refresh button to manually reload saved events
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.textPrimary),
            onPressed: _loadSavedEvents,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _savedEvents.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        size: 64,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No saved events yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Bookmark events to find them here',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _savedEvents.length,
                  itemBuilder: (context, index) {
                    final event = _savedEvents[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => EventDetailsScreen(event: event),
                          ),
                        ).then((_) => _loadSavedEvents()); // Refresh list when returning
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: AppColors.surface,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(event.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          event.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                      // Add unsave button
                                      IconButton(
                                        icon: const Icon(
                                          Icons.bookmark,
                                          color: AppColors.primary,
                                        ),
                                        onPressed: () async {
                                          final prefs = await SharedPreferences.getInstance();
                                          final savedEvents = prefs.getStringList('saved_events') ?? [];
                                          savedEvents.remove(event.id);
                                          await prefs.setStringList('saved_events', savedEvents);
                                          
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Event removed from saved events')),
                                          );
                                          
                                          _loadSavedEvents();
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${event.date.day} ${_getMonthName(event.date.month)}, ${event.date.year}',
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          event.location,
                                          style: TextStyle(
                                            color: AppColors.textSecondary,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.category,
                                        size: 16,
                                        color: AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        event.category,
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
} 