import 'package:flutter/foundation.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [
    // Sample users with different KTP verification statuses
    User(
      id: '1',
      email: 'john.doe@student.university.edu',
      name: 'John Doe',
      profileImage: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
      phoneNumber: '+62812345678',
      ktpVerificationStatus: KtpVerificationStatus.pending,
      ktpImageUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400',
      ktpSubmissionDate: DateTime.now().subtract(const Duration(days: 2)),
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    User(
      id: '2',
      email: 'jane.smith@student.university.edu',
      name: 'Jane Smith',
      profileImage: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150',
      phoneNumber: '+62812345679',
      ktpVerificationStatus: KtpVerificationStatus.approved,
      ktpImageUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400',
      ktpSubmissionDate: DateTime.now().subtract(const Duration(days: 5)),
      ktpVerificationDate: DateTime.now().subtract(const Duration(days: 3)),
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    User(
      id: '3',
      email: 'mike.wilson@student.university.edu',
      name: 'Mike Wilson',
      profileImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      phoneNumber: '+62812345680',
      ktpVerificationStatus: KtpVerificationStatus.rejected,
      ktpImageUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400',
      ktpSubmissionDate: DateTime.now().subtract(const Duration(days: 7)),
      ktpVerificationDate: DateTime.now().subtract(const Duration(days: 5)),
      ktpRejectionReason: 'Image quality is too low. Please submit a clearer photo.',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    User(
      id: '4',
      email: 'sarah.johnson@student.university.edu',
      name: 'Sarah Johnson',
      profileImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
      phoneNumber: '+62812345681',
      ktpVerificationStatus: KtpVerificationStatus.notSubmitted,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    User(
      id: '5',
      email: 'alex.brown@student.university.edu',
      name: 'Alex Brown',
      profileImage: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
      phoneNumber: '+62812345682',
      ktpVerificationStatus: KtpVerificationStatus.pending,
      ktpImageUrl: 'https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=400',
      ktpSubmissionDate: DateTime.now().subtract(const Duration(hours: 6)),
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
  ];

  User? _currentUser;

  List<User> get users => _users;
  User? get currentUser => _currentUser;

  // Get users by verification status
  List<User> getUsersByStatus(KtpVerificationStatus status) {
    return _users.where((user) => user.ktpVerificationStatus == status).toList();
  }

  // Get pending verifications count
  int get pendingVerificationsCount {
    return _users.where((user) => user.ktpVerificationStatus == KtpVerificationStatus.pending).length;
  }

  // Get total users count
  int get totalUsersCount => _users.length;

  // Get verified users count
  int get verifiedUsersCount {
    return _users.where((user) => user.ktpVerificationStatus == KtpVerificationStatus.approved).length;
  }

  // Get rejected users count
  int get rejectedUsersCount {
    return _users.where((user) => user.ktpVerificationStatus == KtpVerificationStatus.rejected).length;
  }

  // Approve KTP verification
  void approveKtpVerification(String userId) {
    final userIndex = _users.indexWhere((user) => user.id == userId);
    if (userIndex != -1) {
      _users[userIndex] = _users[userIndex].copyWith(
        ktpVerificationStatus: KtpVerificationStatus.approved,
        ktpVerificationDate: DateTime.now(),
        ktpRejectionReason: null,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  // Reject KTP verification
  void rejectKtpVerification(String userId, String reason) {
    final userIndex = _users.indexWhere((user) => user.id == userId);
    if (userIndex != -1) {
      _users[userIndex] = _users[userIndex].copyWith(
        ktpVerificationStatus: KtpVerificationStatus.rejected,
        ktpVerificationDate: DateTime.now(),
        ktpRejectionReason: reason,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  // Get user by ID
  User? getUserById(String userId) {
    try {
      return _users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  // Set current user (for authentication)
  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  // Clear current user (for logout)
  void clearCurrentUser() {
    _currentUser = null;
    notifyListeners();
  }

  // Add new user
  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  // Update user
  void updateUser(User updatedUser) {
    final userIndex = _users.indexWhere((user) => user.id == updatedUser.id);
    if (userIndex != -1) {
      _users[userIndex] = updatedUser;
      notifyListeners();
    }
  }

  // Delete user
  void deleteUser(String userId) {
    _users.removeWhere((user) => user.id == userId);
    notifyListeners();
  }

  // Get verification statistics
  Map<String, int> getVerificationStatistics() {
    return {
      'total': totalUsersCount,
      'pending': pendingVerificationsCount,
      'approved': verifiedUsersCount,
      'rejected': rejectedUsersCount,
      'notSubmitted': _users.where((user) => user.ktpVerificationStatus == KtpVerificationStatus.notSubmitted).length,
    };
  }
} 