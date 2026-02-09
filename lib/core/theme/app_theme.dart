import 'package:flutter/material.dart';

class AppTheme {
  static const Color pureBlack = Color(0xFF000000);
  static const Color neonBlue = Color(0xFF00BFFF);
  static const Color neonViolet = Color(0xFF8A2BE2);
  static const Color neonGreen = Color(0xFF00FF00);
  static const Color neonRed = Color(0xFFFF0080);
  static const Color darkGray = Color(0xFF1A1A1A);
  static const Color mediumGray = Color(0xFF2D2D2D);
  static const Color lightGray = Color(0xFF404040);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: pureBlack,
      backgroundColor: pureBlack,
      cardColor: darkGray,
      
      colorScheme: const ColorScheme.dark(
        primary: neonBlue,
        secondary: neonViolet,
        surface: darkGray,
        background: pureBlack,
        error: neonRed,
        onPrimary: pureBlack,
        onSecondary: pureBlack,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: pureBlack,
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: pureBlack,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'JetBrainsMono',
        ),
        iconTheme: IconThemeData(color: neonBlue),
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkGray,
        selectedItemColor: neonBlue,
        unselectedItemColor: lightGray,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      cardTheme: CardTheme(
        color: darkGray,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: neonBlue, width: 0.5),
        ),
      ),
      
      listTileTheme: const ListTileThemeData(
        iconColor: neonBlue,
        textColor: Colors.white,
        tileColor: darkGray,
        selectedTileColor: mediumGray,
      ),
      
      iconTheme: const IconThemeData(
        color: neonBlue,
        size: 24,
      ),
      
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'JetBrainsMono',
        ),
        displayMedium: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: 'JetBrainsMono',
        ),
        headlineLarge: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'JetBrainsMono',
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'JetBrainsMono',
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'JetBrainsMono',
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'JetBrainsMono',
        ),
        labelLarge: TextStyle(
          color: neonBlue,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'JetBrainsMono',
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: neonBlue,
          foregroundColor: pureBlack,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: neonBlue,
          side: const BorderSide(color: neonBlue, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: neonBlue,
        linearTrackColor: darkGray,
        circularTrackColor: darkGray,
      ),
      
      dividerTheme: const DividerThemeData(
        color: mediumGray,
        thickness: 1,
      ),
    );
  }
}
