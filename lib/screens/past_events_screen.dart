import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'past_event_detail_screen.dart';

class PastEventsScreen extends StatefulWidget {
  const PastEventsScreen({super.key});

  @override
  State<PastEventsScreen> createState() => _PastEventsScreenState();
}

class _PastEventsScreenState extends State<PastEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Past Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.black),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          _buildEventCard(
            'AI Workshop',
            'Feb 15, 2024',
            'Attended',
            'Learn about artificial intelligence and machine learning fundamentals.',
            Icons.computer,
          ),
          _buildEventCard(
            'Career Fair',
            'Jan 30, 2024',
            'Attended',
            'Connect with top companies and explore career opportunities.',
            Icons.work,
          ),
          _buildEventCard(
            'Tech Meetup',
            'Jan 20, 2024',
            'Attended',
            'Networking event for tech enthusiasts and professionals.',
            Icons.group,
          ),
          _buildEventCard(
            'Coding Bootcamp',
            'Dec 15, 2023',
            'Completed',
            'Intensive programming workshop covering web development.',
            Icons.code,
          ),
          _buildEventCard(
            'University Seminar',
            'Nov 28, 2023',
            'Attended',
            'Academic seminar on emerging technologies in education.',
            Icons.school,
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(
    String title,
    String date,
    String status,
    String description,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppColors.surface,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PastEventDetailScreen(
                title: title,
                date: date,
                status: status,
                description: description,
                icon: icon,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryLight.withOpacity(0.2),
                          AppColors.secondaryLight.withOpacity(0.2),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: AppColors.primary,
                      size: 24,
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
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.success.withOpacity(0.3)),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: AppColors.success,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 