class Subscription {
  final String id;
  final String userId;
  final SubscriptionType type;
  final SubscriptionStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final double amount;
  final String currency;
  final List<Feature> includedFeatures;
  final int usageCount;
  final int usageLimit;
  final PaymentMethod paymentMethod;

  Subscription({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.amount,
    required this.currency,
    required this.includedFeatures,
    required this.usageCount,
    required this.usageLimit,
    required this.paymentMethod,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      userId: json['userId'],
      type: SubscriptionType.values.firstWhere(
        (e) => e.toString() == 'SubscriptionType.${json['type']}',
      ),
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.toString() == 'SubscriptionStatus.${json['status']}',
      ),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      includedFeatures: (json['includedFeatures'] as List)
          .map((f) => Feature.fromJson(f))
          .toList(),
      usageCount: json['usageCount'],
      usageLimit: json['usageLimit'],
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.toString() == 'PaymentMethod.${json['paymentMethod']}',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'amount': amount,
      'currency': currency,
      'includedFeatures': includedFeatures.map((f) => f.toJson()).toList(),
      'usageCount': usageCount,
      'usageLimit': usageLimit,
      'paymentMethod': paymentMethod.toString().split('.').last,
    };
  }

  bool get isActive =>
      status == SubscriptionStatus.active && DateTime.now().isBefore(endDate);

  bool get hasUsageLeft => usageCount < usageLimit;

  double get usagePercentage =>
      usageLimit > 0 ? (usageCount / usageLimit) * 100 : 0;
}

class Feature {
  final String id;
  final String name;
  final String nameHindi;
  final FeatureType type;
  final double price;
  final String description;
  final String descriptionHindi;
  final bool isPayPerUse;
  final int usageLimit;
  final List<String> benefits;

  Feature({
    required this.id,
    required this.name,
    required this.nameHindi,
    required this.type,
    required this.price,
    required this.description,
    required this.descriptionHindi,
    required this.isPayPerUse,
    required this.usageLimit,
    required this.benefits,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['id'],
      name: json['name'],
      nameHindi: json['nameHindi'],
      type: FeatureType.values.firstWhere(
        (e) => e.toString() == 'FeatureType.${json['type']}',
      ),
      price: json['price'].toDouble(),
      description: json['description'],
      descriptionHindi: json['descriptionHindi'],
      isPayPerUse: json['isPayPerUse'],
      usageLimit: json['usageLimit'],
      benefits: List<String>.from(json['benefits']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameHindi': nameHindi,
      'type': type.toString().split('.').last,
      'price': price,
      'description': description,
      'descriptionHindi': descriptionHindi,
      'isPayPerUse': isPayPerUse,
      'usageLimit': usageLimit,
      'benefits': benefits,
    };
  }
}

class PayPerUseTransaction {
  final String id;
  final String userId;
  final FeatureType featureType;
  final double amount;
  final DateTime timestamp;
  final TransactionStatus status;
  final String description;
  final Map<String, dynamic> metadata;

  PayPerUseTransaction({
    required this.id,
    required this.userId,
    required this.featureType,
    required this.amount,
    required this.timestamp,
    required this.status,
    required this.description,
    required this.metadata,
  });

  factory PayPerUseTransaction.fromJson(Map<String, dynamic> json) {
    return PayPerUseTransaction(
      id: json['id'],
      userId: json['userId'],
      featureType: FeatureType.values.firstWhere(
        (e) => e.toString() == 'FeatureType.${json['featureType']}',
      ),
      amount: json['amount'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      status: TransactionStatus.values.firstWhere(
        (e) => e.toString() == 'TransactionStatus.${json['status']}',
      ),
      description: json['description'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'featureType': featureType.toString().split('.').last,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'status': status.toString().split('.').last,
      'description': description,
      'metadata': metadata,
    };
  }
}

class SeasonalPlan {
  final String id;
  final String name;
  final String nameHindi;
  final Season season;
  final double price;
  final int durationMonths;
  final List<Feature> features;
  final double acceptanceRate;
  final String description;

  SeasonalPlan({
    required this.id,
    required this.name,
    required this.nameHindi,
    required this.season,
    required this.price,
    required this.durationMonths,
    required this.features,
    required this.acceptanceRate,
    required this.description,
  });

  factory SeasonalPlan.fromJson(Map<String, dynamic> json) {
    return SeasonalPlan(
      id: json['id'],
      name: json['name'],
      nameHindi: json['nameHindi'],
      season: Season.values.firstWhere(
        (e) => e.toString() == 'Season.${json['season']}',
      ),
      price: json['price'].toDouble(),
      durationMonths: json['durationMonths'],
      features: (json['features'] as List)
          .map((f) => Feature.fromJson(f))
          .toList(),
      acceptanceRate: json['acceptanceRate'].toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameHindi': nameHindi,
      'season': season.toString().split('.').last,
      'price': price,
      'durationMonths': durationMonths,
      'features': features.map((f) => f.toJson()).toList(),
      'acceptanceRate': acceptanceRate,
      'description': description,
    };
  }
}

enum SubscriptionType {
  payPerUse,
  kharifSeasonal,
  rabiSeasonal,
  fullYear,
  premium,
}

enum SubscriptionStatus { active, expired, cancelled, pending, suspended }

enum FeatureType {
  consultation,
  diseaseIdentification,
  marketAlerts,
  weatherForecasting,
  soilAnalysis,
  yieldPrediction,
  expertCall,
  premiumSupport,
}

enum PaymentMethod { upi, netBanking, creditCard, debitCard, cash, wallet }

enum TransactionStatus { pending, completed, failed, refunded }

enum Season {
  kharif, // June-October
  rabi, // November-April
  zaid, // April-June
  fullYear,
}

// Pricing constants based on the task requirements
class PricingConstants {
  static const double consultationPrice = 50.0;
  static const double diseaseIdentificationPrice = 10.0;
  static const double marketAlertPrice = 5.0;
  static const double weatherForecastingMonthlyPrice = 20.0;

  static const double kharifSeasonPrice = 400.0;
  static const double rabiSeasonPrice = 300.0;
  static const double fullYearPrice = 600.0;

  static const double consultationAcceptanceRate = 78.0;
  static const double diseaseIdentificationAcceptanceRate = 84.0;
  static const double marketAlertAcceptanceRate = 91.0;
  static const double weatherForecastingAcceptanceRate = 89.0;

  static const double kharifAcceptanceRate = 45.0;
  static const double rabiAcceptanceRate = 52.0;
  static const double fullYearAcceptanceRate = 67.0;

  static const double averageMonthlyUsage = 180.0;
  static const double payPerUseConversionRate = 34.0;
  static const double subscriptionConversionRate = 2.3;
}
