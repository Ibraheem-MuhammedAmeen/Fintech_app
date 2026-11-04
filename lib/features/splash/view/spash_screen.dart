import 'package:fintech/core/theme/app_colors.dart';
import 'package:fintech/core/theme/app_dimens.dart';
import 'package:flutter/material.dart';


/// Splash screen from the design: logo, app name, tagline, loading bar.
///
/// Put your start-up work in [_start] (e.g. read the saved token), then
/// go to onboarding / login / home.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onFinished});

  /// Called when start-up work is done. Navigate from here, e.g.
  /// `onFinished: () => Navigator.pushReplacement(context, ...)`
  final VoidCallback onFinished;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    // TODO: replace with real work, e.g. check if a Sanctum token is saved.
    await Future<void>.delayed(const Duration(milliseconds: 1800));
    if (!mounted) return;
    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          // Soft lime glow behind the logo.
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.1),
                  radius: 0.6,
                  colors: [
                    AppColors.accent.withValues(alpha: 0.14),
                    AppColors.background.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.xl, AppDimens.xxl, AppDimens.xl, 56,
              ),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset('assets/images/splash_logo.png', width: 96, height: 96),
                  const SizedBox(height: AppDimens.xl),
                  Text('Fintech', style: text.displaySmall?.copyWith(fontSize: 44)),
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: 'Money that moves ',
                      style: text.bodyMedium?.copyWith(
                        fontSize: 15,
                        color: AppColors.textMuted,
                      ),
                      children: [
                        TextSpan(
                          text: 'at your pace.',
                          style: text.headlineSmall?.copyWith(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(999)),
                      child: LinearProgressIndicator(minHeight: 4),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'SECURED WITH YOUR PIN',
                    style: text.labelSmall?.copyWith(color: AppColors.inactive),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
