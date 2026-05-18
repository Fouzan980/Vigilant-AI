import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../shared/widgets/vigilant_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Analytics Dashboard',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildLineChart(context)),
                const SizedBox(width: 24),
                Expanded(child: _buildPieChart(context)),
              ],
            ),
            const SizedBox(height: 24),
            _buildBarChart(context),
            const SizedBox(height: 24),
            // Placeholder for Heatmap Calendar
            VigilantCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Incident Frequency by Day',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Text('Heat Calendar Placeholder'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart(BuildContext context) {
    return VigilantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Reports (30 Days)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: const FlTitlesData(show: true),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 10),
                      FlSpot(1, 15),
                      FlSpot(2, 25),
                      FlSpot(3, 18),
                      FlSpot(4, 30),
                    ],
                    isCurved: true,
                    color: Theme.of(context).colorScheme.primary,
                    barWidth: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(BuildContext context) {
    return VigilantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Report Distribution by Category',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 40,
                    color: Theme.of(context).colorScheme.primary,
                    title: 'Crimes',
                    radius: 100,
                  ),
                  PieChartSectionData(
                    value: 30,
                    color: Colors.amber,
                    title: 'Infrastructure',
                    radius: 100,
                  ),
                  PieChartSectionData(
                    value: 15,
                    color: Colors.teal,
                    title: 'Weather',
                    radius: 100,
                  ),
                  PieChartSectionData(
                    value: 15,
                    color: Colors.blue,
                    title: 'Safety',
                    radius: 100,
                  ),
                ],
              ),
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
            'Resolution Time Averages by District (Hours)',
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
                        toY: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 24,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 8,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
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
}
