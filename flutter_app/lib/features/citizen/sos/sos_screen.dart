import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Text(
              'Emergency SOS',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Help is on the way',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const Spacer(),

            // SOS Button Stack
            Stack(
              alignment: Alignment.center,
              children: [
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFEBEE),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                GestureDetector(
                  onLongPressStart: (_) {},
                  onLongPressEnd: (_) {},
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF5252),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Color(0xFFFF5252), blurRadius: 24),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'SOS',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Hold 3 seconds to activate',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const Spacer(),

            // Status Cards Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 3,
                children: [
                  _buildStatusCard(
                    'Location Sharing',
                    Icons.location_on,
                    Colors.green,
                  ),
                  _buildStatusCard(
                    '3 Contacts Notified',
                    Icons.people,
                    Colors.green,
                  ),
                  _buildStatusCard(
                    'Police Alerted',
                    Icons.local_police,
                    Colors.green,
                  ),
                  _buildStatusCard('Audio Monitoring', Icons.mic, Colors.amber),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Trusted Contacts
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildContactAvatar('Wife'),
                const SizedBox(width: 16),
                _buildContactAvatar('Mom'),
                const SizedBox(width: 16),
                _buildContactAvatar('Dad'),
              ],
            ),
            const Spacer(),

            // Cancel Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  side: const BorderSide(color: Color(0xFFFF5252)),
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'I am Safe - Cancel',
                  style: TextStyle(color: Color(0xFFFF5252)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Works offline via SMS fallback',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String label, IconData icon, Color color) {
    return Card(
      color: color.withAlpha(25),
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactAvatar(String name) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, color: Colors.grey),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
