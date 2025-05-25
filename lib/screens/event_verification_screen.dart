import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../utils/app_colors.dart';

class EventVerificationScreen extends StatefulWidget {
  const EventVerificationScreen({super.key});

  @override
  State<EventVerificationScreen> createState() => _EventVerificationScreenState();
}

class _EventVerificationScreenState extends State<EventVerificationScreen> {
  bool _isFaceScanned = false;
  bool _isKtpUploaded = false;
  bool _isVerifying = false;
  File? _ktpImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _startFaceScan() async {
    setState(() => _isVerifying = true);
    
    // Simulate face scanning process
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isFaceScanned = true;
      _isVerifying = false;
    });
  }

  Future<void> _uploadKtp() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          _ktpImage = File(image.path);
          _isKtpUploaded = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload KTP image')),
      );
    }
  }

  void _continueToCreateEvent() {
    if (!_isFaceScanned || !_isKtpUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete both face scan and KTP upload'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    // Navigate to create event screen
    Navigator.pushNamed(context, '/create-event');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Verification'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 2,
                  color: Color(0xFFCED4DA),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFFAFAFA),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFFE5E7EB)),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 64),
                                  // Title and Description
                                  Container(
                                    width: double.infinity,
                                    decoration: const ShapeDecoration(
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Color(0xFFE5E7EB)),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 26),
                                        const Text(
                                          'Verify Your Identity to Add an Event',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        const Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod, nisi vel consectetur cursus, nunc libero tincidunt purus, non laoreet magna felis vel justo.',
                                          style: TextStyle(
                                            color: Color(0xFF525252),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(12),
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFF5F5F5),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(color: Color(0xFFE5E7EB)),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(Icons.security, size: 16, color: Color(0xFF737373)),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  'Your information is securely stored and protected.',
                                                  style: TextStyle(
                                                    color: Color(0xFF737373),
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  // Face Verification Section
                                  Container(
                                    width: double.infinity,
                                    decoration: ShapeDecoration(
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xFFE5E5E5),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(17),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 192,
                                                height: 192,
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFFE5E5E5),
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                child: _isVerifying
                                                    ? const Center(
                                                        child: CircularProgressIndicator(),
                                                      )
                                                    : _isFaceScanned
                                                        ? const Center(
                                                            child: Icon(Icons.check_circle,
                                                                size: 36, color: Colors.green),
                                                          )
                                                        : const Center(
                                                            child: Icon(Icons.face, size: 36),
                                                          ),
                                              ),
                                              const SizedBox(height: 17),
                                              Text(
                                                _isFaceScanned
                                                    ? 'Face scan completed successfully'
                                                    : 'Please align your face within the frame',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              if (!_isFaceScanned)
                                                ElevatedButton(
                                                  onPressed: _isVerifying ? null : _startFaceScan,
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColors.primary,
                                                    minimumSize: const Size(152.64, 36),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Start Face Scan',
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 46,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFFAFAFA),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFE5E5E5),
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                                            child: Row(
                                              children: [
                                                Icon(Icons.check_circle, size: 16, color: Colors.green),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Face Scan Successful',
                                                  style: TextStyle(
                                                    color: Color(0xFF404040),
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  // KTP Verification Section
                                  Container(
                                    width: double.infinity,
                                    decoration: ShapeDecoration(
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xFFE5E5E5),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(17),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'KTP (ID Card) Verification',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Container(
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 128,
                                                  decoration: ShapeDecoration(
                                                    color: const Color(0xFFE5E5E5),
                                                    shape: RoundedRectangleBorder(
                                                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: _ktpImage != null
                                                      ? ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: Image.file(
                                                            _ktpImage!,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )
                                                      : const Center(
                                                          child: Icon(Icons.credit_card, size: 40),
                                                        ),
                                                ),
                                                const SizedBox(height: 16),
                                                ElevatedButton(
                                                  onPressed: _uploadKtp,
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColors.primary,
                                                    minimumSize: const Size(126.67, 36),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Upload KTP',
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 13),
                                          Row(
                                            children: [
                                              const Icon(Icons.info_outline, size: 14, color: Color(0xFF525252)),
                                              const SizedBox(width: 4),
                                              const Text(
                                                'Ensure text is clear and readable',
                                                style: TextStyle(
                                                  color: Color(0xFF525252),
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              const Icon(Icons.info_outline, size: 14, color: Color(0xFF525252)),
                                              const SizedBox(width: 4),
                                              const Text(
                                                'Avoid glare and shadows',
                                                style: TextStyle(
                                                  color: Color(0xFF525252),
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  // Verification Status Section
                                  Container(
                                    width: double.infinity,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFF5F5F5),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(color: Color(0xFFE5E7EB)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          Icon(
                                            _isFaceScanned && _isKtpUploaded
                                                ? Icons.check_circle
                                                : Icons.hourglass_empty,
                                            size: 24,
                                            color: _isFaceScanned && _isKtpUploaded
                                                ? Colors.green
                                                : Colors.grey,
                                          ),
                                          const SizedBox(height: 14),
                                          Text(
                                            _isFaceScanned && _isKtpUploaded
                                                ? 'Verification Complete'
                                                : 'Verification in Progress',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            _isFaceScanned && _isKtpUploaded
                                                ? 'You can now create an event'
                                                : 'Estimated time: 1-2 hours',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Color(0xFF525252),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: _continueToCreateEvent,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: _isFaceScanned && _isKtpUploaded
                                                  ? AppColors.primary
                                                  : const Color(0xFFD4D4D4),
                                              minimumSize: const Size(326, 36),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              'Continue to Create Event',
                                              style: TextStyle(
                                                color: _isFaceScanned && _isKtpUploaded
                                                    ? AppColors.white
                                                    : const Color(0xFF525252),
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 