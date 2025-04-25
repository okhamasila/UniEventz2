import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('UniEventz'),
        actions: const [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: null, // TODO: Implement notifications
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create-event'),
        child: const Icon(Icons.add),
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
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Discover amazing events happening around your campus',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
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
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _ActionButton(
              icon: Icons.event_available_outlined,
              label: 'Join Event',
              onTap: () => Navigator.pushNamed(context, '/events'),
            ),
            _ActionButton(
              icon: Icons.bookmark_outline,
              label: 'Saved',
              onTap: () {}, // TODO: Implement saved events
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
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
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
      color: Colors.blue[100]!,
      icon: Icons.computer,
    ),
    _EventData(
      title: 'Spring Festival',
      date: 'Apr 15, 2024',
      color: Colors.green[100]!,
      icon: Icons.local_florist,
    ),
    _EventData(
      title: 'Job Fair',
      date: 'May 1, 2024',
      color: Colors.orange[100]!,
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
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 2, // Reduced elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/register-event',
              arguments: {
                'eventId': '123',
                'eventTitle': title,
                'eventDate': date,
                'eventLocation': 'Campus Center',
                'eventPrice': 'Free',
                'eventOrganizer': 'University',
              },
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Icon(
                    eventIcon,
                    size: 48,
                    color: backgroundColor.withBlue(backgroundColor.blue + 50),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
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
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

class _MyEvents extends StatelessWidget {
  static final List<_EventData> _myEvents = [
    _EventData(
      title: 'Coding Workshop',
      date: 'Mar 25, 2024',
      color: Colors.purple[100]!,
      icon: Icons.code,
    ),
    _EventData(
      title: 'Study Group',
      date: 'Mar 28, 2024',
      color: Colors.teal[100]!,
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
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to all my events
              },
              child: const Text('See All'),
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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/event-details',
            arguments: {
              'eventId': '123',
              'eventTitle': title,
              'eventDate': date,
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  eventIcon,
                  size: 24,
                  color: backgroundColor.withBlue(backgroundColor.blue + 50),
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
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}