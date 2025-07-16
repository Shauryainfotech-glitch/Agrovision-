import 'package:flutter/material.dart';
import '../models/farm_model.dart';

class SensorDataWidget extends StatelessWidget {
  final List<SensorData> sensors;

  const SensorDataWidget({
    super.key,
    required this.sensors,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sensor Readings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sensors.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final sensor = sensors[index];
                return _buildSensorReading(sensor);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorReading(SensorData sensor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getSensorTypeLabel(sensor.type),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              sensor.locationName,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '${sensor.value}${sensor.unit}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            _buildStatusIndicator(sensor.isOnline),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(bool isOnline) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isOnline ? Colors.green : Colors.red,
        shape: BoxShape.circle,
      ),
    );
  }

  String _getSensorTypeLabel(SensorType type) {
    switch (type) {
      case SensorType.soilMoisture:
        return 'Soil Moisture';
      case SensorType.temperature:
        return 'Temperature';
      case SensorType.humidity:
        return 'Humidity';
      case SensorType.ph:
        return 'pH Level';
      case SensorType.nitrogen:
        return 'Nitrogen';
      case SensorType.phosphorus:
        return 'Phosphorus';
      case SensorType.potassium:
        return 'Potassium';
      case SensorType.lightIntensity:
        return 'Light Intensity';
      default:
        return 'Unknown Sensor';
    }
  }
}
