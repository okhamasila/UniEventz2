import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/app_colors.dart';

class KtpVerificationDetailScreen extends StatefulWidget {
  final User user;

  const KtpVerificationDetailScreen({
    super.key,
    required this.user,
  });

  @override
  State<KtpVerificationDetailScreen> createState() => _KtpVerificationDetailScreenState();
}

class _KtpVerificationDetailScreenState extends State<KtpVerificationDetailScreen> {
  final TextEditingController _rejectionReasonController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _rejectionReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KTP Verification',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Card
            _buildUserInfoCard(),
            
            const SizedBox(height: 24),
            
            // KTP Image Section
            if (widget.user.ktpImageUrl != null) ...[
              _buildKtpImageSection(),
              const SizedBox(height: 24),
            ],
            
            // Verification Status Section
            _buildVerificationStatusSection(),
            
            const SizedBox(height: 24),
            
            // Action Buttons (only for pending verifications)
            if (widget.user.ktpVerificationStatus == KtpVerificationStatus.pending)
              _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: widget.user.profileImage != null
                      ? NetworkImage(widget.user.profileImage!)
                      : null,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: widget.user.profileImage == null
                      ? Text(
                          widget.user.name.isNotEmpty ? widget.user.name[0].toUpperCase() : 'U',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.user.email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (widget.user.phoneNumber != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.user.phoneNumber!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // User Details
            _buildInfoRow('User ID', widget.user.id),
            _buildInfoRow('Member Since', _formatDate(widget.user.createdAt)),
            _buildInfoRow('Last Updated', _formatDate(widget.user.updatedAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKtpImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'KTP Image',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.grey.withOpacity(0.3),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.user.ktpImageUrl!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48,
                          color: AppColors.error,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Failed to load image',
                          style: TextStyle(
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Image Actions
        Row(
          children: [
            TextButton.icon(
              onPressed: () {
                _showImageDialog();
              },
              icon: const Icon(Icons.zoom_in),
              label: const Text('View Full Size'),
            ),
            const SizedBox(width: 16),
            TextButton.icon(
              onPressed: () {
                // TODO: Implement download functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Download functionality not implemented'),
                  ),
                );
              },
              icon: const Icon(Icons.download),
              label: const Text('Download'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerificationStatusSection() {
    Color statusColor;
    IconData statusIcon;
    
    switch (widget.user.ktpVerificationStatus) {
      case KtpVerificationStatus.pending:
        statusColor = AppColors.warning;
        statusIcon = Icons.pending;
        break;
      case KtpVerificationStatus.approved:
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle;
        break;
      case KtpVerificationStatus.rejected:
        statusColor = AppColors.error;
        statusIcon = Icons.cancel;
        break;
      case KtpVerificationStatus.notSubmitted:
        statusColor = AppColors.grey;
        statusIcon = Icons.help_outline;
        break;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verification Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: statusColor.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    statusIcon,
                    color: statusColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.user.ktpVerificationStatus.displayName,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Status Details
            if (widget.user.ktpSubmissionDate != null)
              _buildInfoRow('Submitted', _formatDate(widget.user.ktpSubmissionDate!)),
            
            if (widget.user.ktpVerificationDate != null)
              _buildInfoRow('Verified', _formatDate(widget.user.ktpVerificationDate!)),
            
            if (widget.user.ktpRejectionReason != null) ...[
              const SizedBox(height: 12),
              const Text(
                'Rejection Reason:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.error.withOpacity(0.3)),
                ),
                child: Text(
                  widget.user.ktpRejectionReason!,
                  style: const TextStyle(
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Approve Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _isProcessing ? null : _approveVerification,
            icon: _isProcessing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  )
                : const Icon(Icons.check_circle),
            label: Text(_isProcessing ? 'Processing...' : 'Approve KTP'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Reject Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _isProcessing ? null : _showRejectDialog,
            icon: const Icon(Icons.cancel),
            label: const Text('Reject KTP'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _approveVerification() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        Provider.of<UserProvider>(context, listen: false)
            .approveKtpVerification(widget.user.id);
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('KTP verification approved successfully'),
            backgroundColor: AppColors.success,
          ),
        );
        
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error approving verification: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _showRejectDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject KTP Verification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please provide a reason for rejecting this KTP verification:',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rejectionReasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter rejection reason...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _rejectionReasonController.clear();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_rejectionReasonController.text.trim().isNotEmpty) {
                Navigator.pop(context);
                _rejectVerification(_rejectionReasonController.text.trim());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  void _rejectVerification(String reason) async {
    setState(() {
      _isProcessing = true;
    });

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        Provider.of<UserProvider>(context, listen: false)
            .rejectKtpVerification(widget.user.id, reason);
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('KTP verification rejected'),
            backgroundColor: AppColors.error,
          ),
        );
        
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error rejecting verification: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _rejectionReasonController.clear();
      }
    }
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                title: const Text('KTP Image'),
                backgroundColor: AppColors.surface,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: InteractiveViewer(
                  child: Image.network(
                    widget.user.ktpImageUrl!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
} 