import 'package:flutter/foundation.dart';
import '../models/subscription_model.dart';
import '../utils/app_constants.dart';

class SubscriptionProvider with ChangeNotifier {
  Subscription? _currentSubscription;
  List<SeasonalPlan> _seasonalPlans = [];
  List<Feature> _features = [];
  List<PayPerUseTransaction> _transactions = [];
  bool _isLoading = false;
  String _error = '';

  Subscription? get currentSubscription => _currentSubscription;
  List<SeasonalPlan> get seasonalPlans => _seasonalPlans;
  List<Feature> get features => _features;
  List<PayPerUseTransaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadSubscriptionData(String userId) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      // TODO: Implement API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // Load features
      _features = [
        Feature(
          id: '1',
          name: 'Expert Consultation',
          nameHindi: 'विशेषज्ञ परामर्श',
          type: FeatureType.consultation,
          price: AppConstants.consultationPrice,
          description: 'Get expert advice from agricultural specialists',
          descriptionHindi: 'कृषि विशेषज्ञों से सलाह लें',
          isPayPerUse: true,
          usageLimit: 10,
          benefits: [
            'Direct video call with experts',
            'Quick response within 15 minutes',
            'Follow-up consultation included',
          ],
        ),
        Feature(
          id: '2',
          name: 'Disease Identification',
          nameHindi: 'बीमारी की पहचान',
          type: FeatureType.diseaseIdentification,
          price: AppConstants.diseaseIdentificationPrice,
          description: 'AI-powered crop disease detection',
          descriptionHindi: 'AI द्वारा फसल की बीमारी की पहचान',
          isPayPerUse: true,
          usageLimit: 50,
          benefits: [
            'Instant disease detection',
            'Treatment recommendations',
            'Disease progression tracking',
          ],
        ),
        Feature(
          id: '3',
          name: 'Market Price Alerts',
          nameHindi: 'बाजार मूल्य अलर्ट',
          type: FeatureType.marketAlerts,
          price: AppConstants.marketAlertPrice,
          description: 'Real-time market price notifications',
          descriptionHindi: 'वास्तविक समय बाजार मूल्य सूचनाएं',
          isPayPerUse: true,
          usageLimit: 100,
          benefits: [
            'Price predictions',
            'Best market recommendations',
            'Price trend analysis',
          ],
        ),
        Feature(
          id: '4',
          name: 'Weather Forecasting',
          nameHindi: 'मौसम पूर्वानुमान',
          type: FeatureType.weatherForecasting,
          price: AppConstants.weatherForecastingMonthlyPrice,
          description: 'Advanced weather predictions',
          descriptionHindi: 'उन्नत मौसम भविष्यवाणी',
          isPayPerUse: false,
          usageLimit: -1,
          benefits: [
            'Hourly weather updates',
            'Rain predictions',
            'Frost warnings',
          ],
        ),
      ];

      // Load seasonal plans
      _seasonalPlans = [
        SeasonalPlan(
          id: '1',
          name: 'Kharif Season Plan',
          nameHindi: 'खरीफ सीजन प्लान',
          season: Season.kharif,
          price: AppConstants.kharifSeasonPrice,
          durationMonths: 4,
          features: _features,
          acceptanceRate: AppConstants.kharifAcceptanceRate,
          description: 'Complete coverage for monsoon crops',
        ),
        SeasonalPlan(
          id: '2',
          name: 'Rabi Season Plan',
          nameHindi: 'रबी सीजन प्लान',
          season: Season.rabi,
          price: AppConstants.rabiSeasonPrice,
          durationMonths: 3,
          features: _features,
          acceptanceRate: AppConstants.rabiAcceptanceRate,
          description: 'Essential features for winter crops',
        ),
        SeasonalPlan(
          id: '3',
          name: 'Full Year Plan',
          nameHindi: 'पूरा साल प्लान',
          season: Season.fullYear,
          price: AppConstants.fullYearPrice,
          durationMonths: 12,
          features: _features,
          acceptanceRate: AppConstants.fullYearAcceptanceRate,
          description: 'Year-round coverage at best value',
        ),
      ];

      // Load current subscription if any
      _currentSubscription = Subscription(
        id: '1',
        userId: userId,
        type: SubscriptionType.payPerUse,
        status: SubscriptionStatus.active,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        amount: 0,
        currency: 'INR',
        includedFeatures: _features,
        usageCount: 0,
        usageLimit: 100,
        paymentMethod: PaymentMethod.upi,
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> purchaseFeature(String userId, Feature feature) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement payment gateway integration
      await Future.delayed(const Duration(seconds: 1)); // Simulate payment

      final transaction = PayPerUseTransaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        featureType: feature.type,
        amount: feature.price,
        timestamp: DateTime.now(),
        status: TransactionStatus.completed,
        description: 'Purchase of ${feature.name}',
        metadata: {'featureId': feature.id, 'usageLimit': feature.usageLimit},
      );

      _transactions.add(transaction);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> subscribeToPlan(
    String userId,
    SeasonalPlan plan,
    PaymentMethod paymentMethod,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement payment gateway integration
      await Future.delayed(const Duration(seconds: 1)); // Simulate payment

      _currentSubscription = Subscription(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        type: plan.season == Season.fullYear
            ? SubscriptionType.fullYear
            : (plan.season == Season.kharif
                  ? SubscriptionType.kharifSeasonal
                  : SubscriptionType.rabiSeasonal),
        status: SubscriptionStatus.active,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: plan.durationMonths * 30)),
        amount: plan.price,
        currency: 'INR',
        includedFeatures: plan.features,
        usageCount: 0,
        usageLimit: -1, // Unlimited for seasonal plans
        paymentMethod: paymentMethod,
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> cancelSubscription() async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      if (_currentSubscription != null) {
        _currentSubscription = Subscription(
          id: _currentSubscription!.id,
          userId: _currentSubscription!.userId,
          type: _currentSubscription!.type,
          status: SubscriptionStatus.cancelled,
          startDate: _currentSubscription!.startDate,
          endDate: _currentSubscription!.endDate,
          amount: _currentSubscription!.amount,
          currency: _currentSubscription!.currency,
          includedFeatures: _currentSubscription!.includedFeatures,
          usageCount: _currentSubscription!.usageCount,
          usageLimit: _currentSubscription!.usageLimit,
          paymentMethod: _currentSubscription!.paymentMethod,
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  bool canUseFeature(FeatureType featureType) {
    if (_currentSubscription == null) return false;

    if (_currentSubscription!.status != SubscriptionStatus.active) return false;

    if (_currentSubscription!.type == SubscriptionType.payPerUse) {
      return _currentSubscription!.hasUsageLeft;
    }

    return _currentSubscription!.includedFeatures.any(
      (feature) => feature.type == featureType,
    );
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }
}
