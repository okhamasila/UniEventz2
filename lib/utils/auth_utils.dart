import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static const String _isLoggedInKey = 'isLoggedIn';

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Set user login status
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  // Show login dialog and redirect to login if needed
  static Future<bool> requireLogin(BuildContext context) async {
    bool isUserLoggedIn = await isLoggedIn();
    
    if (!isUserLoggedIn) {
      // Show dialog asking user to login
      bool shouldLogin = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Required'),
            content: const Text('You need to be logged in to register for events.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Don't login
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Proceed to login
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.amber,
                ),
                child: const Text('Login'),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ) ?? false;

      if (shouldLogin) {
        // Navigate to login page
        Navigator.pushNamed(context, '/login');
      }
      
      return false;
    }
    
    return true;
  }
} 