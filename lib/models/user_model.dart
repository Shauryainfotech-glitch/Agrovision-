class User {
  final String id;
  final String name;
  final String phone;
  final String language;
  final String state;
  final List<String> farmIds;
  final UserType userType;
  final AgeGroup ageGroup;
  final EducationLevel educationLevel;
  final DateTime createdAt;
  final bool isPremium;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.language,
    required this.state,
    required this.farmIds,
    required this.userType,
    required this.ageGroup,
    required this.educationLevel,
    required this.createdAt,
    this.isPremium = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      language: json['language'],
      state: json['state'],
      farmIds: List<String>.from(json['farmIds']),
      userType: UserType.values.firstWhere(
        (e) => e.toString() == 'UserType.${json['userType']}',
      ),
      ageGroup: AgeGroup.values.firstWhere(
        (e) => e.toString() == 'AgeGroup.${json['ageGroup']}',
      ),
      educationLevel: EducationLevel.values.firstWhere(
        (e) => e.toString() == 'EducationLevel.${json['educationLevel']}',
      ),
      createdAt: DateTime.parse(json['createdAt']),
      isPremium: json['isPremium'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'language': language,
      'state': state,
      'farmIds': farmIds,
      'userType': userType.toString().split('.').last,
      'ageGroup': ageGroup.toString().split('.').last,
      'educationLevel': educationLevel.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'isPremium': isPremium,
    };
  }
}

enum UserType {
  smallFarmer, // 1-5 acres
  mediumFarmer, // 5-20 acres
  largeFarmer, // 20+ acres
  agronomist, // Agricultural expert
  govtOfficer, // Government agricultural officer
}

enum AgeGroup {
  young, // 18-30 years
  middle, // 31-45 years
  senior, // 46-60 years
  elder, // 60+ years
}

enum EducationLevel { primary, middle, highSchool, graduate, postGraduate }
