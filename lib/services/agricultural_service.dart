import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/farm_model.dart';
import '../models/disease_model.dart';

class AgriculturalService {
  static const String baseUrl = 'https://api.agrovision.com/v1';

  // Weather service
  Future<Map<String, dynamic>> getCurrentWeather(String location) async {
    try {
      // Mock weather data for now
      return {
        'temperature': 28.5,
        'humidity': 65,
        'windSpeed': 12,
        'precipitation': 30,
        'condition': 'partly_cloudy',
      };
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }

  // Disease identification service
  Future<DiseaseIdentificationResult> identifyDisease(String imagePath) async {
    try {
      // Mock disease identification for now
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      return DiseaseIdentificationResult(
        diseaseName: 'Brown Leaf Spot',
        confidence: 0.89,
        description: 'A common fungal disease affecting rice crops',
        treatments: [
          Treatment(
            id: '1',
            name: 'Fungicide Application',
            nameHindi: 'फफूंदनाशी का प्रयोग',
            description: 'Apply copper-based fungicide',
            type: TreatmentType.chemical,
            cost: 150.0,
            effectiveness: 0.85,
            dosage: '2ml per liter',
            applicationMethod: 'Foliar spray',
            frequency: 'Every 7 days',
            precautions: ['Wear protective gear', 'Avoid during flowering'],
            isOrganic: false,
            availability: TreatmentAvailability.inStock,
          ),
          Treatment(
            id: '2',
            name: 'Organic Treatment',
            nameHindi: 'जैविक उपचार',
            description: 'Use neem oil spray',
            type: TreatmentType.organic,
            cost: 80.0,
            effectiveness: 0.70,
            dosage: '5ml per liter',
            applicationMethod: 'Foliar spray',
            frequency: 'Every 5 days',
            precautions: ['Apply in evening', 'Test on small area first'],
            isOrganic: true,
            availability: TreatmentAvailability.inStock,
          ),
        ],
        severity: DiseaseSeverity.moderate,
        affectedArea: 0.35,
      );
    } catch (e) {
      throw Exception('Failed to identify disease: $e');
    }
  }

  // Market price service
  Future<List<MarketPrice>> getMarketPrices(String cropType) async {
    try {
      // Mock market data
      return [
        MarketPrice(
          crop: cropType,
          price: 2850.0,
          unit: 'quintal',
          market: 'Delhi Mandi',
          date: DateTime.now(),
          trend: PriceTrend.up,
          changePercent: 4.8,
        ),
        MarketPrice(
          crop: cropType,
          price: 2780.0,
          unit: 'quintal',
          market: 'Mumbai Mandi',
          date: DateTime.now(),
          trend: PriceTrend.up,
          changePercent: 3.2,
        ),
      ];
    } catch (e) {
      throw Exception('Failed to fetch market prices: $e');
    }
  }

  // Expert consultation service
  Future<List<Expert>> getAvailableExperts(String specialization) async {
    try {
      // Mock expert data
      return [
        Expert(
          id: '1',
          name: 'Dr. Rajesh Kumar',
          specialization: 'Crop Disease Management',
          rating: 4.8,
          experience: 15,
          languages: ['Hindi', 'English', 'Punjabi'],
          isAvailable: true,
          consultationFee: 50.0,
          profileImage: '',
        ),
        Expert(
          id: '2',
          name: 'Dr. Priya Sharma',
          specialization: 'Soil Health & Nutrition',
          rating: 4.9,
          experience: 12,
          languages: ['Hindi', 'English'],
          isAvailable: true,
          consultationFee: 60.0,
          profileImage: '',
        ),
      ];
    } catch (e) {
      throw Exception('Failed to fetch experts: $e');
    }
  }

  // Sensor data service
  Future<List<SensorData>> getSensorData(String farmId) async {
    try {
      // Mock sensor data
      return [
        SensorData(
          id: '1',
          type: SensorType.soilMoisture,
          value: 68.5,
          unit: '%',
          timestamp: DateTime.now(),
          locationName: 'Field A - Zone 1',
          isOnline: true,
          batteryLevel: 85.0,
        ),
        SensorData(
          id: '2',
          type: SensorType.temperature,
          value: 32.0,
          unit: '°C',
          timestamp: DateTime.now(),
          locationName: 'Field A - Zone 1',
          isOnline: true,
          batteryLevel: 92.0,
        ),
        SensorData(
          id: '3',
          type: SensorType.ph,
          value: 6.8,
          unit: 'pH',
          timestamp: DateTime.now(),
          locationName: 'Field A - Zone 2',
          isOnline: true,
          batteryLevel: 78.0,
        ),
      ];
    } catch (e) {
      throw Exception('Failed to fetch sensor data: $e');
    }
  }

  // Irrigation control service
  Future<bool> controlIrrigation(
    String farmId,
    String action, {
    int? duration,
  }) async {
    try {
      // Mock irrigation control
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      throw Exception('Failed to control irrigation: $e');
    }
  }

  // Crop recommendation service
  Future<List<CropRecommendation>> getCropRecommendations(
    String location,
    String season,
    double farmSize,
  ) async {
    try {
      // Mock crop recommendations
      return [
        CropRecommendation(
          cropName: 'Basmati Rice',
          variety: 'PB1121',
          expectedYield: 4.5,
          profitability: 0.85,
          riskLevel: RiskLevel.low,
          waterRequirement: 'High',
          duration: 120,
          marketDemand: 'High',
          reasons: [
            'High market demand',
            'Suitable for current season',
            'Good profit margins',
          ],
        ),
        CropRecommendation(
          cropName: 'Wheat',
          variety: 'HD2967',
          expectedYield: 5.2,
          profitability: 0.78,
          riskLevel: RiskLevel.low,
          waterRequirement: 'Medium',
          duration: 150,
          marketDemand: 'Medium',
          reasons: [
            'Drought resistant variety',
            'Stable market prices',
            'Lower input costs',
          ],
        ),
      ];
    } catch (e) {
      throw Exception('Failed to fetch crop recommendations: $e');
    }
  }
}

// Supporting classes
class MarketPrice {
  final String crop;
  final double price;
  final String unit;
  final String market;
  final DateTime date;
  final PriceTrend trend;
  final double changePercent;

  MarketPrice({
    required this.crop,
    required this.price,
    required this.unit,
    required this.market,
    required this.date,
    required this.trend,
    required this.changePercent,
  });
}

enum PriceTrend { up, down, stable }

class Expert {
  final String id;
  final String name;
  final String specialization;
  final double rating;
  final int experience;
  final List<String> languages;
  final bool isAvailable;
  final double consultationFee;
  final String profileImage;

  Expert({
    required this.id,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.experience,
    required this.languages,
    required this.isAvailable,
    required this.consultationFee,
    required this.profileImage,
  });
}

class CropRecommendation {
  final String cropName;
  final String variety;
  final double expectedYield;
  final double profitability;
  final RiskLevel riskLevel;
  final String waterRequirement;
  final int duration;
  final String marketDemand;
  final List<String> reasons;

  CropRecommendation({
    required this.cropName,
    required this.variety,
    required this.expectedYield,
    required this.profitability,
    required this.riskLevel,
    required this.waterRequirement,
    required this.duration,
    required this.marketDemand,
    required this.reasons,
  });
}

enum RiskLevel { low, medium, high }
