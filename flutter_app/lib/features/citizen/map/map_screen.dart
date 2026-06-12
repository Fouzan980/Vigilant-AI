import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../shared/widgets/heatmap_legend.dart';
import '../../../shared/widgets/glass_capsule.dart';
import '../../../shared/widgets/squish_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.7749, -122.4194); // SF Placeholder

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // Apply dark map style JSON here if available
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 13.0),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),

          // Top Search Bar & Filters
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const GlassCapsule(
                    child: SearchBar(
                      leading: Icon(Icons.search),
                      hintText: 'Search area or address',
                      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                      elevation: WidgetStatePropertyAll(0),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterChip(
                          label: const Text('All Crimes'),
                          selected: true,
                          onSelected: (b) {},
                        ),
                        const SizedBox(width: 8),
                        FilterChip(
                          label: const Text('Theft'),
                          selected: false,
                          onSelected: (b) {},
                        ),
                        const SizedBox(width: 8),
                        FilterChip(
                          label: const Text('Violence'),
                          selected: false,
                          onSelected: (b) {},
                        ),
                        const SizedBox(width: 8),
                        FilterChip(
                          label: const Text('Infrastructure'),
                          selected: false,
                          onSelected: (b) {},
                        ),
                        const SizedBox(width: 8),
                        FilterChip(
                          label: const Text('Weather'),
                          selected: false,
                          onSelected: (b) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Legend
          const Positioned(
            bottom: 120, // above bottom sheet
            left: 16,
            child: HeatmapLegend(),
          ),

          // FAB
          Positioned(
            bottom: 120,
            right: 16,
            child: SquishButton(
              onTap: () {},
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),

          // Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.15,
            maxChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              return GlassCapsule(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '12 Incidents Nearby',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Placeholder incident rows
                    _buildIncidentRow(
                      context,
                      Colors.red,
                      'Assault reported',
                      '5th Ave & Main St',
                      '0.2 mi',
                    ),
                    _buildIncidentRow(
                      context,
                      Colors.orange,
                      'Suspicious person',
                      'Oak St',
                      '0.5 mi',
                    ),
                    _buildIncidentRow(
                      context,
                      Colors.yellow,
                      'Broken street light',
                      'Pine Ave',
                      '0.8 mi',
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentRow(
    BuildContext context,
    Color color,
    String title,
    String location,
    String distance,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  location,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            distance,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
