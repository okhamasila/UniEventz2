import 'package:flutter/material.dart';
import '../models/event.dart';

class EventPreviewScreen extends StatefulWidget {
  final Event event;

  const EventPreviewScreen({super.key, required this.event});

  @override
  State<EventPreviewScreen> createState() => _EventPreviewScreenState();
}

class _EventPreviewScreenState extends State<EventPreviewScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  List<Map<String, dynamic>> _attendees = [];
  double _totalRevenue = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadEventData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadEventData() async {
    // Simulate loading data from API
    await Future.delayed(const Duration(milliseconds: 800));
    
    // In a real app, you would fetch attendees and revenue from your backend
    // Create exactly the same number of attendees as the registered count
    final int totalAttendees = widget.event.registeredCount;
    final int confirmedAttendees = (totalAttendees * 0.8).round(); // 80% confirmed
    final int pendingAttendees = totalAttendees - confirmedAttendees; // 20% pending
    
    final List<Map<String, dynamic>> mockAttendees = [];
    
    // Add confirmed attendees
    for (int i = 1; i <= confirmedAttendees; i++) {
      mockAttendees.add({
        'id': '$i',
        'name': 'Attendee $i',
        'email': 'attendee$i@example.com',
        'registrationDate': DateTime.now().subtract(Duration(days: i % 7 + 1)),
        'status': 'Confirmed',
        'paymentAmount': _extractPriceValue(widget.event.price),
      });
    }
    
    // Add pending attendees
    for (int i = confirmedAttendees + 1; i <= totalAttendees; i++) {
      mockAttendees.add({
        'id': '$i',
        'name': 'Attendee $i',
        'email': 'attendee$i@example.com',
        'registrationDate': DateTime.now().subtract(Duration(days: i % 3 + 1)),
        'status': 'Pending',
        'paymentAmount': _extractPriceValue(widget.event.price),
      });
    }
    
    // Calculate total revenue
    double revenue = mockAttendees
        .where((attendee) => attendee['status'] == 'Confirmed')
        .fold(0, (sum, attendee) => sum + (attendee['paymentAmount'] as double));
    
    setState(() {
      _attendees = mockAttendees;
      _totalRevenue = revenue;
      _isLoading = false;
    });
  }
  
  // Helper method to extract numerical price value
  double _extractPriceValue(String priceString) {
    // Handle 'Free' case
    if (priceString == 'Free') return 0;
    
    // Extract numbers from string like "Rp 25.000"
    String numericString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
    return double.tryParse(numericString) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Preview'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Details'),
            Tab(text: 'Attendees'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildDetailsTab(),
                _buildAttendeesTab(),
              ],
            ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.event.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          
          // Event info
          Text(
            widget.event.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.calendar_today, '${widget.event.date.day}/${widget.event.date.month}/${widget.event.date.year} · ${widget.event.date.hour}:${widget.event.date.minute.toString().padLeft(2, '0')}'),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.location_on, widget.event.location),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.category, widget.event.category),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.people, '${widget.event.registeredCount} registered'),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.attach_money, widget.event.price),
          const SizedBox(height: 24),
          
          // Revenue Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Revenue Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Attendees:'),
                    Text(
                      '${_attendees.length}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Confirmed Attendees:'),
                    Text(
                      '${_attendees.where((a) => a['status'] == 'Confirmed').length}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Pending Attendees:'),
                    Text(
                      '${_attendees.where((a) => a['status'] == 'Pending').length}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Revenue:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp ${_totalRevenue.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Event description
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.event.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendeesTab() {
    return Column(
      children: [
        // Summary at the top
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard(
                'Total',
                '${_attendees.length}',
                Colors.blue,
              ),
              _buildStatCard(
                'Confirmed',
                '${_attendees.where((a) => a['status'] == 'Confirmed').length}',
                Colors.green,
              ),
              _buildStatCard(
                'Pending',
                '${_attendees.where((a) => a['status'] == 'Pending').length}',
                Colors.orange,
              ),
            ],
          ),
        ),
        
        // Attendees list
        Expanded(
          child: ListView.builder(
            itemCount: _attendees.length,
            itemBuilder: (context, index) {
              final attendee = _attendees[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, color: Colors.grey),
                ),
                title: Text(attendee['name']),
                subtitle: Text(attendee['email']),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: attendee['status'] == 'Confirmed'
                        ? Colors.green[100]
                        : Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    attendee['status'],
                    style: TextStyle(
                      color: attendee['status'] == 'Confirmed'
                          ? Colors.green[800]
                          : Colors.orange[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[700], size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 