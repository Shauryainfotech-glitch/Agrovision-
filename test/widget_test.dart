import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import '../lib/main.dart';
import '../lib/providers/user_provider.dart';
import '../lib/providers/farm_provider.dart';
import '../lib/providers/subscription_provider.dart';
import '../lib/screens/splash_screen.dart';
import '../lib/screens/onboarding_screen.dart';
import '../lib/screens/login_screen.dart';
import '../lib/screens/home_screen.dart';
import '../lib/widgets/weather_widget.dart';
import '../lib/widgets/quick_actions_widget.dart';
import '../lib/widgets/crop_health_card.dart';
import '../lib/widgets/sensor_data_widget.dart';
import '../lib/models/farm_model.dart';

void main() {
  group('AgroVision App Tests', () {
    testWidgets('App starts with splash screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => FarmProvider()),
            ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
          ],
          child: const MaterialApp(home: SplashScreen()),
        ),
      );

      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);

      // Wait for splash screen animation
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('Onboarding screen shows all pages', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));

      // Verify first onboarding page
      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(find.text('Welcome to AgroVision'), findsOneWidget);

      // Swipe through pages
      await tester.drag(find.byType(PageView), const Offset(-500, 0));
      await tester.pumpAndSettle();

      // Verify second page
      expect(find.text('AI-Powered Disease Detection'), findsOneWidget);

      // Continue swiping
      await tester.drag(find.byType(PageView), const Offset(-500, 0));
      await tester.pumpAndSettle();

      // Verify third page
      expect(find.text('Expert Consultation'), findsOneWidget);
    });

    testWidgets('Login screen validates phone number', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
          child: const MaterialApp(home: LoginScreen()),
        ),
      );

      // Try submitting without phone number
      await tester.tap(find.text('Send OTP'));
      await tester.pump();

      // Verify validation error
      expect(find.text('Please enter your phone number'), findsOneWidget);

      // Enter valid phone number
      await tester.enterText(find.byType(TextFormField), '9876543210');
      await tester.tap(find.text('Send OTP'));
      await tester.pump();

      // Verify OTP field appears
      expect(find.text('Enter OTP'), findsOneWidget);
    });

    testWidgets('Home screen shows farm data', (WidgetTester tester) async {
      final farmProvider = FarmProvider();
      await farmProvider.loadFarms('test_user');

      await tester.pumpWidget(
        MultiProvider(
          providers: [ChangeNotifierProvider.value(value: farmProvider)],
          child: const MaterialApp(home: HomeScreen()),
        ),
      );

      // Verify dashboard components
      expect(find.byType(WeatherWidget), findsOneWidget);
      expect(find.byType(QuickActionsWidget), findsOneWidget);
      expect(find.byType(CropHealthCard), findsWidgets);
      expect(find.byType(SensorDataWidget), findsWidgets);
    });

    testWidgets('Weather widget shows correct data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: WeatherWidget()));

      expect(find.text('Weather'), findsOneWidget);
      expect(find.byIcon(Icons.cloud), findsOneWidget);
      expect(find.text('Temperature'), findsOneWidget);
      expect(find.text('Humidity'), findsOneWidget);
    });

    testWidgets('Crop health card shows farm details', (
      WidgetTester tester,
    ) async {
      final farm = Farm(
        id: '1',
        name: 'Test Farm',
        ownerId: 'test_user',
        area: 5.0,
        crops: ['Wheat'],
        sensors: [],
        location: Location(
          latitude: 30.7333,
          longitude: 76.7794,
          address: 'Test Address',
          district: 'Test District',
          state: 'Test State',
          pincode: '123456',
        ),
        soilType: 'Loamy',
        irrigationType: 'Drip',
        isOrganic: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        plots: [],
        waterSource: WaterSource.tubewell,
        activities: [],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CropHealthCard(farm: farm)),
        ),
      );

      expect(find.text('Test Farm'), findsOneWidget);
      expect(find.text('5.0 acres'), findsOneWidget);
      expect(find.text('Wheat'), findsOneWidget);
    });

    testWidgets('Quick actions show all buttons', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: QuickActionsWidget()));

      expect(find.text('Scan Crop'), findsOneWidget);
      expect(find.text('Expert Call'), findsOneWidget);
      expect(find.text('Market Prices'), findsOneWidget);
      expect(find.text('Irrigation'), findsOneWidget);
    });

    testWidgets('Sensor data widget shows readings', (
      WidgetTester tester,
    ) async {
      final sensors = [
        SensorData(
          id: '1',
          type: SensorType.soilMoisture,
          value: 65.0,
          unit: '%',
          timestamp: DateTime.now(),
          locationName: 'Test Location',
          isOnline: true,
          batteryLevel: 85.0,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SensorDataWidget(sensors: sensors)),
        ),
      );

      expect(find.text('Soil Moisture'), findsOneWidget);
      expect(find.text('65.0%'), findsOneWidget);
      expect(find.text('Test Location'), findsOneWidget);
    });
  });

  group('Provider Tests', () {
    test('FarmProvider loads farms correctly', () async {
      final provider = FarmProvider();
      await provider.loadFarms('test_user');

      expect(provider.farms.length, 2);
      expect(provider.selectedFarm, isNotNull);
      expect(provider.isLoading, false);
      expect(provider.error, isEmpty);
    });

    test('UserProvider handles authentication', () async {
      final provider = UserProvider();
      await provider.login('9876543210', '123456');

      expect(provider.isAuthenticated, true);
      expect(provider.user, isNotNull);
      expect(provider.error, isEmpty);
    });

    test('SubscriptionProvider manages plans', () async {
      final provider = SubscriptionProvider();
      await provider.loadSubscriptionData('test_user');

      expect(provider.activePlan, isNotNull);
      expect(provider.isLoading, false);
      expect(provider.error, isEmpty);
    });
  });
}
