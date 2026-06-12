import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCapsule extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;

  const GlassCapsule({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final defaultRadius = BorderRadius.circular(999);
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? const Color(0x0CFFFFFF), // Default Frosted Surface
        borderRadius: borderRadius ?? defaultRadius,
        border: Border.all(color: const Color(0x26FFFFFF), width: 1.5), // 15% opacity, 1.5px stroke
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? defaultRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
