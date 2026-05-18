import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/vigilant_card.dart';
import '../../../shared/widgets/safety_score_gauge.dart';
import '../../../shared/widgets/alert_list_item.dart';
import '../../../shared/models/alert.dart';
import '../../../shared/models/enums.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text(
              'Vigilant AI',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Badge(
                  label: Text('2'),
                  child: Icon(Icons.notifications_none),
                ),
                onPressed:
                    () {}, // Handled by bottom nav usually, but could go to alerts directly
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  _buildGreetingCard(context),
                  const SizedBox(height: 16),
                  _buildSafetyScoreCard(context),
                  const SizedBox(height: 16),
                  _buildQuickActions(context),
                  const SizedBox(height: 16),
                  _buildRecentAlerts(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Text('TU', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning,',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Test User',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Downtown',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyScoreCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/citizen/score'),
      child: VigilantCard(
        child: Column(
          children: [
            const SafetyScoreGauge(score: 72),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatChip(
                  context,
                  '12 Reports',
                  Theme.of(context).colorScheme.primary,
                ),
                _buildStatChip(
                  context,
                  '2 Alerts',
                  Theme.of(context).colorScheme.error,
                ),
                _buildStatChip(context, '68% Safe', const Color(0xFF2E7D32)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(BuildContext context, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        _buildQuickActionItem(
          context,
          'SOS',
          Icons.warning_rounded,
          Theme.of(context).colorScheme.error,
          () => context.push('/citizen/sos'),
        ),
        const SizedBox(width: 8),
        _buildQuickActionItem(
          context,
          'Report',
          Icons.edit_note_rounded,
          Theme.of(context).colorScheme.primary,
          () {},
        ),
        const SizedBox(width: 8),
        _buildQuickActionItem(
          context,
          'Alerts',
          Icons.notifications_active_rounded,
          const Color(0xFFFF6F00),
          () {},
        ),
        const SizedBox(width: 8),
        _buildQuickActionItem(
          context,
          'Map',
          Icons.map_rounded,
          const Color(0xFF00838F),
          () {},
        ),
      ],
    );
  }

  Widget _buildQuickActionItem(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 28, color: color),
                const SizedBox(height: 4),
                Text(label, style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentAlerts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Alerts',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(onPressed: () {}, child: const Text('See All')),
          ],
        ),
        AlertListItem(
          alert: Alert()
            ..title = 'Suspicious Activity reported'
            ..severity = Severity.medium
            ..timestamp = DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        AlertListItem(
          alert: Alert()
            ..title = 'Road Closure on 5th Ave'
            ..severity = Severity.low
            ..timestamp = DateTime.now().subtract(const Duration(hours: 1)),
        ),
        AlertListItem(
          alert: Alert()
            ..title = 'Severe Weather Warning'
            ..severity = Severity.critical
            ..timestamp = DateTime.now().subtract(const Duration(hours: 2)),
        ),
      ],
    );
  }
}
