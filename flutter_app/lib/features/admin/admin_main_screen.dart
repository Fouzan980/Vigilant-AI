import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dashboard/dashboard_screen.dart';
import 'reports_management/reports_management_screen.dart';
import 'alerts_management/alerts_management_screen.dart';
import 'user_management/user_management_screen.dart';
import 'analytics/analytics_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ReportsManagementScreen(),
    const AlertsManagementScreen(),
    const UserManagementScreen(),
    const AnalyticsScreen(),
    const Center(child: Text('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          // Desktop Layout
          return Scaffold(
            body: Row(
              children: [
                NavigationDrawer(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        'Admin Dashboard',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const NavigationDrawerDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      selectedIcon: Icon(Icons.dashboard),
                      label: Text('Overview'),
                    ),
                    const NavigationDrawerDestination(
                      icon: Icon(Icons.table_chart_outlined),
                      selectedIcon: Icon(Icons.table_chart),
                      label: Text('Reports'),
                    ),
                    const NavigationDrawerDestination(
                      icon: Icon(Icons.notifications_outlined),
                      selectedIcon: Icon(Icons.notifications),
                      label: Text('Alerts'),
                    ),
                    const NavigationDrawerDestination(
                      icon: Icon(Icons.people_outlined),
                      selectedIcon: Icon(Icons.people),
                      label: Text('Users'),
                    ),
                    const NavigationDrawerDestination(
                      icon: Icon(Icons.analytics_outlined),
                      selectedIcon: Icon(Icons.analytics),
                      label: Text('Analytics'),
                    ),
                    const NavigationDrawerDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextButton.icon(
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                        onPressed: () => context.go('/login'),
                      ),
                    ),
                  ],
                ),
                Expanded(child: _screens[_selectedIndex]),
              ],
            ),
          );
        } else {
          // Mobile Layout
          return Scaffold(
            appBar: AppBar(
              title: const Text('Admin Dashboard'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => context.go('/login'),
                ),
              ],
            ),
            body: _screens[_selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  label: 'Overview',
                ),
                NavigationDestination(
                  icon: Icon(Icons.table_chart_outlined),
                  label: 'Reports',
                ),
                NavigationDestination(
                  icon: Icon(Icons.notifications_outlined),
                  label: 'Alerts',
                ),
                NavigationDestination(
                  icon: Icon(Icons.people_outlined),
                  label: 'Users',
                ),
                NavigationDestination(
                  icon: Icon(Icons.analytics_outlined),
                  label: 'Analytics',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  label: 'Settings',
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
