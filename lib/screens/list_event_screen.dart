import 'package:flutter/material.dart';
import '../models/event.dart';
import '../utils/app_colors.dart';

class ListEventScreen extends StatefulWidget {
  final String? initialCategory;

  const ListEventScreen({super.key, this.initialCategory});

  @override
  State<ListEventScreen> createState() => _ListEventScreenState();
}

class _ListEventScreenState extends State<ListEventScreen> {
  String? _selectedCategory;
  final TextEditingController _searchController = TextEditingController();
  
  // All available events
  final List<Event> _allEvents = [
    Event(
      id: '1',
      title: 'Future of AI: Annual Tech Summit',
      description: 'Join us for an amazing AI event!',
      imageUrl: 'https://picsum.photos/200/200?random=1',
      date: DateTime.now().add(const Duration(days: 30)),
      location: 'Universitas Pradita, Gading Serpong',
      price: 'Rp 75.000',
      registeredCount: 100,
      category: 'Technology',
    ),
    Event(
      id: '2',
      title: 'Machine Learning Workshop',
      description: 'Learn about machine learning fundamentals',
      imageUrl: 'https://picsum.photos/200/200?random=2',
      date: DateTime.now().add(const Duration(days: 45)),
      location: 'Pradita University, Gading Serpong',
      price: 'Rp 50.000',
      registeredCount: 156,
      category: 'Technology',
    ),
    Event(
      id: '3',
      title: 'Campus Music Festival',
      description: 'Annual music festival featuring student bands and local artists',
      imageUrl: 'https://picsum.photos/200/200?random=3',
      date: DateTime.now().add(const Duration(days: 15)),
      location: 'University Amphitheater',
      price: 'Rp 35.000',
      registeredCount: 220,
      category: 'Music',
    ),
    Event(
      id: '4',
      title: 'Sports Tournament',
      description: 'Inter-university sports competition',
      imageUrl: 'https://picsum.photos/200/200?random=4',
      date: DateTime.now().add(const Duration(days: 7)),
      location: 'University Sports Complex',
      price: 'Rp 25.000',
      registeredCount: 180,
      category: 'Sports',
    ),
    Event(
      id: '5',
      title: 'Academic Conference',
      description: 'Research presentation and networking event',
      imageUrl: 'https://picsum.photos/200/200?random=5',
      date: DateTime.now().add(const Duration(days: 60)),
      location: 'University Conference Hall',
      price: 'Rp 100.000',
      registeredCount: 85,
      category: 'Education',
    ),
  ];
  
  // Filtered events
  List<Event> _filteredEvents = [];
  
  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _filterEvents();
    
    _searchController.addListener(() {
      _filterEvents();
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  void _filterEvents() {
    setState(() {
      _filteredEvents = _allEvents.where((event) {
        // Apply category filter if selected
        if (_selectedCategory != null && 
            !event.category.toLowerCase().contains(_selectedCategory!.toLowerCase())) {
          return false;
        }
        
        // Apply search filter if text is entered
        if (_searchController.text.isNotEmpty &&
            !event.title.toLowerCase().contains(_searchController.text.toLowerCase()) &&
            !event.description.toLowerCase().contains(_searchController.text.toLowerCase()) &&
            !event.location.toLowerCase().contains(_searchController.text.toLowerCase()) &&
            !event.category.toLowerCase().contains(_searchController.text.toLowerCase())) {
          return false;
        }
        
        return true;
      }).toList();
    });
  }
  
  void _clearFilters() {
    setState(() {
      _selectedCategory = null;
      _searchController.clear();
      _filteredEvents = List.from(_allEvents);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            _selectedCategory != null 
                ? Text('${_selectedCategory} Events', 
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ))
                : const Text('All Events', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    )),
          ],
        ),
        actions: [
          if (_selectedCategory != null || _searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: AppColors.textSecondary),
              onPressed: _clearFilters,
            ),
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textSecondary),
            onPressed: () {
              // Focus on search field
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ],
        backgroundColor: AppColors.surface,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search events...',
                hintStyle: const TextStyle(color: AppColors.textTertiary),
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                filled: true,
                fillColor: AppColors.surfaceVariant,
              ),
              onChanged: (_) => _filterEvents(),
            ),
          ),
          if (_selectedCategory != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryLight.withOpacity(0.3),
                          AppColors.secondaryLight.withOpacity(0.3),
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
                        Text(
                          _selectedCategory!,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = null;
                              _filterEvents();
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _filteredEvents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.event_busy,
                          size: 64,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No events found',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        if (_selectedCategory != null || _searchController.text.isNotEmpty)
                          TextButton(
                            onPressed: _clearFilters,
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFFBF7587),
                            ),
                            child: const Text('Clear Filters'),
                          ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: _filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = _filteredEvents[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        color: AppColors.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/event-details',
                              arguments: event,
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGrey,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        event.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Center(
                                            child: Icon(
                                              Icons.image,
                                              size: 50,
                                              color: AppColors.textTertiary,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 12,
                                      left: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Text(
                                          'Upcoming',
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                    const SizedBox(height: 12),
                                    _buildInfoRow(
                                      Icons.calendar_today,
                                      '${event.date.day} ${_getMonthName(event.date.month)}, ${event.date.year} • ${event.date.hour}:${event.date.minute.toString().padLeft(2, '0')}',
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                      Icons.category,
                                      event.category,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                      Icons.location_on,
                                      event.location,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            event.price,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.surfaceVariant,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.people,
                                                size: 16,
                                                color: AppColors.textSecondary,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${event.registeredCount} registered',
                                                style: const TextStyle(
                                                  color: AppColors.textSecondary,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
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
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
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