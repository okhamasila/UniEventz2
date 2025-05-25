import 'package:flutter/material.dart';
import 'event_preview_screen.dart';
import '../models/event.dart';
import '../utils/app_colors.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  late List<Event> _myEvents;
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
      _myEvents = [
        Event(
          id: '1',
          title: 'Coding Workshop',
          description: 'Learn the basics of Flutter development in this hands-on workshop.',
          imageUrl: 'https://picsum.photos/200/200?random=1',
          date: DateTime.now().add(const Duration(days: 5)),
          location: 'Engineering Building, Room 101',
          price: 'Rp 25.000',
          registeredCount: 15,
          category: 'Technology',
        ),
        Event(
          id: '2',
          title: 'Study Group',
          description: 'Join our weekly study group to prepare for midterm exams.',
          imageUrl: 'https://picsum.photos/200/200?random=2',
          date: DateTime.now().add(const Duration(days: 8)),
          location: 'Library, Study Room 3',
          price: 'Free',
          registeredCount: 8,
          category: 'Education',
        ),
        Event(
          id: '3',
          title: 'Campus Music Festival',
          description: 'Annual music festival featuring student bands and local artists.',
          imageUrl: 'https://picsum.photos/200/200?random=3',
          date: DateTime.now().add(const Duration(days: 15)),
          location: 'University Quad',
          price: 'Rp 50.000',
          registeredCount: 120,
          category: 'Music',
        ),
      ];
      _isLoading = false;
    });
  }
  
  Future<void> _deleteEvent(String eventId) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Delete Event', style: TextStyle(color: AppColors.textPrimary)),
        content: const Text('Are you sure you want to delete this event? This action cannot be undone.', style: TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API call to delete event
      await Future.delayed(const Duration(milliseconds: 500));
      
      setState(() {
        _myEvents.removeWhere((event) => event.id == eventId);
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event deleted successfully')),
        );
      }
    }
  }
  
  void _editEvent(Event event) {
    // Navigate to edit event screen
    // In a real app, you would navigate to your event creation/edit screen
    // For now, we'll just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit functionality will be implemented soon')),
    );
    
    // TODO: Navigate to edit event screen with event data
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => EditEventScreen(event: event),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Events'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/create-event'),
            tooltip: 'Create New Event',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _myEvents.isEmpty
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
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'You haven\'t created any events yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to create your first event',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/create-event'),
            icon: const Icon(Icons.add),
            label: const Text('Create Event'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEventsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _myEvents.length,
      itemBuilder: (context, index) {
        final event = _myEvents[index];
        return _EventCard(
          event: event,
          onView: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventPreviewScreen(event: event),
              ),
            );
          },
          onEdit: () => _editEvent(event),
          onDelete: () => _deleteEvent(event.id),
        );
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _EventCard({
    required this.event,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = event.date.isAfter(DateTime.now());
    
    return InkWell(
      onTap: onView,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  Image.network(
                    event.imageUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 140,
                        width: double.infinity,
                        color: AppColors.surfaceVariant,
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: AppColors.textTertiary,
                        ),
                      );
                    },
                  ),
                  // Status indicator
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isUpcoming ? AppColors.success : AppColors.textSecondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isUpcoming ? 'Upcoming' : 'Past',
                        style: const TextStyle(
                          color: AppColors.textOnPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Event details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 8),
                      Text(
                        '${event.date.day}/${event.date.month}/${event.date.year} · ${event.date.hour}:${event.date.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.location,
                          style: const TextStyle(color: AppColors.textSecondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.people, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 8),
                      Text(
                        '${event.registeredCount} registered',
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text('Edit'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.success,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete, size: 18),
                        label: const Text('Delete'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.error,
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
  }
} 