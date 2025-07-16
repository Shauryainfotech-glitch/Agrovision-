class Farm {
  final String id;
  final String name;
  final String ownerId;
  final double area;
  final List<String> crops;
  final List<SensorData> sensors;
  final Location location;
  final String soilType;
  final String irrigationType;
  final bool isOrganic;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Plot> plots;
  final WaterSource waterSource;
  final List<Activity> activities;

  Farm({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.area,
    required this.crops,
    required this.sensors,
    required this.location,
    required this.soilType,
    required this.irrigationType,
    required this.isOrganic,
    required this.createdAt,
    required this.updatedAt,
    required this.plots,
    required this.waterSource,
    required this.activities,
  });
}

class Plot {
  final String id;
  final String name;
  final double area;
  final String currentCrop;
  final String soilType;
  final List<SensorData> sensors;
  final Location location;

  Plot({
    required this.id,
    required this.name,
    required this.area,
    required this.currentCrop,
    required this.soilType,
    required this.sensors,
    required this.location,
  });
}

class Activity {
  final String id;
  final String type;
  final DateTime date;
  final String description;
  final double cost;
  final String plotId;
  final Map<String, dynamic> details;

  Activity({
    required this.id,
    required this.type,
    required this.date,
    required this.description,
    required this.cost,
    required this.plotId,
    required this.details,
  });
}

enum WaterSource { canal, tubewell, pond, rainwater, river, other }

enum IrrigationType { flood, drip, sprinkler, subsurface, manual, other }

class SensorData {
  final String id;
  final SensorType type;
  final double value;
  final String unit;
  final DateTime timestamp;
  final String locationName;
  final bool isOnline;
  final double batteryLevel;

  SensorData({
    required this.id,
    required this.type,
    required this.value,
    required this.unit,
    required this.timestamp,
    required this.locationName,
    required this.isOnline,
    required this.batteryLevel,
  });
}

class Location {
  final double latitude;
  final double longitude;
  final String address;
  final String district;
  final String state;
  final String pincode;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.district,
    required this.state,
    required this.pincode,
  });
}

enum SensorType {
  soilMoisture,
  temperature,
  humidity,
  ph,
  nitrogen,
  phosphorus,
  potassium,
  lightIntensity,
}
