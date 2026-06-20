import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Light Mode Colors - Maroon / warm palette for music vibe
  static const Color lightBackground = Color(0xFFFEF6F6);
  static const Color lightPrimary = Color(0xFF7B1122); // maroon
  static const Color lightSurface = Color(0xFFF9F3F3);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF2B1A1E);
  static const Color lightBorder = Color(0xFFE6D9D9);
  static const Color lightHint = Color(0xFF9E7A7F);
  static const Color lightError = Color(0xFFD32F2F);
  static const Color lightSuccess = Color(0xFF2E7D32);
  static const Color lightWarning = Color(0xFFF57C00);
  static const Color lightInfo = Color(0xFF1976D2);
  static const Color lightComplement = Color(0xFFFFC107); // warm accent

  // Dark Mode Colors - Maroon variants
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkPrimary = Color(0xFFB76B6B);
  static const Color darkOnPrimary = Color(0xFFFFFFFF);
  static const Color darkOnSurface = Color(0xFFECECEC);
  static const Color darkBorder = Color(0xFF2B2B2B);
  static const Color darkHint = Color(0xFFBBA9A9);
  static const Color darkError = Color(0xFFEF5350);
  static const Color darkSuccess = Color(0xFF81C784);
  static const Color darkWarning = Color(0xFFFFB74D);
  static const Color darkInfo = Color(0xFF64B5F6);

  static final ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: lightPrimary,
    onPrimary: lightOnPrimary,
    secondary: lightComplement,
    onSecondary: lightOnSurface,
    tertiary: Color(0xFFBD3B3B),
    onTertiary: lightOnPrimary,
    error: lightError,
    onError: Color(0xFFFFFFFF),
    surface: lightSurface,
    onSurface: lightOnSurface,
    outline: lightBorder,
    outlineVariant: Color(0xFFCCC4BA),
    scrim: Colors.black,
    inverseSurface: darkOnSurface,
    // in: lightBackground,
    inversePrimary: darkPrimary,
    surfaceDim: Color(0xFFF1E9E0),
    surfaceBright: lightSurface,
  );

  static final ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: darkPrimary,
    onPrimary: darkOnPrimary,
    secondary: Color(0xFF99CBA1),
    onSecondary: darkOnPrimary,
    tertiary: Color(0xFFFFB4AE),
    onTertiary: Color(0xFF5C1515),
    error: darkError,
    onError: Color(0xFF000000),
    surface: darkSurface,
    onSurface: darkOnSurface,
    outline: darkBorder,
    outlineVariant: darkBorder,
    scrim: Colors.black,
    inverseSurface: lightBackground,
    // inverseOnSurface: darkBackground,
    inversePrimary: lightPrimary,
    surfaceDim: darkBackground,
    surfaceBright: Color(0xFF3D4C42),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: "Manrope",
      useMaterial3: true,
      colorScheme: lightColorScheme,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      canvasColor: lightSurface,
      cardColor: lightSurface,

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: lightPrimary,
        foregroundColor: lightOnPrimary,
        elevation: 0,
        scrolledUnderElevation: 4,
        centerTitle: false,
        iconTheme: IconThemeData(color: lightPrimary),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: lightOnPrimary,
        ),
      ),

      // Text Theme
      textTheme: _textTheme(lightColorScheme),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xffE5E2DC),
        hintStyle: const TextStyle(color: lightHint, fontSize: 14),
        labelStyle: const TextStyle(color: lightPrimary, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightError, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE8D5C4)),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary,
          foregroundColor: lightOnPrimary,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightPrimary,
          side: const BorderSide(color: lightPrimary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: lightPrimary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return lightPrimary;
          return lightHint;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return lightPrimary.withValues(alpha: 0.5);
          }
          return lightBorder;
        }),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: lightPrimary.withValues(alpha: 0.1),
        margin: EdgeInsets.zero,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: lightOnSurface, size: 24),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: lightOnSurface,
        contentTextStyle: const TextStyle(
          color: lightBackground,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 6,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: lightSurface,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: const TextStyle(
          color: lightOnSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: const TextStyle(color: lightOnSurface, fontSize: 14),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: lightSurface,
        disabledColor: const Color(0xFFEBE1D9),
        selectedColor: lightPrimary,
        secondarySelectedColor: lightComplement,
        side: const BorderSide(color: lightBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        labelStyle: const TextStyle(color: lightOnSurface),
        secondaryLabelStyle: const TextStyle(color: lightOnPrimary),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: lightSurface,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        surfaceTintColor: lightPrimary,
      ),

      // Drawer Theme
      drawerTheme: const DrawerThemeData(
        backgroundColor: lightSurface,
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
        ),
      ),

      // Menu Theme
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(lightSurface),
          elevation: const WidgetStatePropertyAll(8),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),

      // Menu Button Highlight Color
      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return lightPrimary.withValues(alpha: 0.1);
            }
            return Colors.transparent;
          }),
          overlayColor: WidgetStatePropertyAll(
            lightPrimary.withValues(alpha: 0.1),
          ),
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: lightPrimary,
        linearTrackColor: lightBorder,
        linearMinHeight: 4,
        refreshBackgroundColor: lightSurface,
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: lightPrimary,
        inactiveTrackColor: lightBorder,
        thumbColor: lightPrimary,
        overlayColor: lightPrimary.withValues(alpha: 0.2),
        valueIndicatorColor: lightPrimary,
        valueIndicatorTextStyle: const TextStyle(color: lightOnPrimary),
      ),

      // Tab Bar Theme
      tabBarTheme: const TabBarThemeData(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: lightPrimary, width: 3),
        ),
        labelColor: lightPrimary,
        unselectedLabelColor: lightHint,
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return lightPrimary;
          return Colors.transparent;
        }),
        checkColor: const WidgetStatePropertyAll(lightOnPrimary),
        side: const BorderSide(color: lightPrimary),
        //  const BorderSide(color: lightBorder);
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return lightPrimary;
          return Colors.transparent;
        }),
        overlayColor: WidgetStatePropertyAll(
          lightPrimary.withValues(alpha: 0.2),
        ),
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: lightOnSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          color: lightBackground,
          fontWeight: FontWeight.w500,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        tileColor: lightSurface,
        selectedTileColor: lightPrimary.withValues(alpha: 0.1),
        textColor: lightOnSurface,
        titleTextStyle: const TextStyle(
          color: lightOnSurface,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: const TextStyle(color: lightHint, fontSize: 14),
        leadingAndTrailingTextStyle: const TextStyle(
          color: lightHint,
          fontSize: 12,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightPrimary,
        foregroundColor: lightOnPrimary,
        elevation: 6,
        hoverElevation: 8,
        focusElevation: 6,
        highlightElevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Popup Menu Theme
      popupMenuTheme: PopupMenuThemeData(
        color: lightSurface,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(color: lightOnSurface),
      ),

      // Search Bar Theme
      searchBarTheme: SearchBarThemeData(
        backgroundColor: const WidgetStatePropertyAll(lightSurface),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        side: const WidgetStatePropertyAll(BorderSide(color: lightBorder)),
        hintStyle: const WidgetStatePropertyAll(
          TextStyle(color: lightHint, fontSize: 14),
        ),
      ),

    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: "Manrope",
      useMaterial3: true,
      colorScheme: darkColorScheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      canvasColor: darkSurface,
      cardColor: darkSurface,

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1B3229),
        foregroundColor: darkOnSurface,
        elevation: 0,
        scrolledUnderElevation: 4,
        centerTitle: false,
        iconTheme: IconThemeData(color: darkOnSurface),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkOnSurface,
        ),
      ),

      // Text Theme
      textTheme: _textTheme(darkColorScheme),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1B3229),
        hintStyle: const TextStyle(color: darkHint, fontSize: 14),
        labelStyle: const TextStyle(color: darkPrimary, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkError, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2A4138)),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimary,
          foregroundColor: darkOnPrimary,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkPrimary,
          side: const BorderSide(color: darkPrimary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkPrimary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return darkPrimary;
          return const Color(0xFF5A6B60);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return darkPrimary.withValues(alpha: 0.5);
          }
          return darkBorder;
        }),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.black.withValues(alpha: 0.3),
        margin: EdgeInsets.zero,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: darkOnSurface, size: 24),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF1B3229),
        contentTextStyle: const TextStyle(
          color: darkOnSurface,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 6,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: darkSurface,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: const TextStyle(
          color: darkOnSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: const TextStyle(color: darkOnSurface, fontSize: 14),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: darkSurface,
        disabledColor: const Color(0xFF2A4138),
        selectedColor: darkPrimary,
        secondarySelectedColor: const Color(0xFF99CBA1),
        side: const BorderSide(color: darkBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        labelStyle: const TextStyle(color: darkOnSurface),
        secondaryLabelStyle: const TextStyle(color: darkOnPrimary),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: darkSurface,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        surfaceTintColor: darkPrimary,
      ),

      // Drawer Theme
      drawerTheme: const DrawerThemeData(
        backgroundColor: darkSurface,
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
        ),
      ),

      // Menu Theme
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(darkSurface),
          elevation: const WidgetStatePropertyAll(8),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),

      // Menu Button Highlight Color
      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return darkPrimary.withValues(alpha: 0.2);
            }
            return Colors.transparent;
          }),
          overlayColor: WidgetStatePropertyAll(
            darkPrimary.withValues(alpha: 0.2),
          ),
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: darkPrimary,
        linearTrackColor: darkBorder,
        linearMinHeight: 4,
        refreshBackgroundColor: darkSurface,
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: darkPrimary,
        inactiveTrackColor: darkBorder,
        thumbColor: darkPrimary,
        overlayColor: darkPrimary.withValues(alpha: 0.3),
        valueIndicatorColor: darkPrimary,
        valueIndicatorTextStyle: const TextStyle(color: darkOnPrimary),
      ),

      // Tab Bar Theme
      tabBarTheme: const TabBarThemeData(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: darkPrimary, width: 3),
        ),
        labelColor: darkPrimary,
        unselectedLabelColor: darkHint,
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return darkPrimary;
          return Colors.transparent;
        }),
        checkColor: const WidgetStatePropertyAll(darkOnPrimary),
        side: const BorderSide(color: darkPrimary),
        //  const BorderSide(color: darkBorder);
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return darkPrimary;
          return Colors.transparent;
        }),
        overlayColor: WidgetStatePropertyAll(
          darkPrimary.withValues(alpha: 0.3),
        ),
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: const Color(0xFF1B3229),
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          color: darkOnSurface,
          fontWeight: FontWeight.w500,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        tileColor: darkSurface,
        selectedTileColor: darkPrimary.withValues(alpha: 0.2),
        textColor: darkOnSurface,
        titleTextStyle: const TextStyle(
          color: darkOnSurface,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: const TextStyle(color: darkHint, fontSize: 14),
        leadingAndTrailingTextStyle: const TextStyle(
          color: darkHint,
          fontSize: 12,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkPrimary,
        foregroundColor: darkOnPrimary,
        elevation: 6,
        hoverElevation: 8,
        focusElevation: 6,
        highlightElevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Popup Menu Theme
      popupMenuTheme: PopupMenuThemeData(
        color: darkSurface,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(color: darkOnSurface),
      ),

      // Search Bar Theme
      searchBarTheme: SearchBarThemeData(
        backgroundColor: const WidgetStatePropertyAll(Color(0xFF1B3229)),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        side: const WidgetStatePropertyAll(BorderSide(color: darkBorder)),
        hintStyle: const WidgetStatePropertyAll(
          TextStyle(color: darkHint, fontSize: 14),
        ),
      ),
    );
  }

  static TextTheme _textTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: colorScheme.onSurface,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: colorScheme.onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
        color: colorScheme.onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
        color: colorScheme.onSurface.withValues(alpha: 0.9),
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.1,
        color: colorScheme.primary,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: colorScheme.primary,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: colorScheme.onSurface.withValues(alpha: 0.75),
      ),
    );
  }
}
