import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create-event');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildEventSection('Upcoming Events', [
            _buildEventCard(
              context,
              'Tech Conference 2024',
              'Mar 25, 2024',
              'Convention Center',
              'Free',
              'Tech Community',
              Colors.blue[100]!,
              Icons.computer,
            ),
            _buildEventCard(
              context,
              'Campus Music Festival',
              'Apr 5, 2024',
              'University Stadium',
              'Rp 50.000',
              'Student Council',
              Colors.purple[100]!,
              Icons.music_note,
            ),
          ]),
          const SizedBox(height: 24),
          _buildEventSection('Past Events', [
            _buildEventCard(
              context,
              'AI Workshop',
              'Feb 15, 2024',
              'Engineering Building',
              'Free',
              'CS Department',
              Colors.green[100]!,
              Icons.psychology,
            ),
            _buildEventCard(
              context,
              'Career Fair',
              'Jan 30, 2024',
              'Student Center',
              'Free',
              'Career Center',
              Colors.orange[100]!,
              Icons.work,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildEventSection(String title, List<Widget> events) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...events,
      ],
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    String title,
    String date,
    String location,
    String price,
    String organizer,
    Color backgroundColor,
    IconData eventIcon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/register-event',
            arguments: {
              'eventId': '123', // Replace with actual event ID
              'eventTitle': title,
              'eventDate': date,
              'eventLocation': location,
              'eventPrice': price,
              'eventOrganizer': organizer,
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Icon(
                  eventIcon,
                  size: 64,
                  color: backgroundColor.withBlue(backgroundColor.blue + 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text(date),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 8),
                      Text(location),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 16),
                      const SizedBox(width: 8),
                      Text(organizer),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.attach_money, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        price,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
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