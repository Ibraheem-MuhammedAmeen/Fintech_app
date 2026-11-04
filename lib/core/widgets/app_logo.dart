import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// The app's logo mark: a lime rounded square with an up-right arrow.
/// Same mark as assets/images/splash_logo.png, drawn in code so it stays sharp.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(
        Icons.north_east_rounded,
        size: size * 0.55,
        color: AppColors.onAccent,
        semanticLabel: 'Fintech logo',
      ),
    );
  }
}
