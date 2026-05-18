import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../shared/widgets/vigilant_card.dart';

class ShadowScoreScreen extends StatelessWidget {
  const ShadowScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Shadow Safety Score'),
        actions: [
          IconButton(icon: const Icon(Icons.info_outline), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Main Score Card
            VigilantCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '64',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '/100',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Chip(
                    label: Text(
                      'Needs Attention',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.amber,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Based on 1240 anonymous reports',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 70),
                              FlSpot(1, 68),
                              FlSpot(2, 65),
                              FlSpot(3, 62),
                              FlSpot(4, 60),
                              FlSpot(5, 64),
                            ],
                            isCurved: true,
                            color: Colors.amber,
                            barWidth: 2,
                            dotData: const FlDotData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Sub-scores
            _buildSubScoreCard(
              context,
              '🌙',
              'Night Safety',
              48,
              const Color(0xFFB71C1C),
            ),
            _buildSubScoreCard(
              context,
              '👩',
              'Womens Safety',
              55,
              Colors.amber,
            ),
            _buildSubScoreCard(
              context,
              '🚗',
              'Traffic Safety',
              71,
              Colors.lightGreen,
            ),
            _buildSubScoreCard(
              context,
              '🏗️',
              'Infrastructure',
              80,
              Colors.green,
            ),
            const SizedBox(height: 16),

            // Tags
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What people feel here',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    const Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(
                          label: Text(
                            'Poor lighting',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Chip(
                          label: Text(
                            'Harassment',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Chip(
                          label: Text(
                            'Speeding cars',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Chip(
                          label: Text(
                            'Deserted at night',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Chip(
                          label: Text(
                            'Unsafe crossings',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Chip(
                          label: Text(
                            'No CCTV',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Recommendation
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  left: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 4,
                  ),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'AI Recommendation',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Installation of 4 streetlights and a speed bump on 5th Ave would increase overall safety score by 12 points.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Share with City Council'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
              child: const Text('Add Your Experience'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSubScoreCard(
    BuildContext context,
    String emoji,
    String title,
    int score,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$emoji $title',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '$score/100',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: score / 100,
              backgroundColor: Colors.grey[200],
              color: color,
              minHeight: 6,
            ),
          ],
        ),
      ),
    );
  }
}
