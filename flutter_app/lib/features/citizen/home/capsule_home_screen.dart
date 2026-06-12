import 'dart:ui';
import 'package:flutter/material.dart';

/// A complete, standalone file demonstrating the Glassmorphic Capsule/Pill-morphism UI
/// for "Vigilant AI" with Cyberpunk Dark Mode + Material You aspects.
class CapsuleHomeScreen extends StatelessWidget {
  const CapsuleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cyberpunk Dark Background
    return Scaffold(
      backgroundColor: const Color(0xFF09090B), // Very deep dark background
      body: Stack(
        children: [
          // Background ambient gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(-0.5, -0.5),
                  radius: 1.5,
                  colors: [
                    Color(0xFF1E1B4B), // Deep purple tint
                    Color(0xFF09090B),
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                const FloatingMapDock(),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      LiveVerificationPill(
                        location: 'Downtown District, Sector 7',
                        time: '10:42 AM',
                        statusText: 'VERIFIED',
                        statusColor: Color(0xFF10B981), // Emerald Green
                        isPulsing: false,
                      ),
                      SizedBox(height: 16),
                      LiveVerificationPill(
                        location: 'Industrial Zone, Block 4',
                        time: 'Just now',
                        statusText: 'ALERT ACTIVE',
                        statusColor: Color(0xFFE11D48), // Crimson
                        isPulsing: true,
                      ),
                      SizedBox(height: 16),
                      LiveVerificationPill(
                        location: 'Transit Station Beta',
                        time: '12 mins ago',
                        statusText: 'PENDING',
                        statusColor: Color(0xFFF59E0B), // Amber
                        isPulsing: true,
                      ),
                      SizedBox(height: 100), // Space for bottom button
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Action Button
          const Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: EmergencyActionButton(),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CORE INTERACTION: Haptic Tap Button Wrapper
// -----------------------------------------------------------------------------
class HapticCapsule extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const HapticCapsule({super.key, required this.child, required this.onTap});

  @override
  State<HapticCapsule> createState() => _HapticCapsuleState();
}

class _HapticCapsuleState extends State<HapticCapsule>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 300),
    );
    // Scales down to 0.95 when pressed, snaps back with easeOutBack
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CORE INTERACTION: Pulsing Indicator
// -----------------------------------------------------------------------------
class PulsingIndicator extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const PulsingIndicator({
    super.key,
    required this.child,
    this.enabled = true,
  });

  @override
  State<PulsingIndicator> createState() => _PulsingIndicatorState();
}

class _PulsingIndicatorState extends State<PulsingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    // Linear swing from 0.4 to 1.0 and back
    _opacityAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.enabled) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(PulsingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !oldWidget.enabled) {
      _controller.repeat(reverse: true);
    } else if (!widget.enabled && oldWidget.enabled) {
      _controller.stop();
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;
    return FadeTransition(
      opacity: _opacityAnimation,
      child: widget.child,
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT A: Floating Map Dock
// -----------------------------------------------------------------------------
class FloatingMapDock extends StatelessWidget {
  const FloatingMapDock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            // Left: Search Capsule
            Expanded(
              flex: 3,
              child: GlassCapsule(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.white.withOpacity(0.7)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Search area...',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Right: Scrolling Filters
            Expanded(
              flex: 4,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  const _FilterChip(label: 'All', isActive: true),
                  const _FilterChip(label: 'Alerts', isActive: false),
                  const _FilterChip(label: 'Safe', isActive: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const _FilterChip({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: HapticCapsule(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: isActive
                ? const Color(0xFF6366F1).withOpacity(0.2) // Deep Amethyst
                : Colors.white.withOpacity(0.05),
            border: Border.all(
              color: isActive
                  ? const Color(0xFF6366F1).withOpacity(0.5)
                  : Colors.white.withOpacity(0.15),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF8B5CF6) : Colors.white70,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT B: Live Verification Status Pill (Expandable)
// -----------------------------------------------------------------------------
class LiveVerificationPill extends StatefulWidget {
  final String location;
  final String time;
  final String statusText;
  final Color statusColor;
  final bool isPulsing;

  const LiveVerificationPill({
    super.key,
    required this.location,
    required this.time,
    required this.statusText,
    required this.statusColor,
    required this.isPulsing,
  });

  @override
  State<LiveVerificationPill> createState() => _LiveVerificationPillState();
}

class _LiveVerificationPillState extends State<LiveVerificationPill> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return HapticCapsule(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: GlassCapsule(
        padding: const EdgeInsets.all(16),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 350),
          curve: Curves.fastOutSlowIn,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Status Capsule inside
                  PulsingIndicator(
                    enabled: widget.isPulsing,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: widget.statusColor.withOpacity(0.15),
                        border: Border.all(
                            color: widget.statusColor.withOpacity(0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: widget.statusColor.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        widget.statusText,
                        style: TextStyle(
                          color: widget.statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.time,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.location,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              if (_isExpanded) ...[
                const SizedBox(height: 16),
                Divider(color: Colors.white.withOpacity(0.1)),
                const SizedBox(height: 12),
                Text(
                  'Detailed report data is currently being synthesized by the network. Additional verification nodes are actively scanning the sector for corroborating evidence.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    height: 1.5,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.shield_outlined,
                        color: widget.statusColor, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'AI Confidence: 94%',
                      style: TextStyle(
                        color: widget.statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// COMPONENT C: Tactile Emergency/Report Action Button
// -----------------------------------------------------------------------------
class EmergencyActionButton extends StatelessWidget {
  const EmergencyActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return HapticCapsule(
      onTap: () {
        // Trigger report logic
      },
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            // Ambient outer glow
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            // Neon inner glow (achieved via negative spread / stacking)
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            // Inner glow simulation using a second border
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 2,
                ),
              ),
            ),
            const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    'INITIATE REPORT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0, // High tracking
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
}

// -----------------------------------------------------------------------------
// UTILITY: Base Glassmorphism Capsule
// -----------------------------------------------------------------------------
class GlassCapsule extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const GlassCapsule({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      // Actually we need the content to be able to expand, so maybe a smaller 
      // border radius when expanded, but prompt asks for StadiumBorder/999.
      // So large border radius is fine.
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: Colors.white.withOpacity(0.2), // Low opacity white border
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
