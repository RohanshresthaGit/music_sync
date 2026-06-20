import 'package:flutter/material.dart';

import '../../extensions/build_context_extensions.dart';

class PrimaryButton extends StatelessWidget {
  final Color backgroundColor, textColor;
  final String title;
  final IconData? suffixIcon, prefixIcon;
  final VoidCallback? onPressed;
  final bool shouldElevate;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final BoxConstraints? constraints;
  const PrimaryButton({
    this.borderRadius,
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.title,
    this.onPressed,
    this.shouldElevate = true,
    this.suffixIcon,
    this.prefixIcon,
    this.constraints,
    this.padding,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: isLoading ? null : onPressed,
        child: Container(
          constraints: constraints,
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            boxShadow: shouldElevate
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                )
              : RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      if (prefixIcon != null) ...[
                        WidgetSpan(
                          child: Icon(prefixIcon, size: 16, color: textColor),
                        ),
                        const WidgetSpan(child: SizedBox(width: 8)),
                      ],
                      TextSpan(
                        text: title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      if (suffixIcon != null) ...[
                        const WidgetSpan(child: SizedBox(width: 8)),
                        WidgetSpan(
                          child: Icon(suffixIcon, size: 20, color: textColor),
                        ),
                      ],
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
