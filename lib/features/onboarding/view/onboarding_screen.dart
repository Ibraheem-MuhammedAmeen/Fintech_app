import 'package:fintech/core/theme/app_colors.dart';
import 'package:fintech/core/theme/app_dimens.dart';
import 'package:fintech/core/widgets/app_logo.dart';
import 'package:fintech/features/onboarding/widgets/onboarding_illustrations.dart';
import 'package:fintech/features/onboarding/widgets/page_dots.dart';
import 'package:flutter/material.dart';


/// The text and picture for one onboarding page.
class _OnboardingPage {
  const _OnboardingPage({
    required this.illustration,
    required this.title,
    required this.titleAccent,
    required this.body,
  });

  final Widget illustration;
  final String title; // first line, normal
  final String titleAccent; // second line, lime italic
  final String body;
}

const _pages = [
  _OnboardingPage(
    illustration: WalletIllustration(),
    title: 'Money that moves',
    titleAccent: 'at your pace.',
    body: 'Send to any phone number, see every naira in and out, '
        'and keep it all locked behind your PIN.',
  ),
  _OnboardingPage(
    illustration: PayByNumberIllustration(),
    title: 'Pay anyone with',
    titleAccent: 'just a number.',
    body: 'A phone number is the account number. Type it, check the name '
        'we show you, and send. Save the people you pay often.',
  ),
  _OnboardingPage(
    illustration: SecurityIllustration(),
    title: 'Every naira,',
    titleAccent: 'locked tight.',
    body: 'Your 4-digit PIN approves every transfer. Every naira in or out '
        'lands in your history with a reference you can check.',
  ),
];

/// Three swipeable onboarding pages.
///
/// The top bar, page dots and buttons stay still while only the picture and
/// text slide, like the design.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
    required this.onCreateAccount,
    required this.onLogin,
  });

  /// "Create account" on the last page → go to the Register screen.
  final VoidCallback onCreateAccount;

  /// "I already have an account" on the last page → go to the Login screen.
  final VoidCallback onLogin;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _duration = Duration(milliseconds: 350);
  static const _curve = Curves.easeOutCubic;

  final _controller = PageController();
  int _index = 0;

  bool get _isLast => _index == _pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() => _controller.nextPage(duration: _duration, curve: _curve);

  void _back() => _controller.previousPage(duration: _duration, curve: _curve);

  void _skip() => _controller.animateToPage(
        _pages.length - 1,
        duration: _duration,
        curve: _curve,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.screenPadding,
            AppDimens.lg,
            AppDimens.screenPadding,
            28,
          ),
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) => _PageContent(page: _pages[i]),
                ),
              ),
              const SizedBox(height: AppDimens.xl),
              Align(
                alignment: Alignment.centerLeft,
                child: PageDots(count: _pages.length, current: _index),
              ),
              const SizedBox(height: AppDimens.xxl),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  /// Logo + Skip on page 1, Back + Skip on page 2, Back only on page 3.
  Widget _buildTopBar() {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _index == 0
                ? const AppLogo(key: ValueKey('logo'))
                : IconButton(
                    key: const ValueKey('back'),
                    onPressed: _back,
                    tooltip: 'Back',
                    style: IconButton.styleFrom(
                      fixedSize: const Size(44, 44),
                      side: const BorderSide(color: AppColors.border),
                      foregroundColor: AppColors.text,
                    ),
                    icon: const Icon(Icons.chevron_left_rounded, size: 24),
                  ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isLast ? 0 : 1,
            child: IgnorePointer(
              ignoring: _isLast,
              child: TextButton(
                onPressed: _skip,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textMuted,
                  // Start from the theme style so the font stays Manrope.
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontSize: 15),
                ),
                child: const Text('Skip'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// "Next" on pages 1–2; "Create account" + "I already have an account" on page 3.
  Widget _buildButtons() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      alignment: Alignment.bottomCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _isLast
            ? Column(
                key: const ValueKey('auth-buttons'),
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: widget.onCreateAccount,
                      child: const Text('Create account'),
                    ),
                  ),
                  const SizedBox(height: AppDimens.md),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: widget.onLogin,
                      child: const Text('I already have an account'),
                    ),
                  ),
                ],
              )
            : SizedBox(
                key: const ValueKey('next'),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Next'),
                      SizedBox(width: AppDimens.sm),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

/// Picture on top, then the two-line title and the paragraph.
class _PageContent extends StatelessWidget {
  const _PageContent({required this.page});

  final _OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppDimens.xl),
        // The picture takes whatever height is left and shrinks on small phones.
        Expanded(child: Center(child: page.illustration)),
        const SizedBox(height: AppDimens.sm),
        Text.rich(
          TextSpan(
            text: '${page.title}\n',
            children: [
              TextSpan(
                text: page.titleAccent,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          style: text.displaySmall,
        ),
        const SizedBox(height: AppDimens.lg),
        Text(
          page.body,
          style: text.bodyLarge?.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }
}
