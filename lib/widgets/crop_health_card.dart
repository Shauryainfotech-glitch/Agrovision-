import 'package:flutter/material.dart';
import '../models/farm_model.dart';

class CropHealthCard extends StatelessWidget {
  final Farm farm;

  const CropHealthCard({super.key, required this.farm});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        farm.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${farm.area} acres',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildHealthIndicator(),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: farm.crops
                  .map(
                    (crop) => Chip(
                      label: Text(crop),
                      backgroundColor: Colors.green.withOpacity(0.1),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem('Soil Type', farm.soilType),
                _buildInfoItem('Irrigation', farm.irrigationType),
                _buildInfoItem('Organic', farm.isOrganic ? 'Yes' : 'No'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthIndicator() {
    return Container(
      width: 12,
      height: 12,
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
