import 'package:flutter/material.dart';

class PulseAura extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double borderRadius;

  const PulseAura({
    super.key,
    required this.child,
    required this.glowColor,
    this.borderRadius = 999.0, // Default to capsule
  });

  @override
  State<PulseAura> createState() => _PulseAuraState();
}

class _PulseAuraState extends State<PulseAura> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 0.1, end: 0.4).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
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
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              // Inner tight glow
              BoxShadow(
                color: widget.glowColor.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 2,
              ),
              // Outer pulsing aura
              BoxShadow(
                color: widget.glowColor.withOpacity(_opacityAnimation.value),
                blurRadius: 24,
                spreadRadius: 8,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
