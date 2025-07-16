import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String? _token;
  bool _isLoading = false;
  String _error = '';

  User? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isAuthenticated => _token != null;

  Future<void> login(String phone, String password) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      // TODO: Implement API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Simulate successful login
      _token = 'dummy_token';
      _user = User(
        id: '1',
        name: 'Test Farmer',
        phone: phone,
        language: 'hi',
        state: 'Punjab',
        farmIds: ['1', '2'],
        userType: UserType.smallFarmer,
        ageGroup: AgeGroup.middle,
        educationLevel: EducationLevel.highSchool,
        createdAt: DateTime.now(),
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

  Future<void> register({
    required String name,
    required String phone,
    required String password,
    required String language,
    required String state,
    required UserType userType,
    required AgeGroup ageGroup,
    required EducationLevel educationLevel,
  }) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      // TODO: Implement API call
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Simulate successful registration
      _token = 'dummy_token';
      _user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        phone: phone,
        language: language,
        state: state,
        farmIds: [],
        userType: userType,
        ageGroup: ageGroup,
        educationLevel: educationLevel,
        createdAt: DateTime.now(),
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

  Future<void> logout() async {
    _user = null;
    _token = null;
    notifyListeners();
  }

  Future<void> updateProfile({
    String? name,
    String? language,
    String? state,
    UserType? userType,
    AgeGroup? ageGroup,
    EducationLevel? educationLevel,
  }) async {
    try {
      if (_user == null) return;

      _isLoading = true;
      notifyListeners();

      // TODO: Implement API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // Update user data
      _user = User(
        id: _user!.id,
        name: name ?? _user!.name,
        phone: _user!.phone,
        language: language ?? _user!.language,
        state: state ?? _user!.state,
        farmIds: _user!.farmIds,
        userType: userType ?? _user!.userType,
        ageGroup: ageGroup ?? _user!.ageGroup,
        educationLevel: educationLevel ?? _user!.educationLevel,
        createdAt: _user!.createdAt,
        isPremium: _user!.isPremium,
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

  Future<void> addFarm(String farmId) async {
    if (_user == null) return;

    final updatedFarmIds = List<String>.from(_user!.farmIds)..add(farmId);
    _user = User(
      id: _user!.id,
      name: _user!.name,
      phone: _user!.phone,
      language: _user!.language,
      state: _user!.state,
      farmIds: updatedFarmIds,
      userType: _user!.userType,
      ageGroup: _user!.ageGroup,
      educationLevel: _user!.educationLevel,
      createdAt: _user!.createdAt,
      isPremium: _user!.isPremium,
    );
    notifyListeners();
  }

  Future<void> removeFarm(String farmId) async {
    if (_user == null) return;

    final updatedFarmIds = List<String>.from(_user!.farmIds)..remove(farmId);
    _user = User(
      id: _user!.id,
      name: _user!.name,
      phone: _user!.phone,
      language: _user!.language,
      state: _user!.state,
      farmIds: updatedFarmIds,
      userType: _user!.userType,
      ageGroup: _user!.ageGroup,
      educationLevel: _user!.educationLevel,
      createdAt: _user!.createdAt,
      isPremium: _user!.isPremium,
    );
    notifyListeners();
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }
}
