import 'package:flutter/material.dart';
import '../models/enums.dart';

class SeverityBadge extends StatelessWidget {
  final Severity severity;

  const SeverityBadge({super.key, required this.severity});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor = Colors.white;
    String label;

    switch (severity) {
      case Severity.critical:
        backgroundColor = const Color(0xFFB71C1C);
        label = 'Critical';
        break;
      case Severity.medium:
        backgroundColor = const Color(0xFFFF6F00);
        label = 'Warning';
        break;
      case Severity.low:
        backgroundColor = const Color(0xFF1565C0);
        label = 'Info';
        break;
    }

    return Chip(
      backgroundColor: backgroundColor,
      label: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: textColor),
      ),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }
}
