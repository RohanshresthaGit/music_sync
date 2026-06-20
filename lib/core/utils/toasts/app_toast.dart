import 'package:flutter/material.dart';

/// A utility class for showing toast messages in the app.
///
/// Provides methods to display different types of toasts:
/// - Success
/// - Error
/// - Warning
/// - Info
///
/// Each toast supports a custom message and icon.
///
/// The toast automatically dismisses after a short duration (default: ~2 seconds).
///
/// ---
///
/// ## Example Usage
///
/// ```dart
/// AppToast.showSuccess(
///   context,
///   message: 'Data saved successfully!',
///   icon: Icons.check_circle,
/// );
///
/// AppToast.showError(
///   context,
///   message: 'Failed to save data.',
///   icon: Icons.error,
/// );
///
/// AppToast.showWarning(
///   context,
///   message: 'Please check your input.',
///   icon: Icons.warning,
/// );
///
/// AppToast.showInfo(
///   context,
///   message: 'New update available.',
///   icon: Icons.info,
/// );
/// ```
///
/// ---
///
/// ## Notes
/// - Use success for successful operations
/// - Use error for failures or exceptions
/// - Use warning for user input or validation issues
/// - Use info for neutral or informational messages
///
/// Keep messages short and user-friendly.
class AppToast {
  static void showSuccess(
    BuildContext context, {
    String message = 'Success! Operation completed.',
    IconData? icon,
  }) {
    showToast(context, message, icon, ToastType.success);
  }

  static void showError(
    BuildContext context, {
    String message = 'Error! Something went wrong.',
    IconData? icon,
  }) {
    showToast(context, message, icon, ToastType.error);
  }

  static void showWarning(
    BuildContext context, {
    String message = 'Warning! Something needs attention.',
    IconData? icon,
  }) {
    showToast(context, message, icon, ToastType.warning);
  }

  static void showInfo(
    BuildContext context, {
    String message = 'Info! Please check the details.',
    IconData? icon
  }) {
    showToast(context, message, icon, ToastType.info);
  }
}

enum ToastType { success, error, warning, info }

// Function to show toast messages
void showToast(
  BuildContext context,
  String message,
  IconData? icon,
  ToastType type,
) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50.0, // distance from the bottom of the screen
      left: 50.0, // distance from the left
      right: 50.0, // distance from the right
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: _getBackgroundColor(
              type,
            ), // Set background color based on type
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            spacing: 8,
            children: [
              Icon(icon, color: Colors.white), // Icon based on toast type
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white, // White text color for contrast
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  // Dismiss the toast after 2 seconds
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

// Helper function to get the background color based on the toast type
Color _getBackgroundColor(ToastType type) {
  switch (type) {
    case ToastType.success:
      return Colors.green.withValues(alpha: 0.8); // Green for success
    case ToastType.error:
      return Colors.red.withValues(alpha: 0.8); // Red for error
    case ToastType.warning:
      return Colors.orange.withValues(alpha: 0.8); // Orange for warning
    case ToastType.info:
      return Colors.blue.withValues(alpha: 0.8); // Blue for info
    default:
      return Colors.black.withValues(
        alpha: 0.8,
      ); // Default black for unknown types
  }
}
