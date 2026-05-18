import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/alert_list_item.dart';
import '../../../shared/models/alert.dart';
import '../../../shared/providers/pipeline_providers.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Alerts'),
          actions: [
            IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
          ],
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant,
            tabs: const [
              Tab(text: 'Alerts'),
              Tab(text: 'News'),
              Tab(text: 'My Area'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAlertsList(ref),
            _buildNewsList(context),
            const Center(child: Text('My Area Map View Placeholder')),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsList(WidgetRef ref) {
    final pipeline = ref.watch(alertPipelineProvider);

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: pipeline.streamAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final alerts =
            snapshot.data?.map((item) => Alert.fromJson(item)).toList() ?? [];
        if (alerts.isEmpty) {
          return const Center(child: Text('No active alerts at the moment.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alert = alerts[index];
            return AlertListItem(alert: alert);
          },
        );
      },
    );
  }

  Widget _buildNewsList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/24',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'City Police Dept',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const Spacer(),
                    Text(
                      '2h ago',
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'New safety initiative launched downtown',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'AI summary: Police have increased patrols and installed new lighting in the downtown area.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Credibility Score',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(fontSize: 10, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: 0.95,
                            color: Colors.green,
                            backgroundColor: Colors.grey[200],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Chip(
                      label: Text('3 min read', style: TextStyle(fontSize: 10)),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
