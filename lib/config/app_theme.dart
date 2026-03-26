import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// Stitch "Motra V2" Design System — "The Precision Ledger"
// Architectural Minimalism · Tonal Depth · No-Line Rule
// ═══════════════════════════════════════════════════════════════════════════════

/// 8px grid spacing system (2× scale per Stitch)
class AppSpacing {
  static const double xs = 4;   // 0.5×
  static const double sm = 8;   // 1×
  static const double md = 16;  // 2×
  static const double lg = 24;  // 3× — default "breathing room"
  static const double xl = 32;  // 4×
  static const double xxl = 48; // 6×
  static const double xxxl = 64;// 8×
}

/// Color tokens mapped directly from Stitch Motra V2 namedColors
class AppColors {
  // ─── Primary ────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF003D9B);        // primary
  static const Color primaryContainer = Color(0xFF0052CC); // primary_container
  static const Color primaryFixed = Color(0xFFDAE2FF);   // primary_fixed
  static const Color primaryFixedDim = Color(0xFFB2C5FF); // primary_fixed_dim
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFFC4D2FF);
  static const Color onPrimaryFixed = Color(0xFF001848);

  // ─── Secondary ──────────────────────────────────────────────────────────
  static const Color secondary = Color(0xFF4C5E83);
  static const Color secondaryContainer = Color(0xFFBFD2FD);
  static const Color secondaryFixed = Color(0xFFD7E2FF);
  static const Color onSecondaryContainer = Color(0xFF475A7E);
  static const Color onSecondaryFixed = Color(0xFF041B3C);

  // ─── Tertiary (teal/growth — NOT generic green) ─────────────────────────
  static const Color tertiary = Color(0xFF004B59);
  static const Color tertiaryContainer = Color(0xFF006477);
  static const Color tertiaryFixedDim = Color(0xFF48D7F9);
  static const Color onTertiaryContainer = Color(0xFF76E2FF);

  // ─── Surface Hierarchy (layered glass approach) ─────────────────────────
  static const Color surface = Color(0xFFF8F9FB);
  static const Color surfaceBright = Color(0xFFF8F9FB);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF); // primary cards
  static const Color surfaceContainerLow = Color(0xFFF3F4F6);    // secondary groups
  static const Color surfaceContainer = Color(0xFFEDEEF0);
  static const Color surfaceContainerHigh = Color(0xFFE7E8EA);
  static const Color surfaceContainerHighest = Color(0xFFE1E2E4);
  static const Color surfaceDim = Color(0xFFD9DADC);
  static const Color surfaceTint = Color(0xFF0C56D0);

  // ─── On Surface ─────────────────────────────────────────────────────────
  static const Color onSurface = Color(0xFF191C1E);        // NOT pure black
  static const Color onSurfaceVariant = Color(0xFF434654);

  // ─── Outline ────────────────────────────────────────────────────────────
  static const Color outline = Color(0xFF737685);
  static const Color outlineVariant = Color(0xFFC3C6D6);

  // ─── Inverse ────────────────────────────────────────────────────────────
  static const Color inverseSurface = Color(0xFF2E3132);
  static const Color inverseOnSurface = Color(0xFFF0F1F3);
  static const Color inversePrimary = Color(0xFFB2C5FF);

  // ─── Semantic ───────────────────────────────────────────────────────────
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF93000A);

  // ─── Financial Semantic ─────────────────────────────────────────────────
  static const Color income = Color(0xFF004B59);     // Use tertiary for growth
  static const Color expense = Color(0xFFBA1A1A);    // Use error for loss
  static const Color transfer = Color(0xFF4C5E83);   // Use secondary for transfers

  // ─── Pacing Indicators ──────────────────────────────────────────────────
  static const Color pacingGreen = Color(0xFF004B59);  // Sophisticated teal
  static const Color pacingYellow = Color(0xFFF59E0B); // Keep warm amber
  static const Color pacingRed = Color(0xFFBA1A1A);    // Match error

  // ─── Financial Chips ────────────────────────────────────────────────────
  static const Color chipBackground = Color(0xFFD7E2FF); // secondary_fixed
  static const Color chipText = Color(0xFF041B3C);        // on_secondary_fixed

  // ─── Legacy Aliases (backwards compat) ──────────────────────────────────
  static const Color primaryLight = primaryContainer;
  static const Color primaryDark = inversePrimary;
  static const Color surfaceLight = surface;
  static const Color surfaceVariantLight = surfaceContainerLow;
  static const Color cardLight = surfaceContainerLowest;
  static const Color onSurfaceLight = onSurface;
  static const Color onSurfaceVariantLight = onSurfaceVariant;
  static const Color surfaceVariantDark = inverseSurface;
  static const Color cardDark = inverseSurface;
  static const Color onSurfaceDark = inverseOnSurface;
  static const Color onSurfaceVariantDark = Color(0xFF94A3B8);
  static const Color success = tertiary;
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = primaryContainer;
}

