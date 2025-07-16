class AppConstants {
  static const String appName = 'AgroVision';

  // API Endpoints
  static const String baseUrl = 'https://api.agrovision.com';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String languageKey = 'app_language';

  // Feature Prices (in ₹)
  static const double consultationPrice = 50.0;
  static const double diseaseIdentificationPrice = 10.0;
  static const double marketAlertPrice = 5.0;
  static const double weatherForecastingPrice = 20.0;
  static const double weatherForecastingMonthlyPrice = 20.0;

  // Subscription Prices (in ₹)
  static const double kharifSeasonPrice = 400.0;
  static const double rabiSeasonPrice = 300.0;
  static const double fullYearPrice = 600.0;

  // Acceptance Rates (%)
  static const double kharifAcceptanceRate = 45.0;
  static const double rabiAcceptanceRate = 52.0;
  static const double fullYearAcceptanceRate = 67.0;

  // Image Assets
  static const String logoPath = 'assets/images/logo.png';
  static const String splashBgPath = 'assets/images/splash_bg.png';
  static const String placeholderPath = 'assets/images/placeholder.png';

  // Animation Durations
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration toastDuration = Duration(seconds: 3);

  // Validation Constants
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int otpLength = 6;
  static const int phoneLength = 10;

  // Error Messages
  static const String networkError = 'Please check your internet connection';
  static const String serverError =
      'Something went wrong. Please try again later';
  static const String invalidOTP = 'Invalid OTP. Please try again';
  static const String sessionExpired = 'Session expired. Please login again';
}
