import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/create_event_screen.dart';
import 'screens/register_event_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/medal_screen.dart';
import 'screens/event_verification_screen.dart';
import 'screens/list_event_screen.dart' as list_screen;
import 'screens/event_details_screen.dart';
import 'screens/event_preview_screen.dart';
import 'screens/my_events_screen.dart';
import 'screens/joined_events_screen.dart';
import 'screens/main_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/profile_edit_screen.dart';
import 'screens/past_events_screen.dart';
import 'screens/past_event_detail_screen.dart';
import 'screens/unified_login_screen.dart';
import 'screens/user_dashboard_screen.dart';
import 'adminScreen/admin_home_screen.dart';
import 'adminScreen/admin_login_screen.dart';
import 'models/event.dart';
import 'utils/app_colors.dart';
import 'providers/notification_provider.dart';
import 'providers/user_provider.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'UniEventz',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            tertiary: AppColors.tertiary,
            surface: AppColors.surface,
            background: AppColors.background,
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.textPrimary),
          ),
          scaffoldBackgroundColor: AppColors.background,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
          cardTheme: CardTheme(
            color: AppColors.surface,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/': (context) => const MainScreen(),
          '/login': (context) => const LoginScreen(),
          '/unified-login': (context) => const UnifiedLoginScreen(),
          '/dashboard': (context) => const UserDashboardScreen(),
          '/signup': (context) => const SignupScreen(),
          '/create-event': (context) => const CreateEventScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/medals': (context) => const MedalScreen(),
          '/event-verification': (context) => const EventVerificationScreen(),
          '/my-events': (context) => const MyEventsScreen(),
          '/joined-events': (context) => const JoinedEventsScreen(),
          '/notifications': (context) => const NotificationScreen(),
          '/admin-home': (context) => const AdminHomeScreen(),
          '/admin-login': (context) => const AdminLoginScreen(),
          '/event-details': (context) {
            final event = ModalRoute.of(context)!.settings.arguments as Event;
            return EventDetailsScreen(event: event);
          },
          '/event-preview': (context) {
            final event = ModalRoute.of(context)!.settings.arguments as Event;
            return EventPreviewScreen(event: event);
          },
          '/settings': (context) => const SettingsScreen(),
          '/edit-profile': (context) => const ProfileEditScreen(),
          '/past-events': (context) => const PastEventsScreen(),
        },
        onGenerateRoute: (settings) {
          // Handle routes that require authentication
          if (settings.name == '/create-event') {
            // Check if user is logged in
            final isLoggedIn = false; // Replace with actual authentication check
            
            if (!isLoggedIn) {
              // Redirect to login screen if not authenticated
              return MaterialPageRoute(
                builder: (context) => const UnifiedLoginScreen(),
                settings: RouteSettings(
                  name: '/unified-login',
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
              return MaterialPageRoute(builder: (context) => const list_screen.ListEventScreen());
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
      ),
    );
  }
}
