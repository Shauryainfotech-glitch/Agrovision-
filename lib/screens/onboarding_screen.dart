import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to AgroVision',
      titleHindi: 'AgroVision में आपका स्वागत है',
      description: 'Smart farming solutions for Indian farmers',
      descriptionHindi: 'भारतीय किसानों के लिए स्मार्ट खेती के समाधान',
      icon: Icons.agriculture,
      color: AppTheme.primaryGreen,
    ),
    OnboardingPage(
      title: 'AI-Powered Disease Detection',
      titleHindi: 'AI से बीमारी की पहचान',
      description: 'Identify crop diseases instantly with your camera',
      descriptionHindi: 'अपने कैमरे से फसल की बीमारी तुरंत पहचानें',
      icon: Icons.camera_alt,
      color: AppTheme.skyBlue,
    ),
    OnboardingPage(
      title: 'Expert Consultation',
      titleHindi: 'विशेषज्ञ परामर्श',
      description: 'Get advice from agricultural experts anytime',
      descriptionHindi: 'कभी भी कृषि विशेषज्ञों से सलाह लें',
      icon: Icons.support_agent,
      color: AppTheme.earthBrown,
    ),
    OnboardingPage(
      title: 'Smart Monitoring',
      titleHindi: 'स्मार्ट निगरानी',
      description: 'Monitor your crops with IoT sensors',
      descriptionHindi: 'IoT सेंसर से अपनी फसल की निगरानी करें',
      icon: Icons.sensors,
      color: AppTheme.alertOrange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 60),
                  // Page indicators
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? AppTheme.primaryGreen
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous button
                  if (_currentPage > 0)
                    OutlinedButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text('Previous'),
                    )
                  else
                    const SizedBox(width: 80),
                  // Next/Get Started button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _pages[_currentPage].color,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      _currentPage < _pages.length - 1 ? 'Next' : 'Get Started',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: page.color.withOpacity(0.1),
              border: Border.all(color: page.color, width: 2),
            ),
            child: Icon(page.icon, size: 60, color: page.color),
          ),
          const SizedBox(height: 48),
          // Title
          Text(
            page.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Hindi title
          Text(
            page.titleHindi,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Description
          Text(
            page.description,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Hindi description
          Text(
            page.descriptionHindi,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textLight,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class OnboardingPage {
  final String title;
  final String titleHindi;
  final String description;
  final String descriptionHindi;
  final IconData icon;
  final Color color;

  OnboardingPage({
    required this.title,
    required this.titleHindi,
    required this.description,
    required this.descriptionHindi,
    required this.icon,
    required this.color,
  });
}