/// Primary-tinted ambient shadows per design system
class AppShadows {
  /// Floating elements (FAB, modals)
  static List<BoxShadow> get floating => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.08),
      blurRadius: 32,
      offset: const Offset(0, 12),
      spreadRadius: -4,
    ),
  ];

  /// Cards with subtle lift
  static List<BoxShadow> get card => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.04),
      blurRadius: 40,
      offset: const Offset(0, 20),
    ),
  ];

  /// None — default for most cards (tonal depth instead)
  static List<BoxShadow> get none => [];
}

/// Signature gradient for CTAs and hero elements
class AppGradients {
  /// Primary CTA gradient (135° angle)
  static const LinearGradient primaryCta = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primary,        // #003d9b
      AppColors.primaryContainer, // #0052cc
    ],
  );

  /// Net Worth / Hero card gradient
  static const LinearGradient heroCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primary,
      AppColors.primaryContainer,
      Color(0xFF2170E4),
    ],
  );

  /// Glassmorphism overlay
  static LinearGradient get glass => LinearGradient(
    colors: [
      AppColors.surfaceContainerLowest.withValues(alpha: 0.7),
      AppColors.surfaceContainerLowest.withValues(alpha: 0.7),
    ],
  );
}

class AppTheme {
  // ─── Border Radius (ROUND_EIGHT = 8px default) ────────────────────────
  static const double radiusSm = 4;
  static const double radiusMd = 8;   // default (ROUND_EIGHT)
  static const double radiusLg = 12;  // md in design spec = 0.75rem
  static const double radiusXl = 16;  // lg = 1rem
  static const double radiusXxl = 24; // xl = 1.5rem — pill buttons

