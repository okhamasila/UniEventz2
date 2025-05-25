import 'package:flutter/material.dart';
import 'event_details_screen.dart';
import '../models/event.dart';

class JoinedEventsScreen extends StatefulWidget {
  const JoinedEventsScreen({super.key});

  @override
  State<JoinedEventsScreen> createState() => _JoinedEventsScreenState();
}

class _JoinedEventsScreenState extends State<JoinedEventsScreen> {
  late List<Event> _joinedEvents;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadEvents();
  }
  
  Future<void> _loadEvents() async {
    // Simulate loading data from API
    await Future.delayed(const Duration(milliseconds: 800));
    
    // In a real app, you would fetch events from your backend or local database
    setState(() {
      _joinedEvents = [
        Event(
          id: '4',
          title: 'Tech Summit 2024',
          description: 'Annual technology summit featuring industry experts and workshops.',
          imageUrl: 'https://picsum.photos/200/200?random=4',
          date: DateTime.now().add(const Duration(days: 10)),
          location: 'Convention Center, Hall A',
          price: 'Rp 75.000',
          registeredCount: 250,
          category: 'Technology',
        ),
        Event(
          id: '5',
          title: 'Entrepreneurship Workshop',
          description: 'Learn how to start and grow your business from successful entrepreneurs.',
          imageUrl: 'https://picsum.photos/200/200?random=5',
          date: DateTime.now().add(const Duration(days: 18)),
          location: 'Business School Auditorium',
          price: 'Rp 35.000',
          registeredCount: 120,
          category: 'Business',
        ),
        Event(
          id: '6',
          title: 'Art Exhibition',
          description: 'Showcase of student artwork from various departments.',
          imageUrl: 'https://picsum.photos/200/200?random=6',
          date: DateTime.now().add(const Duration(days: 7)),
          location: 'University Art Gallery',
          price: 'Free',
          registeredCount: 85,
          category: 'Arts',
        ),
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events I\'ve Joined'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search functionality coming soon')),
              );
            },
            tooltip: 'Search Events',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _joinedEvents.isEmpty
              ? _buildEmptyState()
              : _buildEventsList(),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'You haven\'t joined any events yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Browse events to find something interesting',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/events'),
            icon: const Icon(Icons.search),
            label: const Text('Find Events'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEventsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _joinedEvents.length,
      itemBuilder: (context, index) {
        final event = _joinedEvents[index];
        return _JoinedEventCard(
          event: event,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailsScreen(event: event),
              ),
            );
          },
        );
      },
    );
  }
}

class _JoinedEventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const _JoinedEventCard({
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = event.date.isAfter(DateTime.now());
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                event.imageUrl,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    width: 120,
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey[400],
                    ),
                  );
                },
              ),
            ),
            
            // Event details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status indicator
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isUpcoming ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isUpcoming ? 'Upcoming' : 'Past',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Event title
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    // Date and location
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${event.date.day}/${event.date.month}/${event.date.year}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.location,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 