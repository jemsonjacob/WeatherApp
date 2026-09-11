import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather/core/theme/app_colors.dart';

class WeatherContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double blur;
  final Color? color;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;

  const WeatherContainer({
    super.key,
    required this.child,
    this.borderRadius = 24.0,
    this.padding,
    this.margin,
    this.blur = 15.0,
    this.color,
    this.border,
    this.boxShadow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultColor =
        color ??
        (isDark
            ? AppColors.darkGlassBackground
            : AppColors.lightGlassBackground);

    final defaultBorder =
        border ??
        Border.all(
          color: isDark
              ? AppColors.darkGlassBorder
              : AppColors.lightGlassBorder,
          width: 1.5,
        );

    final defaultShadow =
        boxShadow ??
        [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ];

    Widget content = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: defaultBorder,
            boxShadow: defaultShadow,
          ),
          child: child,
        ),
      ),
    );

    if (margin != null) {
      content = Padding(padding: margin!, child: content);
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: content);
    }

    return content;
  }
}
