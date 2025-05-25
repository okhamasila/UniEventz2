import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_details_screen.dart';
import 'list_event_screen.dart' as list_screen;
import 'join_event_screen.dart';
import 'my_events_screen.dart';
import 'event_preview_screen.dart';
import 'saved_events_screen.dart';
import 'notification_screen.dart';
import '../models/event.dart';
import '../utils/app_colors.dart';
import '../widgets/notification_badge.dart';
import '../providers/notification_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('UniEventz'),
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, notificationProvider, child) {
              return NotificationBadge(
                count: notificationProvider.unreadCount,
                child: IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, '/notifications');
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/event-verification'),
        backgroundColor: AppColors.primary,
        elevation: 0,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _WelcomeSection(),
              const SizedBox(height: 24),
              _QuickActions(context: context),
              const SizedBox(height: 24),
              const _PopularCategories(),
              const SizedBox(height: 24),
              _FeaturedEvents(context: context),
              const SizedBox(height: 24),
              const _MyEvents(),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Discover amazing events happening around your campus',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final BuildContext context;

  const _QuickActions({required this.context});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _ActionButton(
              icon: Icons.event_available_outlined,
              label: 'Join Event',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JoinEventScreen(),
                ),
              ),
            ),
            _ActionButton(
              icon: Icons.bookmark_outline,
              label: 'Saved',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedEventsScreen(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryLight.withOpacity(0.3),
                  AppColors.secondaryLight.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              icon, 
              size: 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedEvents extends StatelessWidget {
  final BuildContext context;
  static final List<_EventData> _events = [
    _EventData(
      title: 'Tech Summit 2024',
      date: 'Mar 20, 2024',
      color: AppColors.primaryLight.withOpacity(0.3),
      icon: Icons.computer,
    ),
    _EventData(
      title: 'Spring Festival',
      date: 'Apr 15, 2024',
      color: AppColors.secondaryLight.withOpacity(0.3),
      icon: Icons.local_florist,
    ),
    _EventData(
      title: 'Job Fair',
      date: 'May 1, 2024',
      color: AppColors.tertiaryLight.withOpacity(0.3),
      icon: Icons.work,
    ),
  ];

  const _FeaturedEvents({required this.context});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Featured Events',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _events.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final event = _events[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _FeaturedEventCard(
                  title: event.title,
                  date: event.date,
                  backgroundColor: event.color,
                  eventIcon: event.icon,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EventData {
  final String title;
  final String date;
  final Color color;
  final IconData icon;

  const _EventData({
    required this.title,
    required this.date,
    required this.color,
    required this.icon,
  });
}

class _FeaturedEventCard extends StatelessWidget {
  final String title;
  final String date;
  final Color backgroundColor;
  final IconData eventIcon;

  const _FeaturedEventCard({
    required this.title,
    required this.date,
    required this.backgroundColor,
    required this.eventIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Featured card tapped: $title"); // Debug print
        // Create a sample event for demo purposes
        final sampleEvent = Event(
          id: '123',
          title: title,
          description: 'Sample event description for $title.',
          imageUrl: 'https://picsum.photos/200/200?random=1',
          date: DateTime.now().add(const Duration(days: 15)),
          location: 'University Campus',
          price: 'Rp 50.000',
          registeredCount: 75,
          category: 'Sample Category',
        );
        
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: sampleEvent),
          ),
        );
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              backgroundColor,
              backgroundColor.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                eventIcon, 
                size: 40,
                color: AppColors.primary,
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopularCategories extends StatelessWidget {
  static const List<_CategoryData> _categories = [
    _CategoryData(
      label: 'Technology',
      icon: Icons.computer,
    ),
    _CategoryData(
      label: 'Music',
      icon: Icons.music_note,
    ),
    _CategoryData(
      label: 'Sports',
      icon: Icons.sports_soccer,
    ),
    _CategoryData(
      label: 'Education',
      icon: Icons.school,
    ),
    _CategoryData(
      label: 'Career',
      icon: Icons.work,
    ),
    _CategoryData(
      label: 'Arts',
      icon: Icons.palette,
    ),
  ];

  const _PopularCategories();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _CategoryChip(
                  label: category.label,
                  icon: category.icon,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryData {
  final String label;
  final IconData icon;

  const _CategoryData({
    required this.label,
    required this.icon,
  });
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _CategoryChip({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Category tapped: $label"); // Debug print
        // Navigate to the events list with category filter
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => list_screen.ListEventScreen(
              initialCategory: label,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryLight.withOpacity(0.2),
              AppColors.secondaryLight.withOpacity(0.2),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyEvents extends StatelessWidget {
  static final List<_EventData> _myEvents = [
    _EventData(
      title: 'Coding Workshop',
      date: 'Mar 25, 2024',
      color: AppColors.accentLight.withOpacity(0.3),
      icon: Icons.code,
    ),
    _EventData(
      title: 'Study Group',
      date: 'Mar 28, 2024',
      color: AppColors.tertiaryLight.withOpacity(0.3),
      icon: Icons.group,
    ),
  ];

  const _MyEvents();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Events',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyEventsScreen()),
                );
              },
              child: const Text(
                'See All',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _myEvents.length,
          itemBuilder: (context, index) {
            final event = _myEvents[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _MyEventCard(
                title: event.title,
                date: event.date,
                backgroundColor: event.color,
                eventIcon: event.icon,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MyEventCard extends StatelessWidget {
  final String title;
  final String date;
  final Color backgroundColor;
  final IconData eventIcon;

  const _MyEventCard({
    required this.title,
    required this.date,
    required this.backgroundColor,
    required this.eventIcon,
  });

  @override
  Widget build(BuildContext context) {
    // Create the sample event outside the widget build to avoid recreation
    // Match event data with the ones defined in MyEventsScreen
    Event sampleEvent;
    
    if (title == 'Coding Workshop') {
      sampleEvent = Event(
        id: '1', // Match the ID in MyEventsScreen
        title: title,
        description: 'Learn the basics of Flutter development in this hands-on workshop.',
        imageUrl: 'https://picsum.photos/200/200?random=1',
        date: DateTime.now().add(const Duration(days: 5)),
        location: 'Engineering Building, Room 101',
        price: 'Rp 25.000',
        registeredCount: 15,
        category: 'Technology',
      );
    } else if (title == 'Study Group') {
      sampleEvent = Event(
        id: '2', // Match the ID in MyEventsScreen
        title: title,
        description: 'Join our weekly study group to prepare for midterm exams.',
        imageUrl: 'https://picsum.photos/200/200?random=2',
        date: DateTime.now().add(const Duration(days: 8)),
        location: 'Library, Study Room 3',
        price: 'Free',
        registeredCount: 8,
        category: 'Education',
      );
    } else {
      // Default case
      sampleEvent = Event(
        id: '123',
        title: title,
        description: 'Sample event description for $title.',
        imageUrl: 'https://picsum.photos/200/200?random=1',
        date: DateTime.now().add(const Duration(days: 15)),
        location: 'University Campus',
        price: 'Rp 50.000',
        registeredCount: 75,
        category: 'Sample Category',
      );
    }
    
    return GestureDetector(
      onTap: () {
        print("Card tapped: $title"); // Debug print
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventPreviewScreen(event: sampleEvent),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.surface,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      backgroundColor,
                      backgroundColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  eventIcon,
                  size: 24,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today, 
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios, 
                size: 16,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}