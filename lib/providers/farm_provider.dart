import 'package:flutter/foundation.dart';
import '../models/farm_model.dart';

class FarmProvider with ChangeNotifier {
  List<Farm> _farms = [];
  Farm? _selectedFarm;
  bool _isLoading = false;
  String _error = '';

  List<Farm> get farms => _farms;
  Farm? get selectedFarm => _selectedFarm;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadFarms(String userId) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      // TODO: Implement API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // Simulate farm data
      _farms = [
        Farm(
          id: '1',
          name: 'Main Field',
          ownerId: userId,
          area: 5.0,
          crops: ['Wheat', 'Rice'],
          sensors: [
            SensorData(
              id: 'sensor_1',
              type: SensorType.soilMoisture,
              value: 65.0,
              unit: '%',
              timestamp: DateTime.now(),
              locationName: 'Field A',
              isOnline: true,
              batteryLevel: 85.0,
            ),
            SensorData(
              id: 'sensor_2',
              type: SensorType.temperature,
              value: 28.5,
              unit: '°C',
              timestamp: DateTime.now(),
              locationName: 'Field A',
              isOnline: true,
              batteryLevel: 92.0,
            ),
          ],
          location: Location(
            latitude: 30.7333,
            longitude: 76.7794,
            address: 'Village Khanna, Punjab',
            district: 'Ludhiana',
            state: 'Punjab',
            pincode: '141401',
          ),
          soilType: 'Loamy',
          irrigationType: 'Drip',
          isOrganic: false,
          createdAt: DateTime.now().subtract(const Duration(days: 365)),
          updatedAt: DateTime.now(),
          plots: [
            Plot(
              id: '1',
              name: 'Plot A',
              area: 2.5,
              currentCrop: 'Wheat',
              soilType: 'Loamy',
              sensors: [],
              location: Location(
                latitude: 30.7333,
                longitude: 76.7794,
                address: 'Village Khanna, Punjab',
                district: 'Ludhiana',
                state: 'Punjab',
                pincode: '141401',
              ),
            ),
            Plot(
              id: '2',
              name: 'Plot B',
              area: 2.5,
              currentCrop: 'Rice',
              soilType: 'Clay',
              sensors: [],
              location: Location(
                latitude: 30.7334,
                longitude: 76.7795,
                address: 'Village Khanna, Punjab',
                district: 'Ludhiana',
                state: 'Punjab',
                pincode: '141401',
              ),
            ),
          ],
          waterSource: WaterSource.tubewell,
          activities: [
            Activity(
              id: '1',
              type: 'Planting',
              date: DateTime.now().subtract(const Duration(days: 45)),
              description: 'Planted wheat seeds',
              cost: 5000.0,
              plotId: '1',
              details: {'variety': 'HD2967', 'quantity': '50kg'},
            ),
          ],
        ),
        Farm(
          id: '2',
          name: 'Back Field',
          ownerId: userId,
          area: 3.0,
          crops: ['Cotton'],
          sensors: [
            SensorData(
              id: 'sensor_3',
              type: SensorType.soilMoisture,
              value: 45.0,
              unit: '%',
              timestamp: DateTime.now(),
              locationName: 'Field B',
              isOnline: true,
              batteryLevel: 78.0,
            ),
          ],
          location: Location(
            latitude: 30.7400,
            longitude: 76.7800,
            address: 'Village Khanna, Punjab',
            district: 'Ludhiana',
            state: 'Punjab',
            pincode: '141401',
          ),
          soilType: 'Clay',
          irrigationType: 'Flood',
          isOrganic: true,
          createdAt: DateTime.now().subtract(const Duration(days: 200)),
          updatedAt: DateTime.now(),
          plots: [
            Plot(
              id: '3',
              name: 'Plot C',
              area: 3.0,
              currentCrop: 'Cotton',
              soilType: 'Clay',
              sensors: [],
              location: Location(
                latitude: 30.7400,
                longitude: 76.7800,
                address: 'Village Khanna, Punjab',
                district: 'Ludhiana',
                state: 'Punjab',
                pincode: '141401',
              ),
            ),
          ],
          waterSource: WaterSource.canal,
          activities: [],
        ),
      ];

      if (_farms.isNotEmpty) {
        _selectedFarm = _farms.first;
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

  void selectFarm(String farmId) {
    _selectedFarm = _farms.firstWhere((farm) => farm.id == farmId);
    notifyListeners();
  }

  Future<void> addFarm(Farm farm) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      _farms.add(farm);
      _selectedFarm = farm;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateFarm(Farm updatedFarm) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      final index = _farms.indexWhere((farm) => farm.id == updatedFarm.id);
      if (index != -1) {
        _farms[index] = updatedFarm;
        if (_selectedFarm?.id == updatedFarm.id) {
          _selectedFarm = updatedFarm;
        }
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

  Future<void> deleteFarm(String farmId) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      _farms.removeWhere((farm) => farm.id == farmId);
      if (_selectedFarm?.id == farmId) {
        _selectedFarm = _farms.isNotEmpty ? _farms.first : null;
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

  Future<void> updateSensorData(
    String farmId,
    List<SensorData> newSensorData,
  ) async {
    try {
      final farmIndex = _farms.indexWhere((farm) => farm.id == farmId);
      if (farmIndex == -1) return;

      final farm = _farms[farmIndex];
      final updatedFarm = Farm(
        id: farm.id,
        name: farm.name,
        ownerId: farm.ownerId,
        area: farm.area,
        crops: farm.crops,
        sensors: newSensorData,
        location: farm.location,
        soilType: farm.soilType,
        irrigationType: farm.irrigationType,
        isOrganic: farm.isOrganic,
        createdAt: farm.createdAt,
        updatedAt: DateTime.now(),
        plots: farm.plots,
        waterSource: farm.waterSource,
        activities: farm.activities,
      );

      _farms[farmIndex] = updatedFarm;
      if (_selectedFarm?.id == farmId) {
        _selectedFarm = updatedFarm;
      }

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  List<SensorData> getSensorsByType(String farmId, SensorType type) {
    final farm = _farms.firstWhere((farm) => farm.id == farmId);
    return farm.sensors.where((sensor) => sensor.type == type).toList();
  }

  double getAverageSensorValue(String farmId, SensorType type) {
    final sensors = getSensorsByType(farmId, type);
    if (sensors.isEmpty) return 0.0;

    final sum = sensors.fold<double>(0.0, (sum, sensor) => sum + sensor.value);
    return sum / sensors.length;
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }
}
