import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/colors.dart';

/// A custom primary button that uses the app's primary color.
class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? child;
  final double? width;
  final double? height;
  /// Whether the button is enabled or not
  final bool isEnabled;

  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.child,
    this.width,
    this.height,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          disabledBackgroundColor: AppColors.secondary,
          foregroundColor: onPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: child ?? Text(text),
      ),
    );
  }
}
