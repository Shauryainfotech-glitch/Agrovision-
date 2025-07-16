import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'providers/user_provider.dart';
import 'providers/farm_provider.dart';
import 'providers/subscription_provider.dart';
import 'utils/app_theme.dart';
import 'utils/app_constants.dart';

void main() {
  runApp(const AgroVisionApp());
}

class AgroVisionApp extends StatelessWidget {
  const AgroVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => FarmProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
        locale: const Locale('hi', 'IN'), // Default to Hindi
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('hi', 'IN'),
          Locale('ta', 'IN'),
          Locale('te', 'IN'),
          Locale('bn', 'IN'),
          Locale('gu', 'IN'),
          Locale('pa', 'IN'),
        ],
      ),
    );
  }
}
