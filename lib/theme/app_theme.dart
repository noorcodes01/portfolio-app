// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class AppTheme {
//   // Colors
//   static const Color bgDark = Color(0xFF0A0E1A);
//   static const Color bgCard = Color(0xFF111827);
//   static const Color bgSurface = Color(0xFF1A2235);
//   static const Color accent = Color(0xFF6C63FF);
//   static const Color accentSecondary = Color(0xFF00D4AA);
//   static const Color textPrimary = Color(0xFFFFFFFF);
//   static const Color textSecondary = Color(0xFFB0B7C3);
//   static const Color textMuted = Color(0xFF6B7280);
//   static const Color divider = Color(0xFF1F2937);
//   static const Color error = Color(0xFFEF4444);
//   static const Color success = Color(0xFF10B981);
//
//   static ThemeData get darkTheme {
//     return ThemeData(
//       brightness: Brightness.dark,
//       scaffoldBackgroundColor: bgDark,
//       primaryColor: accent,
//       colorScheme: const ColorScheme.dark(
//         primary: accent,
//         secondary: accentSecondary,
//         background: bgDark,
//         surface: bgCard,
//         onPrimary: textPrimary,
//         onSecondary: textPrimary,
//         onBackground: textPrimary,
//         onSurface: textPrimary,
//       ),
//       textTheme: GoogleFonts.poppinsTextTheme(
//         const TextTheme(
//           displayLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
//           displayMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
//           headlineLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
//           headlineMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
//           headlineSmall: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
//           titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
//           titleMedium: TextStyle(color: textSecondary),
//           bodyLarge: TextStyle(color: textSecondary),
//           bodyMedium: TextStyle(color: textMuted),
//         ),
//       ),
//       appBarTheme: AppBarTheme(
//         backgroundColor: bgDark,
//         elevation: 0,
//         centerTitle: true,
//         titleTextStyle: GoogleFonts.poppins(
//           color: textPrimary,
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//         ),
//         iconTheme: const IconThemeData(color: textPrimary),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: bgSurface,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: divider),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: divider),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: accent, width: 2),
//         ),
//         labelStyle: const TextStyle(color: textMuted),
//         hintStyle: const TextStyle(color: textMuted),
//         prefixIconColor: textMuted,
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: accent,
//           foregroundColor: textPrimary,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
//           elevation: 0,
//         ),
//       ),
//       cardTheme: CardThemeData(
//         color: bgCard,
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//           side: const BorderSide(color: divider),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Dark Colors
  static const Color bgDark = Color(0xFF0A0E1A);
  static const Color bgCard = Color(0xFF111827);
  static const Color bgSurface = Color(0xFF1A2235);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B7C3);
  static const Color divider = Color(0xFF1F2937);

  // Light Colors
  static const Color lightBg = Color(0xFFF5F7FF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFEEF0FF);
  static const Color lightDivider = Color(0xFFE5E7EB);
  static const Color lightText = Color(0xFF111827);
  static const Color lightTextSub = Color(0xFF4B5563);

  // Shared
  static const Color accent = Color(0xFF6C63FF);
  static const Color accentSecondary = Color(0xFF00D4AA);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgDark,
      primaryColor: accent,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accentSecondary,
        background: bgDark,
        surface: bgCard,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Colors.white,
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: bgDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: bgSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accent, width: 2),
        ),
        labelStyle: const TextStyle(color: textMuted),
        hintStyle: const TextStyle(color: textMuted),
        prefixIconColor: textMuted,
      ),
      cardTheme: CardThemeData(
        color: bgCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: divider),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      primaryColor: accent,
      colorScheme: const ColorScheme.light(
        primary: accent,
        secondary: accentSecondary,
        background: lightBg,
        surface: lightCard,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: lightText,
        onSurface: lightText,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: lightBg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          color: lightText,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: lightText),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accent, width: 2),
        ),
        labelStyle: const TextStyle(color: textMuted),
        hintStyle: const TextStyle(color: textMuted),
        prefixIconColor: textMuted,
      ),
      cardTheme: CardThemeData(
        color: lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: lightDivider),
        ),
      ),
    );
  }

  // Helper to get colors based on current theme
  static Color cardColor(bool isDark) => isDark ? bgCard : lightCard;
  static Color dividerColor(bool isDark) => isDark ? divider : lightDivider;
  static Color textColor(bool isDark) => isDark ? Colors.white : lightText;
  static Color textSubColor(bool isDark) => isDark ? textSecondary : lightTextSub;
  static Color bgColor(bool isDark) => isDark ? bgDark : lightBg;
}