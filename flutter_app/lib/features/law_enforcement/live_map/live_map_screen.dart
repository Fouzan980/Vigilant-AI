import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../shared/widgets/vigilant_card.dart';

class LiveMapScreen extends StatefulWidget {
  const LiveMapScreen({super.key});

  @override
  State<LiveMapScreen> createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends State<LiveMapScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.7749, -122.4194);
  bool _showPanel = true;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 14.0),
            myLocationEnabled: true,
            zoomControlsEnabled: false,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FilterChip(
                            label: const Text('All'),
                            selected: true,
                            onSelected: (b) {},
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            label: const Text('Critical Only'),
                            selected: false,
                            onSelected: (b) {},
                            selectedColor: Colors.red[100],
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            label: const Text('Near Me'),
                            selected: false,
                            onSelected: (b) {},
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            label: const Text('Unassigned'),
                            selected: false,
                            onSelected: (b) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _showPanel ? Icons.fullscreen : Icons.fullscreen_exit,
                    ),
                    onPressed: () => setState(() => _showPanel = !_showPanel),
                    style: IconButton.styleFrom(backgroundColor: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          if (_showPanel)
            Positioned(
              right: 16,
              top: 80,
              bottom: 16,
              width: 350,
              child: VigilantCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Active Incidents',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final isCritical = index < 2;
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: isCritical
                                              ? Colors.red
                                              : Colors.orange,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        isCritical
                                            ? 'Assault'
                                            : 'Suspicious Activity',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '2m ago',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    '5th Ave & Main St',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: FilledButton.tonal(
                                      onPressed: () {},
                                      child: const Text('Assign to Me'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
