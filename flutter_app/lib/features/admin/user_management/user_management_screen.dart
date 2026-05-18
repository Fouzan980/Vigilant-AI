import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/vigilant_card.dart';
import '../../../shared/providers/pipeline_providers.dart';

class UserManagementScreen extends ConsumerWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pipeline = ref.watch(userPipelineProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: pipeline.streamAll(),
              builder: (context, snapshot) {
                final users = snapshot.data ?? [];
                return Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        context,
                        'Total Users',
                        users.length.toString(),
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSummaryCard(
                        context,
                        'Active Today',
                        (users
                                .where((item) => item['status'] == 'active')
                                .length)
                            .toString(),
                        Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSummaryCard(
                        context,
                        'New This Week',
                        (users
                                .where((item) => item['createdAt'] != null)
                                .length)
                            .toString(),
                        Colors.orange,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Card(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: pipeline.streamAll(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final users = snapshot.data ?? [];
                    if (users.isEmpty) {
                      return const Center(
                        child: Text('No registered users found.'),
                      );
                    }
                    return SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('District')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: users.map((user) {
                          return DataRow(
                            cells: [
                              DataCell(Text(user['name'] ?? 'Unknown')),
                              DataCell(
                                Text(user['email'] ?? 'no-email@example.com'),
                              ),
                              DataCell(Text(user['district'] ?? 'Unknown')),
                              DataCell(
                                Chip(
                                  label: Text(
                                    (user['status'] ?? 'active').toString(),
                                  ),
                                  backgroundColor: user['status'] == 'inactive'
                                      ? Colors.grey
                                      : Colors.green,
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.person),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.block),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    Color color,
  ) {
    return VigilantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