  static ThemeData get light {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryContainer,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryFixed,
      onPrimaryContainer: AppColors.onPrimaryFixed,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onPrimary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onPrimary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      inverseSurface: AppColors.inverseSurface,
      onInverseSurface: AppColors.inverseOnSurface,
      inversePrimary: AppColors.inversePrimary,
      surfaceTint: AppColors.surfaceTint,
      surfaceContainerLowest: AppColors.surfaceContainerLowest,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      surfaceContainer: AppColors.surfaceContainer,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.surface,

      // ─── Typography: Manrope headlines + Inter body ───────────────────
      textTheme: _buildTextTheme(Brightness.light),

      // ─── AppBar ──────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.manrope(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurface,
        ),
      ),

      // ─── Cards: NO BORDERS — tonal shift only ────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXl),
          // NO side border — "No-Line" Rule
        ),
        margin: EdgeInsets.zero,
      ),

      // ─── Navigation Bar: Glassmorphism ────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceContainerLowest.withValues(alpha: 0.85),
        indicatorColor: AppColors.primaryFixed,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryContainer,
            );
          }
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          );
        }),
      ),

      // ─── FAB ──────────────────────────────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryContainer,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXl),
        ),
      ),

      // ─── Input Fields ─────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: BorderSide(
            color: AppColors.primaryContainer.withValues(alpha: 0.2),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),

      // ─── Elevated Buttons: Gradient via wrapper, fallback flat ────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryContainer,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ─── Text Buttons ─────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.onSecondaryContainer,
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // ─── Bottom Sheet ─────────────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      // ─── Dividers: use spacing, not lines ─────────────────────────────
      dividerTheme: DividerThemeData(
        color: AppColors.outlineVariant.withValues(alpha: 0.15),
        thickness: 1,
        space: 0,
      ),

      // ─── Tab Bar ──────────────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primaryContainer,
        unselectedLabelColor: AppColors.onSurfaceVariant,
        indicatorColor: AppColors.primaryContainer,
        labelStyle: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w500,
        ),
      ),

      // ─── Chip ─────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.secondaryFixed,
        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.onSecondaryFixed,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          side: BorderSide.none,
        ),
      ),

      // ─── Dialog ───────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXxl),
        ),
      ),

      // ─── Snackbar ─────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.inverseSurface,
        contentTextStyle: GoogleFonts.inter(
          color: AppColors.inverseOnSurface,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ─── Dark Theme (inherits from light with inversed surfaces) ──────────
  static ThemeData get dark {
    final lightTheme = light;

    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.inversePrimary,
      onPrimary: AppColors.onPrimaryFixed,
      primaryContainer: AppColors.primary,
      onPrimaryContainer: AppColors.primaryFixedDim,
      secondary: AppColors.secondaryFixed,
      onSecondary: AppColors.onSecondaryFixed,
      secondaryContainer: AppColors.onSecondaryContainer,
      onSecondaryContainer: AppColors.secondaryFixed,
      tertiary: AppColors.tertiaryFixedDim,
      onTertiary: Color(0xFF001F27),
      tertiaryContainer: AppColors.tertiary,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: AppColors.errorContainer,
      surface: Color(0xFF111315),
      onSurface: Color(0xFFE1E2E4),
      onSurfaceVariant: Color(0xFFC3C6D6),
      outline: Color(0xFF8D909F),
      outlineVariant: Color(0xFF434654),
      inverseSurface: Color(0xFFE1E2E4),
      onInverseSurface: Color(0xFF2E3132),
      inversePrimary: AppColors.primaryContainer,
      surfaceTint: AppColors.inversePrimary,
      surfaceContainerLowest: Color(0xFF0C0E10),
      surfaceContainerLow: Color(0xFF191C1E),
      surfaceContainer: Color(0xFF1D2022),
      surfaceContainerHigh: Color(0xFF272A2C),
      surfaceContainerHighest: Color(0xFF323537),
    );

    return lightTheme.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: lightTheme.appBarTheme.copyWith(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: GoogleFonts.manrope(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
      ),
      cardTheme: lightTheme.cardTheme.copyWith(
        color: colorScheme.surfaceContainerLow,
      ),
      navigationBarTheme: lightTheme.navigationBarTheme.copyWith(
        backgroundColor: colorScheme.surfaceContainerLow.withValues(alpha: 0.85),
        indicatorColor: colorScheme.primaryContainer.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            );
          }
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
          );
        }),
      ),
      floatingActionButtonTheme: lightTheme.floatingActionButtonTheme.copyWith(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.surface,
      ),
      inputDecorationTheme: lightTheme.inputDecorationTheme.copyWith(
        fillColor: colorScheme.surfaceContainerHigh,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: BorderSide(
            color: colorScheme.primary.withValues(alpha: 0.2),
            width: 2,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.surface,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.15),
        thickness: 1,
        space: 0,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      snackBarTheme: lightTheme.snackBarTheme.copyWith(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: GoogleFonts.inter(
          color: colorScheme.onInverseSurface,
          fontSize: 14,
        ),
      ),
    );
  }

  // ─── Text Theme: Manrope (headlines) + Inter (body/labels) ────────────
  static TextTheme _buildTextTheme(Brightness brightness) {
    final color = brightness == Brightness.light
        ? AppColors.onSurface
        : AppColors.inverseOnSurface;

    return TextTheme(
      // Display — Manrope for high-impact balances
      displayLarge: GoogleFonts.manrope(
        fontSize: 57, fontWeight: FontWeight.w700, color: color,
      ),
      displayMedium: GoogleFonts.manrope(
        fontSize: 45, fontWeight: FontWeight.w700, color: color,
      ),
      displaySmall: GoogleFonts.manrope(
        fontSize: 36, fontWeight: FontWeight.w700, color: color,
      ),
      // Headline — Manrope for section titles
      headlineLarge: GoogleFonts.manrope(
        fontSize: 32, fontWeight: FontWeight.w700, color: color,
      ),
      headlineMedium: GoogleFonts.manrope(
        fontSize: 28, fontWeight: FontWeight.w600, color: color,
      ),
      headlineSmall: GoogleFonts.manrope(
        fontSize: 24, fontWeight: FontWeight.w600, color: color,
      ),
      // Title — Manrope for smaller headers
      titleLarge: GoogleFonts.manrope(
        fontSize: 22, fontWeight: FontWeight.w600, color: color,
      ),
      titleMedium: GoogleFonts.manrope(
        fontSize: 16, fontWeight: FontWeight.w600, color: color,
      ),
      titleSmall: GoogleFonts.manrope(
        fontSize: 14, fontWeight: FontWeight.w600, color: color,
      ),
      // Body — Inter for transactional data
      bodyLarge: GoogleFonts.inter(
        fontSize: 16, fontWeight: FontWeight.w400, color: color,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: color,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12, fontWeight: FontWeight.w400, color: color,
      ),
      // Label — Inter for functional labels
      labelLarge: GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w500, color: color,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12, fontWeight: FontWeight.w500, color: color,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11, fontWeight: FontWeight.w500, color: color,
      ),
    );
  }
}

/// Glassmorphism wrapper widget for nav bars and overlays
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 24,
    this.opacity = 0.7,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest.withValues(alpha: opacity),
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Gradient CTA button matching the "Signature Texture"
class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final double? width;
  final double height;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.width,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: onPressed != null ? AppGradients.primaryCta : null,
        color: onPressed == null ? AppColors.surfaceContainerHigh : null,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: onPressed != null ? AppShadows.floating : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : DefaultTextStyle(
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    child: child,
                  ),
          ),
        ),
      ),
    );
  }
}
