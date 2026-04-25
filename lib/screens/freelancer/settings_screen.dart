import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../shell.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'language_currency_screens.dart';
import 'support_screen.dart';
import 'terms_screen.dart';
import 'ubuntu_verification_screen.dart';
import '../company/team_screen.dart';
import '../company/company_profile_edit_screen.dart';

class SettingsScreen extends StatefulWidget {
  /// `role` controls which "Conta" rows make sense (e.g. team management for company).
  final LinkUpRole role;
  const SettingsScreen({super.key, this.role = LinkUpRole.freelancer});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _push = true;
  bool _email = true;
  bool _available = true;
  bool _twoFA = true;
  bool _dark = false;

  void _push2(Widget page) => Navigator.push(context, MaterialPageRoute(builder: (_) => page));

  Future<void> _logout() async {
    final ok = await LuConfirmDialog.show(context,
      title: 'Terminar sessão?',
      message: 'Vais voltar ao ecrã de boas-vindas. Os teus dados continuam guardados.',
      confirmLabel: 'Sair', destructive: true,
    );
    if (!ok || !mounted) return;
    Navigator.of(context).popUntil((r) => r.isFirst);
    LinkUpAuth.instance.signOut(widget.role);
  }

  Future<void> _switchRole() async {
    final isCompany = widget.role == LinkUpRole.company;
    final otherLabel = isCompany ? 'Freelancer' : 'Empresa';
    final ok = await LuConfirmDialog.show(context,
      title: 'Trocar para $otherLabel?',
      message: 'A tua sessão actual será terminada e vais entrar no fluxo de $otherLabel. Podes voltar mais tarde.',
      confirmLabel: 'Trocar',
    );
    if (!ok || !mounted) return;
    LinkUpAuth.instance.switchToOtherRole(context);
  }

  @override
  Widget build(BuildContext context) {
    final isCompany = widget.role == LinkUpRole.company;
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Configurações',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                child: Column(
                  children: [
                    _group('Conta', [
                      _row(Icons.person_outline, isCompany ? 'Editar perfil da empresa' : 'Editar perfil',
                        onTap: () => _push2(isCompany ? const CompanyProfileEditScreen() : const EditProfileScreen()),
                      ),
                      _row(Icons.shield_outlined, 'Verificação Ubuntu',
                        right: const LuPill('verificada', color: PillColor.gold, size: PillSize.sm, icon: Icons.verified),
                        onTap: () => _push2(const UbuntuVerificationScreen()),
                      ),
                      if (isCompany)
                        _row(Icons.group_outlined, 'Equipa & permissões',
                          right: const LuPill('4 membros', color: PillColor.navy, size: PillSize.sm),
                          onTap: () => _push2(const TeamScreen()),
                        ),
                      _row(Icons.lock_outline, 'Palavra-passe e segurança', onTap: () => _push2(const ChangePasswordScreen())),
                    ]),
                    if (!isCompany) _group('Disponibilidade', [
                      LuCard(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: LuToggleRow(
                          label: 'Disponível para trabalhar',
                          sub: 'Aparece no topo da pesquisa',
                          value: _available,
                          onChanged: (v) => setState(() => _available = v),
                        ),
                      ),
                    ]),
                    _group('Notificações', [
                      LuCard(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          children: [
                            LuToggleRow(label: 'Notificações push', value: _push, onChanged: (v) => setState(() => _push = v)),
                            const LuDivider(margin: 0),
                            LuToggleRow(label: 'Email', sub: 'Resumo diário e alertas', value: _email, onChanged: (v) => setState(() => _email = v)),
                          ],
                        ),
                      ),
                    ]),
                    _group('Privacidade & Segurança', [
                      LuCard(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          children: [
                            LuToggleRow(label: 'Autenticação em 2 passos', sub: 'Recomendado', value: _twoFA, onChanged: (v) => setState(() => _twoFA = v)),
                            const LuDivider(margin: 0),
                            LuToggleRow(label: 'Modo escuro', sub: 'Em breve', value: _dark, onChanged: (v) {
                              setState(() => _dark = v);
                              luSnack(context, 'Modo escuro brevemente disponível.');
                            }),
                          ],
                        ),
                      ),
                    ]),
                    _group('Preferências', [
                      _row(Icons.language, 'Idioma',
                        right: const Text('Português ›', style: TextStyle(fontSize: 12, color: LinkUpColors.textMuted)),
                        onTap: () => _push2(const LanguageScreen()),
                      ),
                      _row(Icons.account_balance_wallet_outlined, 'Moeda',
                        right: const Text('MZN ›', style: TextStyle(fontSize: 12, color: LinkUpColors.textMuted)),
                        onTap: () => _push2(const CurrencyScreen()),
                      ),
                    ]),
                    _group('Sobre', [
                      _row(Icons.shield_outlined, 'Termos & condições', onTap: () => _push2(const TermsScreen())),
                      _row(Icons.chat_bubble_outline, 'Suporte LinkUp', onTap: () => _push2(const SupportScreen())),
                    ]),
                    _group('Mudar de papel', [
                      _row(
                        isCompany ? Icons.person_outline_rounded : Icons.business_rounded,
                        isCompany ? 'Trocar para Freelancer' : 'Trocar para Empresa',
                        right: const Icon(Icons.swap_horiz_rounded, size: 18, color: LinkUpColors.textMuted),
                        onTap: _switchRole,
                      ),
                    ]),
                    const SizedBox(height: 20),
                    LuBtn('Terminar sessão', variant: BtnVariant.danger, full: true, icon: Icons.logout, onPressed: _logout),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text('LinkUp v2.4 · Powered by Ubuntu Consulting Group',
                        style: TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _group(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(title.toUpperCase(),
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: LinkUpColors.textMuted, letterSpacing: 1.1),
            ),
          ),
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1) const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }

  Widget _row(IconData icon, String label, {Widget? right, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(color: LinkUpColors.surfaceTint, borderRadius: BorderRadius.circular(9)),
              child: Icon(icon, size: 16, color: LinkUpColors.green),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600))),
            if (right != null) ...[right, const SizedBox(width: 6)],
            const Icon(Icons.chevron_right, size: 16, color: LinkUpColors.textMuted),
          ],
        ),
      ),
    );
  }
}
