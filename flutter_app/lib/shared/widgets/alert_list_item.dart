import 'package:flutter/material.dart';
import '../models/alert.dart';
import '../models/enums.dart';
import 'glass_capsule.dart';
import 'squish_button.dart';
import 'pulse_aura.dart';

class AlertListItem extends StatelessWidget {
  final Alert alert;

  const AlertListItem({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    Color severityColor;
    IconData iconData;
    bool isCritical = false;

    switch (alert.severity) {
      case Severity.critical:
        severityColor = const Color(0xFFDC2626); // Crimson
        iconData = Icons.warning_amber_rounded;
        isCritical = true;
        break;
      case Severity.medium:
        severityColor = const Color(0xFFF59E0B); // Amber
        iconData = Icons.error_outline;
        break;
      case Severity.low:
        severityColor = const Color(0xFF10B981); // Emerald
        iconData = Icons.info_outline;
        break;
    }

    Widget content = SquishButton(
      onTap: () {
        // Expand or Navigate
      },
      child: GlassCapsule(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: severityColor.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(color: severityColor.withOpacity(0.5)),
              ),
              child: Icon(iconData, color: severityColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alert.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${alert.timestamp.toLocal().toString().split(' ')[0]} ${alert.timestamp.toLocal().toString().split(' ')[1].substring(0, 5)}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );

    if (isCritical) {
      return PulseAura(
        glowColor: severityColor,
        child: content,
      );
    }

    return content;
  }
}
