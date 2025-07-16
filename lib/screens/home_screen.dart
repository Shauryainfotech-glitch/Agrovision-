import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/farm_provider.dart';
import '../providers/subscription_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/crop_health_card.dart';
import '../widgets/weather_widget.dart';
import '../widgets/sensor_data_widget.dart';
import '../widgets/quick_actions_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const FieldsScreen(),
    const CameraScreen(),
    const DataScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userProvider = context.read<UserProvider>();
    final farmProvider = context.read<FarmProvider>();
    final subscriptionProvider = context.read<SubscriptionProvider>();

    if (userProvider.user != null) {
      await Future.wait([
        farmProvider.loadFarms(userProvider.user!.id),
        subscriptionProvider.loadSubscriptionData(userProvider.user!.id),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Fields',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Data'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgroVision Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Show notifications
            },
          ),
        ],
      ),
      body: Consumer3<UserProvider, FarmProvider, SubscriptionProvider>(
        builder:
            (context, userProvider, farmProvider, subscriptionProvider, child) {
              if (farmProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return RefreshIndicator(
                onRefresh: () async {
                  if (userProvider.user != null) {
                    await farmProvider.loadFarms(userProvider.user!.id);
                  }
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Message
                      Text(
                        'Welcome back, ${userProvider.user?.name ?? 'Farmer'}!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Here\'s your farm overview for today',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Weather Widget
                      const WeatherWidget(),
                      const SizedBox(height: 16),

                      // Quick Actions
                      const QuickActionsWidget(),
                      const SizedBox(height: 16),

                      // Farm Overview
                      if (farmProvider.farms.isNotEmpty) ...[
                        Text(
                          'Your Farms',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...farmProvider.farms.map(
                          (farm) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CropHealthCard(farm: farm),
                          ),
                        ),
                      ] else ...[
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.agriculture,
                                  size: 64,
                                  color: AppTheme.textSecondary,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'No farms added yet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Add your first farm to get started',
                                  style: TextStyle(
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    // TODO: Navigate to add farm screen
                                  },
                                  child: const Text('Add Farm'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 16),

                      // Sensor Data Overview
                      if (farmProvider.selectedFarm != null)
                        SensorDataWidget(farm: farmProvider.selectedFarm!),
                    ],
                  ),
                ),
              );
            },
      ),
    );
  }
}

class FieldsScreen extends StatelessWidget {
  const FieldsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Fields'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Add new field
            },
          ),
        ],
      ),
      body: Consumer<FarmProvider>(
        builder: (context, farmProvider, child) {
          if (farmProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (farmProvider.farms.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.agriculture,
                    size: 64,
                    color: AppTheme.textSecondary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No fields added yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: farmProvider.farms.length,
            itemBuilder: (context, index) {
              final farm = farmProvider.farms[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppTheme.primaryGreen,
                    child: Icon(Icons.agriculture, color: Colors.white),
                  ),
                  title: Text(farm.name),
                  subtitle: Text(
                    '${farm.area} acres • ${farm.crops.join(', ')}',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    farmProvider.selectFarm(farm.id);
                    // TODO: Navigate to farm details
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crop Scanner')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 64, color: AppTheme.primaryGreen),
            SizedBox(height: 16),
            Text(
              'Camera feature coming soon',
              style: TextStyle(fontSize: 18, color: AppTheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics, size: 64, color: AppTheme.primaryGreen),
            SizedBox(height: 16),
            Text(
              'Analytics feature coming soon',
              style: TextStyle(fontSize: 18, color: AppTheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final user = userProvider.user;
          if (user == null) {
            return const Center(child: Text('No user data'));
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Profile Header
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: AppTheme.primaryGreen,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.phone,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Profile Options
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Edit Profile'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // TODO: Navigate to edit profile
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Language'),
                      subtitle: Text(user.language),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // TODO: Change language
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.subscriptions),
                      title: const Text('Subscription'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // TODO: Navigate to subscription
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () async {
                        await userProvider.logout();
                        if (context.mounted) {
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
