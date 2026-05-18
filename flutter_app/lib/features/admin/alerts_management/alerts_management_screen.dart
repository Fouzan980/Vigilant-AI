import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/pipeline_providers.dart';

class AlertsManagementScreen extends ConsumerWidget {
  const AlertsManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pipeline = ref.watch(alertPipelineProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Active Alerts')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Active Alerts',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Create New Alert'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: pipeline.streamAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final alerts = snapshot.data ?? [];
                  if (alerts.isEmpty) {
                    return const Center(
                      child: Text('No active alerts at the moment.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: alerts.length,
                    itemBuilder: (context, index) {
                      final alert = alerts[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Chip(
                                    label: Text(
                                      alert['severity']?.toString() ??
                                          'Unknown',
                                    ),
                                    backgroundColor: Colors.red,
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      alert['title'] ?? 'Alert',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    alert['createdAt'] != null
                                        ? alert['createdAt']
                                              .toString()
                                              .substring(0, 16)
                                        : 'Unknown',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                alert['subtitle'] ??
                                    alert['description'] ??
                                    'No details available.',
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                    label: const Text('Edit'),
                                  ),
                                  const SizedBox(width: 8),
                                  OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.campaign),
                                    label: const Text('Broadcast to Citizens'),
                                  ),
                                  const SizedBox(width: 8),
                                  OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.archive),
                                    label: const Text('Archive'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
