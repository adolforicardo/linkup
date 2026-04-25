import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../shell.dart';

/// Shared scaffold for auth screens — header with logo + role chip + back button.
class AuthScaffold extends StatelessWidget {
  final LinkUpRole role;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onBack;
  final bool showBack;
  final bool showLogo;

  const AuthScaffold({
    super.key,
    required this.role,
    required this.child,
    this.subtitle,
    this.onBack,
    this.showBack = true,
    this.showLogo = true,
  });

  Color get accent => role == LinkUpRole.freelancer ? LinkUpColors.green : LinkUpColors.navy;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LinkUpColors.background,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  if (showBack)
                    LuIconBtn(
                      icon: Icons.chevron_left,
                      onPressed: onBack ?? () => Navigator.maybePop(context),
                    )
                  else
                    const SizedBox(width: 38),
                  const Spacer(),
                  if (showLogo) ...[
                    LuLogoMark(background: accent, size: 28),
                    const SizedBox(width: 6),
                    const LuWordmark(fontSize: 15),
                  ],
                  const Spacer(),
                  const SizedBox(width: 38),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: LuPill(
                  role == LinkUpRole.freelancer ? 'Freelancer' : 'Empresa',
                  color: role == LinkUpRole.freelancer ? PillColor.green : PillColor.navy,
                  size: PillSize.sm,
                ),
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
