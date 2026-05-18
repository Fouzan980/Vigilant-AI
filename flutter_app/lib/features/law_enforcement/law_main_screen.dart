import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'live_map/live_map_screen.dart';
import 'incidents/incidents_screen.dart';
import 'analytics/law_analytics_screen.dart';

class LawMainScreen extends StatefulWidget {
  const LawMainScreen({super.key});

  @override
  State<LawMainScreen> createState() => _LawMainScreenState();
}

class _LawMainScreenState extends State<LawMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const LiveMapScreen(),
    const IncidentsScreen(),
    const Center(child: Text('My Reports')),
    const LawAnalyticsScreen(),
    const Center(child: Text('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    // Override theme for Law Enforcement to use Blue seed
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Theme.of(context).brightness,
        ),
      ),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 900;
            if (isWide) {
              return Row(
                children: [
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (index) =>
                        setState(() => _selectedIndex = index),
                    labelType: NavigationRailLabelType.all,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.shield,
                            size: 40,
                            color: Color(0xFF1565C0),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'L.E. Portal',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    trailing: Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: IconButton(
                            icon: const Icon(Icons.logout),
                            onPressed: () => context.go('/login'),
                          ),
                        ),
                      ),
                    ),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.map_outlined),
                        selectedIcon: Icon(Icons.map),
                        label: Text('Live Map'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.list_alt_outlined),
                        selectedIcon: Icon(Icons.list_alt),
                        label: Text('Incidents'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.folder_outlined),
                        selectedIcon: Icon(Icons.folder),
                        label: Text('My Reports'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.analytics_outlined),
                        selectedIcon: Icon(Icons.analytics),
                        label: Text('Analytics'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings_outlined),
                        selectedIcon: Icon(Icons.settings),
                        label: Text('Settings'),
                      ),
                    ],
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(child: _screens[_selectedIndex]),
                ],
              );
            } else {
              return Column(
                children: [
                  AppBar(
                    title: const Text('L.E. Portal'),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () => context.go('/login'),
                      ),
                    ],
                  ),
                  Expanded(child: _screens[_selectedIndex]),
                  NavigationBar(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (index) =>
                        setState(() => _selectedIndex = index),
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.map_outlined),
                        selectedIcon: Icon(Icons.map),
                        label: 'Map',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.list_alt_outlined),
                        selectedIcon: Icon(Icons.list_alt),
                        label: 'Incidents',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.folder_outlined),
                        selectedIcon: Icon(Icons.folder),
                        label: 'Reports',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.analytics_outlined),
                        selectedIcon: Icon(Icons.analytics),
                        label: 'Analytics',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.settings_outlined),
                        selectedIcon: Icon(Icons.settings),
                        label: 'Settings',
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
