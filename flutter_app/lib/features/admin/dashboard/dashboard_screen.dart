import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../shared/widgets/vigilant_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 1;
              if (constraints.maxWidth > 600) crossAxisCount = 2;
              if (constraints.maxWidth > 1200) crossAxisCount = 4;

              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2.5,
                children: [
                  _buildMetricCard(
                    context,
                    'Total Reports Today',
                    '142',
                    '+12%',
                    true,
                  ),
                  _buildMetricCard(context, 'Active Alerts', '3', '-1', false),
                  _buildMetricCard(
                    context,
                    'Resolved Cases',
                    '89',
                    '+5%',
                    true,
                  ),
                  _buildMetricCard(
                    context,
                    'Registered Users',
                    '12,450',
                    '+24',
                    true,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;
              final children = [
                Expanded(flex: isWide ? 1 : 0, child: _buildLiveFeed(context)),
                if (isWide)
                  const SizedBox(width: 24)
                else
                  const SizedBox(height: 24),
                Expanded(flex: isWide ? 2 : 0, child: _buildBarChart(context)),
              ];

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                );
              }
            },
          ),
          const SizedBox(height: 24),
          _buildHeatmapOverview(context),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    String value,
    String trend,
    bool isPositive,
  ) {
    return VigilantCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? Colors.green : Colors.red,
                size: 16,
              ),
              Text(
                trend,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isPositive ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveFeed(BuildContext context) {
    return VigilantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Live Feed', style: Theme.of(context).textTheme.titleMedium),
              IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
            ],
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.red, radius: 6),
                  title: Text('Theft reported'),
                  subtitle: Text('Downtown - 2 mins ago'),
                  dense: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(BuildContext context) {
    return VigilantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reports by Category (7 Days)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 10,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(toY: 15, color: Colors.amber)],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(toY: 8, color: Colors.teal)],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(toY: 5, color: Colors.blue)],
                  ),
                ],
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeatmapOverview(BuildContext context) {
    return VigilantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Safety Score Heatmap',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Container(
            height: 400,
            color: Colors.grey[200],
            child: const Center(child: Text('Map View Placeholder')),
          ),
        ],
      ),
    );
  }
}
