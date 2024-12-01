import 'package:flutter/material.dart';

enum ToastSeverity {
  success,
  warning,
  error,
}

void showToast(
  BuildContext context,
  String message, {
  ToastSeverity severity = ToastSeverity.success,
}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) {
      Color backgroundColor;

      // Determine background color based on severity
      switch (severity) {
        case ToastSeverity.error:
          backgroundColor = Colors.red.withOpacity(0.8);
          break;
        case ToastSeverity.warning:
          backgroundColor = Colors.orange.withOpacity(0.8);
          break;
        case ToastSeverity.success:
        default:
          backgroundColor = Colors.green.withOpacity(0.8);
          break;
      }

      return Positioned(
        top: 30,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      );
    },
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
