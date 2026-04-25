import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets.dart';
import 'screens/freelancer/freelancer_shell.dart';
import 'screens/freelancer/onboarding_screen.dart';
import 'screens/company/company_shell.dart';
import 'screens/company/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

enum LinkUpRole { freelancer, company }
enum AuthStage { onboarding, login, register, app }

/// Global auth controller — singleton with ValueNotifiers.
///
/// Lives outside the widget tree so any pushed route can read/mutate auth
/// state without needing an InheritedWidget ancestor (which routes pushed via
/// the root Navigator wouldn't have access to).
class LinkUpAuth {
  LinkUpAuth._();
  static final LinkUpAuth instance = LinkUpAuth._();

  final ValueNotifier<LinkUpRole> activeRole = ValueNotifier(LinkUpRole.freelancer);
  final ValueNotifier<Map<LinkUpRole, AuthStage>> _stages = ValueNotifier({
    LinkUpRole.freelancer: AuthStage.onboarding,
    LinkUpRole.company: AuthStage.onboarding,
  });

  ValueListenable<Map<LinkUpRole, AuthStage>> get stages => _stages;

  AuthStage stageOf(LinkUpRole role) => _stages.value[role]!;
  bool isAuthed(LinkUpRole role) => stageOf(role) == AuthStage.app;

  void setRole(LinkUpRole role) {
    activeRole.value = role;
  }

  void setStage(LinkUpRole role, AuthStage stage) {
    final next = Map<LinkUpRole, AuthStage>.from(_stages.value);
    next[role] = stage;
    _stages.value = next;
  }

  void signOut(LinkUpRole role) {
    setStage(role, AuthStage.onboarding);
  }

  /// Sign out the current role and switch to the other role's auth flow.
  /// Pops back to the app shell first so the swap is visible.
  void switchToOtherRole(BuildContext context) {
    final current = activeRole.value;
    final other = current == LinkUpRole.freelancer ? LinkUpRole.company : LinkUpRole.freelancer;
    Navigator.of(context).popUntil((r) => r.isFirst);
    signOut(current);
    setRole(other);
  }
}

class RoleSelector extends StatelessWidget {
  const RoleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LinkUpRole>(
      valueListenable: LinkUpAuth.instance.activeRole,
      builder: (context, role, _) {
        return ValueListenableBuilder<Map<LinkUpRole, AuthStage>>(
          valueListenable: LinkUpAuth.instance.stages,
          builder: (context, stages, _) {
            final stage = stages[role]!;
            final body = switch (stage) {
              AuthStage.onboarding => role == LinkUpRole.freelancer
                  ? OnboardingScreen(
                      onCreateAccount: () => LinkUpAuth.instance.setStage(role, AuthStage.register),
                      onSignIn: () => LinkUpAuth.instance.setStage(role, AuthStage.login),
                    )
                  : CompanyOnboardingScreen(
                      onCreateAccount: () => LinkUpAuth.instance.setStage(role, AuthStage.register),
                      onSignIn: () => LinkUpAuth.instance.setStage(role, AuthStage.login),
                    ),
              AuthStage.login => LoginScreen(
                  role: role,
                  onSuccess: () => LinkUpAuth.instance.setStage(role, AuthStage.app),
                  onBack: () => LinkUpAuth.instance.setStage(role, AuthStage.onboarding),
                ),
              AuthStage.register => RegisterScreen(
                  role: role,
                  onSuccess: () => LinkUpAuth.instance.setStage(role, AuthStage.app),
                  onBack: () => LinkUpAuth.instance.setStage(role, AuthStage.onboarding),
                ),
              AuthStage.app => role == LinkUpRole.freelancer ? const FreelancerShell() : const CompanyShell(),
            };
            return Scaffold(
              body: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    _buildHeader(role: role, stage: stage),
                    Expanded(child: ClipRect(child: body)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHeader({required LinkUpRole role, required AuthStage stage}) {
    final inApp = stage == AuthStage.app;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          const LuLogoMark(size: 28),
          const SizedBox(width: 8),
          const LuWordmark(fontSize: 16),
          const Spacer(),
          // Once the active role is signed in, hide the role-switcher entirely
          // — the user must sign out (Settings → Trocar para …) to swap.
          if (inApp)
            LuPill(
              role == LinkUpRole.freelancer ? 'Freelancer' : 'Empresa',
              color: role == LinkUpRole.freelancer ? PillColor.green : PillColor.navy,
              size: PillSize.sm,
              icon: role == LinkUpRole.freelancer ? Icons.person_outline_rounded : Icons.business_rounded,
            )
          else
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(color: LinkUpColors.border, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  _switchBtn('Freelancer', LinkUpRole.freelancer, role),
                  _switchBtn('Empresa', LinkUpRole.company, role),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _switchBtn(String label, LinkUpRole role, LinkUpRole active) {
    final isActive = active == role;
    return GestureDetector(
      onTap: () => LinkUpAuth.instance.setRole(role),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
            color: isActive ? LinkUpColors.navy : LinkUpColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
