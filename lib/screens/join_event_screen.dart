import 'package:flutter/material.dart';
import 'event_details_screen.dart';
import '../models/event.dart';
import '../utils/app_colors.dart';

class JoinEventScreen extends StatefulWidget {
  const JoinEventScreen({super.key});

  @override
  State<JoinEventScreen> createState() => _JoinEventScreenState();
}

class _JoinEventScreenState extends State<JoinEventScreen> {
  late List<Event> _joinedEvents;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadJoinedEvents();
  }
  
  Future<void> _loadJoinedEvents() async {
    // Simulate loading data from API
    await Future.delayed(const Duration(milliseconds: 800));
    
    // In a real app, you would fetch joined events from your backend or local database
    setState(() {
      _joinedEvents = [
        Event(
          id: '1',
          title: 'Future AI: Annual Tech Summit',
          description: 'Join us for the most anticipated tech summit focusing on artificial intelligence and machine learning.',
          imageUrl: 'https://picsum.photos/200/200?random=1',
          date: DateTime.now().add(const Duration(days: 30)),
          location: 'Universitas Pradita, Gading Serpong',
          price: 'Rp 75.000',
          registeredCount: 100,
          category: 'AI & Technology',
        ),
        Event(
          id: '2',
          title: 'Campus Music Festival',
          description: 'Annual music festival featuring student bands and local artists.',
          imageUrl: 'https://picsum.photos/200/200?random=3',
          date: DateTime.now().add(const Duration(days: 15)),
          location: 'University Quad',
          price: 'Rp 50.000',
          registeredCount: 120,
          category: 'Music',
        ),
        Event(
          id: '3',
          title: 'Job Fair 2024',
          description: 'Connect with top employers and explore career opportunities.',
          imageUrl: 'https://picsum.photos/200/200?random=4',
          date: DateTime.now().add(const Duration(days: 45)),
          location: 'University Main Hall',
          price: 'Free',
          registeredCount: 250,
          category: 'Career',
        ),
      ];
      _isLoading = false;
    });
  }
  
  Future<void> _cancelRegistration(String eventId) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Registration'),
        content: const Text('Are you sure you want to cancel your registration for this event?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API call to cancel registration
      await Future.delayed(const Duration(milliseconds: 500));
      
      setState(() {
        _joinedEvents.removeWhere((event) => event.id == eventId);
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration canceled successfully')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Joined Events'),
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
            'Explore events and register to see them here',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/events'),
            icon: const Icon(Icons.search),
            label: const Text('Explore Events'),
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
          onView: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailsScreen(event: event),
              ),
            );
          },
          onCancel: () => _cancelRegistration(event.id),
        );
      },
    );
  }
}

class _JoinedEventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onView;
  final VoidCallback onCancel;

  const _JoinedEventCard({
    required this.event,
    required this.onView,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = event.date.isAfter(DateTime.now());
    final formattedDate = '${event.date.day} ${_getMonthName(event.date.month)}, ${event.date.year} · ${event.date.hour}:${event.date.minute.toString().padLeft(2, '0')}';
    
    // Check cancellation rules based on event type and time
    final isPaid = event.price != 'Free';
    final hoursToEvent = event.date.difference(DateTime.now()).inHours;
    final minutesToEvent = event.date.difference(DateTime.now()).inMinutes;
    
    // Paid events: can't cancel within 2 hours
    // Free events: can't cancel within 1 hour
    final canCancel = isUpcoming && (
      (isPaid && hoursToEvent >= 2) || 
      (!isPaid && minutesToEvent >= 60)
    );
    
    // Get the specific reason why cancellation is not allowed
    String? cancellationRestrictionReason;
    if (isUpcoming && !canCancel) {
      if (isPaid) {
        cancellationRestrictionReason = 'Paid events cannot be canceled within 2 hours of the start time';
      } else {
        cancellationRestrictionReason = 'Free events cannot be canceled within 1 hour of the start time';
      }
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onView,
        borderRadius: BorderRadius.circular(12),
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
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey[400],
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
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.calendar_today, formattedDate),
                  const SizedBox(height: 4),
                  _buildInfoRow(Icons.category, event.category),
                  const SizedBox(height: 4),
                  _buildInfoRow(Icons.location_on, event.location),
                  const SizedBox(height: 4),
                  _buildInfoRow(Icons.monetization_on, event.price),
                  
                  const SizedBox(height: 16),
                  
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Scan QR Code button
                      TextButton.icon(
                        onPressed: () {
                          _showScannerDialog(context);
                        },
                        icon: const Icon(Icons.qr_code_scanner, size: 18),
                        label: const Text('Scan QR Code'),
                      ),
                      // Cancel button with appropriate state
                      if (canCancel)
                        TextButton.icon(
                          onPressed: onCancel,
                          icon: const Icon(Icons.cancel, size: 18),
                          label: const Text('Cancel'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.error,
                          ),
                        )
                      else if (isUpcoming && cancellationRestrictionReason != null)
                        Tooltip(
                          message: cancellationRestrictionReason,
                          child: TextButton.icon(
                            onPressed: null,
                            icon: const Icon(Icons.cancel, size: 18),
                            label: const Text('Cancel'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textTertiary,
                            ),
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

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: AppColors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June', 
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  void _showScannerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Scan QR Code', style: TextStyle(color: AppColors.textPrimary)),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_scanner,
                        size: 80,
                        color: AppColors.white,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Camera Preview',
                        style: TextStyle(color: AppColors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Position the QR code within the frame',
                        style: TextStyle(color: AppColors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Scan the QR code displayed at the event location to mark your attendance for "${event.title}"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // Simulate successful scan
              _showAttendanceConfirmedDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
            ),
            icon: const Icon(Icons.flash_on, size: 18),
            label: const Text('Toggle Flash'),
          ),
        ],
      ),
    );
  }

  void _showAttendanceConfirmedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success),
            SizedBox(width: 8),
            Text('Attendance Confirmed', style: TextStyle(color: AppColors.textPrimary)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You have successfully checked in to "${event.title}"',
              style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            Text(
              'Check-in time: ${TimeOfDay.now().format(context)}',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}