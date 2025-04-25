import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/create_event_screen.dart';
import 'screens/register_event_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniEventz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const MainScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/create-event': (context) => const CreateEventScreen(),
      },
      onGenerateRoute: (settings) {
        // Handle routes that require authentication
        if (settings.name == '/create-event') {
          // Check if user is logged in
          final isLoggedIn = false; // Replace with actual authentication check
          
          if (!isLoggedIn) {
            // Redirect to login screen if not authenticated
            return MaterialPageRoute(
              builder: (context) => const LoginScreen(),
              settings: RouteSettings(
                name: '/login',
                arguments: {
                  'redirectTo': settings.name,
                  'redirectArgs': settings.arguments,
                },
              ),
            );
          }
        }

        // Handle register event route with required parameters
        if (settings.name == '/register-event') {
          final args = settings.arguments as Map<String, dynamic>?;
          if (args == null) {
            // If no arguments provided, redirect to home
            return MaterialPageRoute(builder: (context) => const MainScreen());
          }

          return MaterialPageRoute(
            builder: (context) => RegisterEventScreen(
              eventId: args['eventId'] as String,
              eventTitle: args['eventTitle'] as String,
              eventDate: args['eventDate'] as String,
              eventLocation: args['eventLocation'] as String,
              eventPrice: args['eventPrice'] as String,
              eventOrganizer: args['eventOrganizer'] as String,
            ),
          );
        }

        return null;
      },
    );
  }
}
