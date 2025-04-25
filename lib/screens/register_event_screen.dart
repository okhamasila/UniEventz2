import 'package:flutter/material.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _organizationController = TextEditingController();
  final _promoCodeController = TextEditingController();
  final _notesController = TextEditingController();

  int _ticketCount = 1;
  String? _selectedPaymentMethod;
  bool _termsAccepted = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _organizationController.dispose();
    _promoCodeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Registration'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildEventInfoSection(),
              _buildRegistrationForm(),
              _buildPaymentSection(),
              _buildTermsAndActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'Event Banner',
                style: TextStyle(
                  color: const Color(0xFF808080),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.eventTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.person, widget.eventOrganizer),
          _buildInfoRow(Icons.calendar_today, widget.eventDate),
          _buildInfoRow(Icons.location_on, widget.eventLocation),
          _buildInfoRow(Icons.attach_money, widget.eventPrice),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: 'Full Name',
            controller: _fullNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Email Address',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Phone Number',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'University/Organization',
            controller: _organizationController,
            hintText: 'Optional',
          ),
          const SizedBox(height: 16),
          _buildTicketCounter(),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Additional Notes',
            controller: _notesController,
            maxLines: 4,
            hintText: 'Optional',
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText ?? 'Enter your $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD4D4D4)),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildTicketCounter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Number of Tickets',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD4D4D4)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (_ticketCount > 1) {
                    setState(() {
                      _ticketCount--;
                    });
                  }
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    _ticketCount.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _ticketCount++;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          _buildPaymentOption(
            'Credit/Debit Card',
            isSelected: _selectedPaymentMethod == 'card',
            onSelected: () {
              setState(() {
                _selectedPaymentMethod = 'card';
              });
            },
          ),
          _buildPaymentOption(
            'e-Wallet',
            isSelected: _selectedPaymentMethod == 'wallet',
            onSelected: () {
              setState(() {
                _selectedPaymentMethod = 'wallet';
              });
            },
          ),
          _buildPaymentOption(
            'Bank Transfer',
            isSelected: _selectedPaymentMethod == 'bank',
            onSelected: () {
              setState(() {
                _selectedPaymentMethod = 'bank';
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _promoCodeController,
                  decoration: InputDecoration(
                    hintText: 'Promo Code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFD4D4D4)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement promo code validation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF262626),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(75, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Apply'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                (() {
                  if (widget.eventPrice.toLowerCase() == 'free') {
                    return 'Free';
                  }
                  final priceStr = widget.eventPrice.replaceAll('Rp', '').trim();
                  print('Original price: ${widget.eventPrice}');
                  print('After removing Rp: $priceStr');
                  final numericStr = priceStr.replaceAll(RegExp(r'[^0-9]'), '');
                  print('Numeric only: $numericStr');
                  if (numericStr.isEmpty) return 'Free';
                  final amount = int.parse(numericStr);
                  final total = amount * _ticketCount;
                  return 'Rp ${total.toString().replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]}.'
                  )}';
                })(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String label, {required bool isSelected, required VoidCallback onSelected}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onSelected,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? const Color(0xFF171717) : const Color(0xFFD4D4D4),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Radio<String>(
                value: label.toLowerCase(),
                groupValue: _selectedPaymentMethod,
                onChanged: (value) => onSelected(),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: _termsAccepted,
                onChanged: (value) {
                  setState(() {
                    _termsAccepted = value ?? false;
                  });
                },
              ),
              const Expanded(
                child: Text(
                  'I agree to the terms & conditions and privacy policy',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _termsAccepted ? _confirmRegistration : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF171717),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Confirm Registration'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _confirmRegistration() {
    if (_formKey.currentState!.validate() && _selectedPaymentMethod != null) {
      // TODO: Implement registration confirmation
      Navigator.pop(context);
    }
  }
}