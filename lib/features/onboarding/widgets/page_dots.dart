import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// The page indicator: the current page is a long lime pill,
/// the others are small grey dots. It animates when the page changes.
class PageDots extends StatelessWidget {
  const PageDots({super.key, required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Page ${current + 1} of $count',
      child: ExcludeSemantics(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < count; i++) ...[
              if (i > 0) const SizedBox(width: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                width: i == current ? 24 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i == current ? AppColors.accent : AppColors.inactive,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
