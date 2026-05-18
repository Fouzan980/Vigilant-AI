import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home/home_screen.dart';
import 'map/map_screen.dart';
import 'report/report_screen.dart';
import 'alerts/alerts_screen.dart';

class CitizenMainScreen extends ConsumerStatefulWidget {
  const CitizenMainScreen({super.key});

  @override
  ConsumerState<CitizenMainScreen> createState() => _CitizenMainScreenState();
}

class _CitizenMainScreenState extends ConsumerState<CitizenMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MapScreen(),
    const ReportScreen(),
    const AlertsScreen(),
    const Center(child: Text('Profile')), // Profile Screen Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Map',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Report',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.notifications_none),
            ),
            selectedIcon: Badge(
              label: Text('2'),
              child: Icon(Icons.notifications),
            ),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
