import 'package:flutter/material.dart';

class SafetyScoreGauge extends StatelessWidget {
  final int score;

  const SafetyScoreGauge({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          score.toString(),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Neighborhood Safety Score',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: score / 100,
            color: const Color(0xFF2E7D32),
            backgroundColor: Colors.grey[300],
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
