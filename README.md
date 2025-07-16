# AgroVision - Smart Agricultural Monitoring App

AgroVision is a comprehensive Flutter-based mobile application designed specifically for Indian farmers, agricultural officers, and government departments. The app provides AI-powered crop monitoring, disease identification, expert consultation, and smart farming solutions.

## Features

### 🌾 Core Agricultural Features
- **AI-Powered Disease Detection**: Instant crop disease identification using camera
- **Expert Consultation**: Video/voice calls with agricultural specialists
- **Smart Monitoring**: IoT sensor integration for real-time field data
- **Weather Forecasting**: Localized weather predictions for farming decisions
- **Market Price Analytics**: Real-time crop price tracking and predictions

### 💰 Subscription Models
- **Pay-per-Use Model**: 
  - Consultation: ₹50 per session (78% acceptance)
  - Disease identification: ₹10 per scan (84% acceptance)
  - Market alerts: ₹5 per alert (91% acceptance)
  - Weather forecasting: ₹20 per month (89% acceptance)

- **Seasonal Subscription Model**:
  - Kharif season: ₹400 (4 months) - 45% acceptance
  - Rabi season: ₹300 (3 months) - 52% acceptance
  - Full year: ₹600 (vs ₹3,588 monthly) - 67% acceptance

### 🎯 User Demographics Support
- **Age Groups**: 18-30 (Tech-savvy), 31-45 (Progressive), 46-60 (Traditional), 60+ (Elder)
- **Farm Sizes**: Marginal (<1 acre), Small (1-5 acres), Medium (5-20 acres), Large (20+ acres)
- **Education Levels**: Primary to Post-Graduate
- **Regional Languages**: Hindi, Tamil, Telugu, Bengali, Gujarati, Punjabi

## Technical Architecture

### 📱 Frontend (Flutter)
```
lib/
├── models/           # Data models (User, Farm, Disease, Subscription)
├── providers/        # State management (Provider pattern)
├── screens/          # UI screens (Splash, Onboarding, Home, Login)
├── widgets/          # Reusable UI components
├── services/         # API and business logic services
├── utils/           # Constants, themes, and utilities
└── main.dart        # App entry point
```

### 🎨 Design System
- **Agricultural Color Palette**: Earth tones with vibrant crop colors
- **Field-Optimized UI**: High contrast for outdoor visibility
- **Touch-Friendly**: Large targets for muddy/gloved hands
- **Multi-Language**: Regional script support

### 🔧 Key Dependencies
```yaml
dependencies:
  flutter: sdk
  provider: ^6.1.1          # State management
  http: ^1.1.0              # API calls
  camera: ^0.10.5+5         # Disease detection
  geolocator: ^10.1.0       # Location services
  fl_chart: ^0.66.0         # Data visualization
  shared_preferences: ^2.2.2 # Local storage
  connectivity_plus: ^5.0.2 # Network status
```

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation
1. Clone the repository:
```bash
git clone <repository-url>
cd agrovision
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### For Web Development:
```bash
flutter run -d chrome --web-port 8080
```

## App Flow

### 1. Onboarding Journey
```
Splash Screen → Onboarding → Login/Register → Home Dashboard
```

### 2. Main Navigation
- **Dashboard**: Farm overview, weather, quick actions
- **Fields**: Farm management and crop monitoring
- **Scanner**: AI-powered disease detection
- **Analytics**: Sensor data and insights
- **Profile**: User settings and subscription

### 3. Key User Flows

#### Disease Detection Flow:
```
Camera → AI Analysis → Disease Identification → Treatment Recommendations → Expert Consultation (Optional)
```

#### Subscription Flow:
```
Feature Usage → Payment Options → Pay-per-Use OR Seasonal Plan → Payment Gateway → Feature Access
```

## Agricultural Domain Features

### 🌱 Crop Management
- **Supported Crops**: Wheat, Rice, Cotton, Sugarcane, Maize
- **Growth Stages**: Tracking from planting to harvest
- **Seasonal Planning**: Kharif, Rabi, and Zaid season support

### 📊 IoT Sensor Integration
- **Soil Monitoring**: Moisture, pH, nutrients (NPK)
- **Environmental**: Temperature, humidity, light intensity
- **Irrigation**: Automated watering based on sensor data

### 🎯 Regional Adaptations
- **North India**: Wheat/rice belt focus, mechanization support
- **South India**: Multi-crop management, water conservation
- **East India**: Small-scale farming, traditional method integration
- **West India**: Commercial farming, export crop support

## Revenue Model Implementation

### Pay-per-Use Features
```dart
// Example pricing structure
static const double consultationPrice = 50.0;
static const double diseaseIdentificationPrice = 10.0;
static const double marketAlertPrice = 5.0;
```

### Conversion Optimization
- **High-Potential Segments**: Tech-savvy young farmers, large commercial farmers
- **Medium-Potential**: Progressive mid-size farmers, educated small farmers
- **Long-term**: Traditional farmers, small-scale farmers

## Testing

### Run Tests
```bash
flutter test
```

### Widget Testing
```bash
flutter test test/widget_test.dart
```

## Deployment

### Android APK
```bash
flutter build apk --release
```

### iOS App
```bash
flutter build ios --release
```

### Web Deployment
```bash
flutter build web
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/agricultural-feature`)
3. Commit changes (`git commit -am 'Add agricultural feature'`)
4. Push to branch (`git push origin feature/agricultural-feature`)
5. Create Pull Request

## Agricultural Compliance

### Government Integration
- **Data Standards**: Compatible with government agricultural databases
- **Reporting**: Automated compliance reports for agricultural departments
- **Schemes**: Integration with government subsidy and welfare schemes

### Privacy & Security
- **Farmer Data Protection**: GDPR-compliant data handling
- **Offline Functionality**: Works without internet connectivity
- **Local Storage**: Sensitive data stored locally when possible

## Future Roadmap

### Phase 1 (Current)
- ✅ Basic app structure and navigation
- ✅ User authentication and profiles
- ✅ Farm management system
- ✅ Subscription model implementation

### Phase 2 (Next 3 months)
- 🔄 AI disease detection integration
- 🔄 IoT sensor connectivity
- 🔄 Expert consultation platform
- 🔄 Payment gateway integration

### Phase 3 (6-12 months)
- 📋 Advanced analytics and predictions
- 📋 Marketplace integration
- 📋 Insurance and financial services
- 📋 International expansion

## Support

For technical support or agricultural domain questions:
- Email: support@agrovision.com
- Phone: 1800-XXX-XXXX (Toll-free)
- Languages: Hindi, English, and regional languages

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**AgroVision** - Empowering Indian Agriculture with Technology 🌾📱
