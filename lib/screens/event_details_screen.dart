import 'package:flutter/material.dart';
import 'register_event_screen.dart';
import '../models/event.dart';
import '../utils/auth_utils.dart';
import '../utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfEventIsSaved();
  }

  Future<void> _checkIfEventIsSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEvents = prefs.getStringList('saved_events') ?? [];
    setState(() {
      _isSaved = savedEvents.contains(widget.event.id);
    });
  }

  Future<void> _toggleSaveEvent() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEvents = prefs.getStringList('saved_events') ?? [];
    
    setState(() {
      if (_isSaved) {
        // Remove from saved events
        savedEvents.remove(widget.event.id);
        _isSaved = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event removed from saved events')),
        );
      } else {
        // Add to saved events
        savedEvents.add(widget.event.id);
        _isSaved = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event saved successfully')),
        );
      }
    });
    
    await prefs.setStringList('saved_events', savedEvents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Event Details', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: _isSaved ? AppColors.primary : AppColors.textPrimary,
            ),
            onPressed: _toggleSaveEvent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
              ),
              child: Image.network(
                widget.event.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: AppColors.textTertiary,
                    ),
                  );
                },
              ),
            ),
            Container(
              color: AppColors.surface,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${widget.event.date.day} ${_getMonthName(widget.event.date.month)}, ${widget.event.date.year} • ${widget.event.date.hour}:${widget.event.date.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.category,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.event.category,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.event.location,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    _buildInfoRow(
                      Icons.people,
                      '${widget.event.registeredCount} registered',
                    ),
                    const SizedBox(height: 24),
                    
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.event.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Check if user is logged in
                          bool isLoggedIn = await AuthUtils.requireLogin(context);
                          
                          if (isLoggedIn) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterEventScreen(
                                  eventId: widget.event.id,
                                  eventTitle: widget.event.title,
                                  eventDate: '${widget.event.date.day} ${_getMonthName(widget.event.date.month)}, ${widget.event.date.year}',
                                  eventLocation: widget.event.location,
                                  eventPrice: widget.event.price,
                                  eventOrganizer: 'Event Organizer', // You might want to add this field to your Event class
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textOnPrimary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Register Now - ${widget.event.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
        ),
      ],
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



