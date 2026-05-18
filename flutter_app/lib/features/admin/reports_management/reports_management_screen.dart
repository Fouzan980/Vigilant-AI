import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/pipeline_providers.dart';

class ReportsManagementScreen extends ConsumerWidget {
  const ReportsManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pipeline = ref.watch(reportPipelineProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Report Management')),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: pipeline.streamAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final reports = snapshot.data ?? [];
          if (reports.isEmpty) {
            return const Center(
              child: Text('No reports have been submitted yet.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView.separated(
              itemCount: reports.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final report = reports[index];
                return Card(
                  child: ListTile(
                    title: Text(report['title'] ?? 'Untitled report'),
                    subtitle: Text(report['description'] ?? 'No description'),
                    trailing: Text(report['status'] ?? 'unknown'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
