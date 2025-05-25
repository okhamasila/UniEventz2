import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class RegisterEventScreen extends StatefulWidget {
  final String eventId;
  final String eventTitle;
  final String eventDate;
  final String eventLocation;
  final String eventPrice;
  final String eventOrganizer;

  const RegisterEventScreen({
    super.key,
    required this.eventId,
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    required this.eventPrice,
    required this.eventOrganizer,
  });

  @override
  State<RegisterEventScreen> createState() => _RegisterEventScreenState();
}

class _RegisterEventScreenState extends State<RegisterEventScreen> {
  String _selectedPaymentMethod = 'bank';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Register for Event', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Banner
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.image,
                  size: 50,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Event Title
            Text(
              widget.eventTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            // Event Details
            _buildInfoRow(Icons.person, widget.eventOrganizer),
            _buildInfoRow(Icons.calendar_today, widget.eventDate),
            _buildInfoRow(Icons.location_on, widget.eventLocation),
            _buildInfoRow(Icons.attach_money, widget.eventPrice),
            const SizedBox(height: 16),
            // Registration Form
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: const TextStyle(color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: const TextStyle(color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            const Text(
              'Ticket Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Regular Ticket',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        widget.eventPrice,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Row(
                      children: [
                        Icon(Icons.account_balance, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text('Bank Transfer', style: TextStyle(color: AppColors.textPrimary)),
                      ],
                    ),
                    value: 'bank',
                    groupValue: _selectedPaymentMethod,
                    activeColor: AppColors.primary,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _selectedPaymentMethod = value;
                        });
                      }
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  ),
                  const Divider(height: 1, color: AppColors.grey),
                  RadioListTile<String>(
                    title: const Row(
                      children: [
                        Icon(Icons.credit_card, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text('Credit Card', style: TextStyle(color: AppColors.textPrimary)),
                      ],
                    ),
                    value: 'credit',
                    groupValue: _selectedPaymentMethod,
                    activeColor: AppColors.primary,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _selectedPaymentMethod = value;
                        });
                      }
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  ),
                  const Divider(height: 1, color: AppColors.grey),
                  RadioListTile<String>(
                    title: const Row(
                      children: [
                        Icon(Icons.account_balance_wallet, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text('E-Wallet', style: TextStyle(color: AppColors.textPrimary)),
                      ],
                    ),
                    value: 'ewallet',
                    groupValue: _selectedPaymentMethod,
                    activeColor: AppColors.primary,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _selectedPaymentMethod = value;
                        });
                      }
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Complete Registration Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // Show loading indicator
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    },
                  );
                  
                  // Simulate payment processing
                  Future.delayed(const Duration(seconds: 2), () {
                    // Close loading dialog
                    Navigator.of(context).pop();
                    
                    // Show success dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: const Row(
                            children: [
                              Icon(Icons.check_circle, color: AppColors.success, size: 28),
                              SizedBox(width: 8),
                              Text('Sukses', style: TextStyle(color: AppColors.textPrimary)),
                            ],
                          ),
                          content: const Text('Berhasil melakukan pembayaran', style: TextStyle(color: AppColors.textSecondary)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close dialog
                                Navigator.of(context).pop(); // Return to event details
                              },
                              child: const Text('OK', style: TextStyle(color: AppColors.primary)),
                            ),
                          ],
                        );
                      },
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Complete Registration',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}