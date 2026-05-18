import 'package:flutter/material.dart';
import '../models/alert.dart';
import '../models/enums.dart';

class AlertListItem extends StatelessWidget {
  final Alert alert;

  const AlertListItem({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    Color severityColor;
    IconData iconData;

    switch (alert.severity) {
      case Severity.critical:
        severityColor = const Color(0xFFB71C1C);
        iconData = Icons.warning_amber_rounded;
        break;
      case Severity.medium:
        severityColor = const Color(0xFFFF6F00);
        iconData = Icons.error_outline;
        break;
      case Severity.low:
        severityColor = const Color(0xFF00838F); // teal
        iconData = Icons.info_outline;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: severityColor),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Icon(iconData, color: severityColor, size: 28),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      alert.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${alert.timestamp.toLocal().toString().split(' ')[0]} ${alert.timestamp.toLocal().toString().split(' ')[1].substring(0, 5)}',
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
