import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets.dart';
import 'screens/freelancer/freelancer_shell.dart';
import 'screens/freelancer/onboarding_screen.dart';
import 'screens/company/company_shell.dart';
import 'screens/company/onboarding_screen.dart';

enum LinkUpRole { freelancer, company }

class RoleSelector extends StatefulWidget {
  const RoleSelector({super.key});
  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  LinkUpRole _role = LinkUpRole.freelancer;
  bool _showOnboarding = true;

  @override
  Widget build(BuildContext context) {
    final body = _showOnboarding
        ? (_role == LinkUpRole.freelancer
            ? OnboardingScreen(onLogin: () => setState(() => _showOnboarding = false))
            : CompanyOnboardingScreen(onLogin: () => setState(() => _showOnboarding = false)))
        : (_role == LinkUpRole.freelancer ? const FreelancerShell() : const CompanyShell());

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildRoleSwitch(),
            Expanded(
              child: ClipRect(child: body),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleSwitch() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          const LuLogoMark(size: 28),
          const SizedBox(width: 8),
          const LuWordmark(fontSize: 16),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: LinkUpColors.border,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _switchBtn('Freelancer', LinkUpRole.freelancer),
                _switchBtn('Empresa', LinkUpRole.company),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _switchBtn(String label, LinkUpRole role) {
    final active = _role == role;
    return GestureDetector(
      onTap: () => setState(() {
        _role = role;
        _showOnboarding = false;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: active ? FontWeight.w700 : FontWeight.w600,
            color: active ? LinkUpColors.navy : LinkUpColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
