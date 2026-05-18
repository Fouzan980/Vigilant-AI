import 'package:flutter/material.dart';

class HeatmapLegend extends StatelessWidget {
  const HeatmapLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLegendRow(const Color(0xFFB71C1C), 'High (1.0)'),
            const SizedBox(height: 4),
            _buildLegendRow(const Color(0xFFE65100), 'Moderate (0.7)'),
            const SizedBox(height: 4),
            _buildLegendRow(const Color(0xFFF9A825), 'Low (0.4)'),
            const SizedBox(height: 4),
            _buildLegendRow(const Color(0xFF5D4037), 'Historical (0.1)'),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendRow(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
