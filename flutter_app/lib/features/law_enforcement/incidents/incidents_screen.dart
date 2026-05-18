import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/pipeline_providers.dart';

class IncidentsScreen extends ConsumerWidget {
  const IncidentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pipeline = ref.watch(reportPipelineProvider);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Incidents'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Open'),
              Tab(text: 'Assigned to Me'),
              Tab(text: 'Resolved'),
            ],
          ),
        ),
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: pipeline.streamAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final reports = snapshot.data ?? [];
            final openReports = reports
                .where((item) => item['status'] == 'open')
                .toList();
            final assignedReports = reports
                .where((item) => item['status'] == 'assigned')
                .toList();
            final resolvedReports = reports
                .where((item) => item['status'] == 'resolved')
                .toList();
            return TabBarView(
              children: [
                _buildList(context, openReports, true),
                _buildList(context, assignedReports, false),
                _buildList(context, resolvedReports, false),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<Map<String, dynamic>> reports,
    bool isOpen,
  ) {
    if (reports.isEmpty) {
      return const Center(child: Text('No incidents found.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      report['id'] != null
                          ? '#${report['id']}'
                          : '#${index + 1}',
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: Colors.grey),
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(report['category'] ?? 'Unknown'),
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(report['severity'] ?? 'Critical'),
                      backgroundColor: Colors.red,
                      labelStyle: const TextStyle(color: Colors.white),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.map, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            report['location'] ?? 'Unknown location',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            report['description'] ?? 'No details available.',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            report['createdAt'] != null
                                ? report['createdAt'].toString()
                                : 'No timestamp',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (isOpen)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Mark in Progress'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {},
                        child: const Text('Accept'),
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Update'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.local_police),
                        label: const Text('Backup'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {},
                        child: const Text('Mark Resolved'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
