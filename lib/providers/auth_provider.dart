import 'package:flutter/foundation.dart';
import '../models/user.dart';

enum UserRole {
  user,
  admin,
}

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  UserRole? _currentUserRole;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  UserRole? get currentUserRole => _currentUserRole;
  bool get isLoggedIn => _isLoggedIn;
  bool get isAdmin => _currentUserRole == UserRole.admin;
  bool get isUser => _currentUserRole == UserRole.user;

  // Login method that determines user role and returns appropriate route
  Future<String?> login(String identifier, String password) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Admin login
      if (identifier == '2324' && password == '123456') {
        _currentUserRole = UserRole.admin;
        _isLoggedIn = true;
        
        // Create admin user object
        _currentUser = User(
          id: 'admin_2324',
          email: 'admin@unieventz.com',
          name: 'Admin',
          isAdmin: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        notifyListeners();
        return '/admin-home'; // Redirect to admin dashboard
      }
      
      // Regular user login (you can add more user credentials here)
      // For demo purposes, let's add a sample user login
      if (identifier == 'user123' && password == 'password') {
        _currentUserRole = UserRole.user;
        _isLoggedIn = true;
        
        // Create regular user object
        _currentUser = User(
          id: 'user_123',
          email: 'user@student.university.edu',
          name: 'Regular User',
          isAdmin: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        notifyListeners();
        return '/dashboard'; // Redirect to user dashboard
      }
      
      // Invalid credentials
      return null;
    } catch (e) {
      return null;
    }
  }

  // Logout method
  void logout() {
    _currentUser = null;
    _currentUserRole = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  // Check if user has admin privileges
  bool hasAdminAccess() {
    return _isLoggedIn && _currentUserRole == UserRole.admin;
  }

  // Check if user has user privileges
  bool hasUserAccess() {
    return _isLoggedIn && _currentUserRole == UserRole.user;
  }

  // Get appropriate dashboard route based on role
  String getDashboardRoute() {
    if (_currentUserRole == UserRole.admin) {
      return '/admin-home';
    } else if (_currentUserRole == UserRole.user) {
      return '/dashboard';
    }
    return '/login';
  }

  // Auto-login for demo purposes (you can remove this in production)
  void autoLoginAsUser() {
    _currentUserRole = UserRole.user;
    _isLoggedIn = true;
    _currentUser = User(
      id: 'demo_user',
      email: 'demo@student.university.edu',
      name: 'Demo User',
      isAdmin: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    notifyListeners();
  }

  void autoLoginAsAdmin() {
    _currentUserRole = UserRole.admin;
    _isLoggedIn = true;
    _currentUser = User(
      id: 'demo_admin',
      email: 'admin@unieventz.com',
      name: 'Demo Admin',
      isAdmin: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    notifyListeners();
  }
} 