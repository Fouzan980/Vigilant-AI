import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // The 60-30-10 Color Rule
  static const Color obsidianBase = Color(0xFF0B0B0F); // 60% Dominant
  static const Color accentPurple = Color(0xFF8A2BE2); // 10% Accent
  static const Color safeEmerald = Color(0xFF10B981); // Emerald for safety
  static const Color dangerCrimson = Color(0xFFDC2626); // Crimson for danger
  
  // 30% Secondary structure is handled via translucent white/slate mixes
  // Example: Colors.white.withOpacity(0.05) combined with BackdropFilter
  static const Color frostedSurface = Color(0x0CFFFFFF); 
  static const Color slateGrey = Color(0xFF1E1E24);
  
  // Keep legacy constants but updated to new palette to avoid breaking references
  static const Color primaryColor = obsidianBase;
  static const Color accentColor = accentPurple;
  static const Color errorColor = dangerCrimson;
  static const Color lightBackground = obsidianBase; // Enforcing Dark Mode Concept
  static const Color darkBackground = obsidianBase;
  static const Color surfaceLight = slateGrey;
  static const Color surfaceDark = slateGrey;

  static final TextTheme _textTheme = GoogleFonts.outfitTextTheme(
    const TextTheme(
      displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: -1.0, color: Colors.white),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -0.5, color: Colors.white),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.5, color: Colors.white),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white70),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white70),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5, color: Colors.white),
      labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5, color: Colors.white54),
    ),
  );

  static ThemeData darkTheme() {
    return _buildPremiumTheme();
  }

  // Force lightTheme to also be dark to maintain the "Dark mode concept layout" as requested
  static ThemeData lightTheme() {
    return _buildPremiumTheme();
  }

  static ThemeData _buildPremiumTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: obsidianBase,
      colorScheme: const ColorScheme.dark(
        primary: accentPurple,
        secondary: frostedSurface,
        surface: slateGrey,
        error: dangerCrimson,
        onSurface: Colors.white,
      ),
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: _textTheme.titleLarge,
      ),
      cardTheme: const CardThemeData(
        color: frostedSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: StadiumBorder(
          side: BorderSide(color: Color(0x26FFFFFF), width: 1.5), // 15% opacity, 1.5px stroke
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: obsidianBase.withOpacity(0.8),
        indicatorColor: accentPurple.withOpacity(0.2),
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: accentPurple, size: 28);
          }
          return IconThemeData(color: Colors.white.withOpacity(0.4), size: 24);
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accentPurple,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: accentPurple.withOpacity(0.5),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, letterSpacing: 0.5),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentPurple,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: slateGrey.withOpacity(0.5),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(999)),
          borderSide: BorderSide(color: Color(0x26FFFFFF), width: 1.5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(999)),
          borderSide: BorderSide(color: Color(0x26FFFFFF), width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(999)),
          borderSide: BorderSide(color: accentPurple, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0x1AFFFFFF), // 10% opacity divider
        thickness: 1,
        space: 24,
      ),
    );
  }
}
