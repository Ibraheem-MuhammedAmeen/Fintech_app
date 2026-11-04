import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

/// The three pictures at the top of the onboarding pages.
///
/// Each one is drawn on a fixed 342 × 300 canvas (the design size) and then
/// scaled to fit the space it gets, so it never overflows on small phones.

double _deg(double degrees) => degrees * math.pi / 180;

/// Wraps a 342 × 300 drawing so it scales down on small screens.
class _Canvas extends StatelessWidget {
  const _Canvas({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          width: 342,
          height: 300,
          child: Stack(clipBehavior: Clip.none, children: children),
        ),
      ),
    );
  }
}

/// Small rounded "pill" label, e.g. "+₦300.00".
class _Pill extends StatelessWidget {
  const _Pill({
    required this.icon,
    required this.label,
    this.filled = true,
  });

  final IconData icon;
  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final fg = filled ? AppColors.onAccent : AppColors.text;
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: filled ? AppColors.accent : AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: filled ? null : Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: filled ? fg : AppColors.accent),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: filled ? FontWeight.w700 : FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

const _cardBorder = BorderSide(color: AppColors.border);

// ─────────────────────────────────────────────────────────────────────
// Page 1 — two tilted wallet cards + "+₦300.00" pill
// ─────────────────────────────────────────────────────────────────────
class WalletIllustration extends StatelessWidget {
  const WalletIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return _Canvas(
      children: [
        // Back card
        Positioned(
          left: 34,
          top: 46,
          child: Transform.rotate(
            angle: _deg(-8),
            child: Container(
              width: 270,
              height: 168,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.fromBorderSide(_cardBorder),
              ),
            ),
          ),
        ),
        // Front card with the balance
        Positioned(
          left: 48,
          top: 70,
          child: Transform.rotate(
            angle: _deg(4),
            child: Container(
              width: 270,
              height: 168,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(24),
                border: Border.fromBorderSide(_cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Wallet balance',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                  const Text(
                    '₦4,300.00',
                    style: TextStyle(
                      fontFamily: AppFonts.displayFont,
                      fontSize: 40,
                      height: 1,
                      color: AppColors.text,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '9012345678',
                        style: TextStyle(fontSize: 13, letterSpacing: 1),
                      ),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
          right: 4,
          top: 6,
          child: _Pill(icon: Icons.south_west_rounded, label: '+₦300.00'),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Page 2 — phone number field → recipient name → "₦1,000 sent"
// ─────────────────────────────────────────────────────────────────────
class PayByNumberIllustration extends StatelessWidget {
  const PayByNumberIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return _Canvas(
      children: [
        // Phone number "field" (focused, lime border)
        Positioned(
          left: 20,
          right: 20,
          top: 40,
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.accent, width: 1.5),
            ),
            child: Row(
              children: [
                const Icon(Icons.smartphone_rounded,
                    size: 20, color: AppColors.textMuted),
                const SizedBox(width: 12),
                const Text(
                  '0803 123 4567',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 4),
                Container(width: 2, height: 24, color: AppColors.accent), // cursor
              ],
            ),
          ),
        ),
        // Connector line
        Positioned(
          left: 170,
          top: 108,
          child: Container(width: 2, height: 26, color: AppColors.border),
        ),
        // Recipient found card
        Positioned(
          left: 34,
          right: 34,
          top: 142,
          child: Transform.rotate(
            angle: _deg(-2),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(22),
                border: Border.fromBorderSide(_cardBorder),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      'BA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bola Adeyemi',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '8031234567',
                          style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded,
                        size: 18, color: AppColors.onAccent),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
          right: 8,
          top: 236,
          child: _Pill(icon: Icons.north_east_rounded, label: '₦1,000 sent'),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Page 3 — mini history card + PIN card + "Locks after 5 wrong tries"
// ─────────────────────────────────────────────────────────────────────
class SecurityIllustration extends StatelessWidget {
  const SecurityIllustration({super.key});

  Widget _historyRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String amount,
    required Color amountColor,
  }) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.surface2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: amountColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _Canvas(
      children: [
        // History card (behind)
        Positioned(
          left: 30,
          top: 30,
          child: Transform.rotate(
            angle: _deg(-7),
            child: Container(
              width: 270,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.fromBorderSide(_cardBorder),
              ),
              child: Column(
                children: [
                  _historyRow(
                    icon: Icons.south_west_rounded,
                    iconColor: AppColors.accent,
                    label: 'From Bola Adeyemi',
                    amount: '+₦300',
                    amountColor: AppColors.credit,
                  ),
                  const SizedBox(height: 12),
                  _historyRow(
                    icon: Icons.north_east_rounded,
                    iconColor: AppColors.text,
                    label: 'To Bola Adeyemi',
                    amount: '−₦1,000',
                    amountColor: AppColors.debit,
                  ),
                ],
              ),
            ),
          ),
        ),
        // PIN card (front)
        Positioned(
          left: 64,
          top: 104,
          child: Transform.rotate(
            angle: _deg(3),
            child: Container(
              width: 260,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.surface2,
                borderRadius: BorderRadius.circular(24),
                border: Border.fromBorderSide(_cardBorder),
              ),
              child: Column(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.lock_outline_rounded,
                        size: 26, color: AppColors.onAccent),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < 4; i++) ...[
                        if (i > 0) const SizedBox(width: 16),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Enter PIN to send ₦1,000',
                    style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
          left: 4,
          top: 252,
          child: _Pill(
            icon: Icons.shield_outlined,
            label: 'Locks after 5 wrong tries',
            filled: false,
          ),
        ),
      ],
    );
  }
}
