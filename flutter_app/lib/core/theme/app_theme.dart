import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color seedColor = Color(0xFF1A237E);
  static const Color errorColor = Color(0xFFFF5252);
  static const Color secondaryColor = Color(0xFF2E7D32);
  static const Color lightBackground = Color(0xFFF5F6FA);
  static const Color darkBackground = Color(0xFF0F1117);

  static final TextTheme _textTheme = GoogleFonts.interTextTheme(
    const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
    ),
  );

  static ThemeData lightTheme(ColorScheme? dynamicColor) {
    final ColorScheme colorScheme =
        dynamicColor?.copyWith(
          error: errorColor,
          secondary: secondaryColor,
          surface: lightBackground,
        ) ??
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
          error: errorColor,
          secondary: secondaryColor,
          surface: lightBackground,
        );

    return _buildTheme(colorScheme);
  }

  static ThemeData darkTheme(ColorScheme? dynamicColor) {
    final ColorScheme colorScheme =
        dynamicColor?.copyWith(
          error: errorColor,
          secondary: secondaryColor,
          surface: darkBackground,
        ) ??
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
          error: errorColor,
          secondary: secondaryColor,
          surface: darkBackground,
        );

    return _buildTheme(colorScheme);
  }

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 1,
        margin: EdgeInsets.zero,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.all<TextStyle>(
          _textTheme.labelSmall!.copyWith(color: colorScheme.onSurface),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.onPrimaryContainer);
          }
          return IconThemeData(color: colorScheme.onSurfaceVariant);
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
