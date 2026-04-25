import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _push = true;
  bool _email = true;
  bool _available = true;
  bool _twoFA = true;
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
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
                      _row(Icons.person_outline, 'Editar perfil'),
                      _row(Icons.shield_outlined, 'Verificação Ubuntu',
                          right: const LuPill('verificado', color: PillColor.gold, size: PillSize.sm, icon: Icons.verified)),
                      _row(Icons.lock_outline, 'Palavra-passe e segurança'),
                    ]),
                    _group('Disponibilidade', [
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
                            LuToggleRow(label: 'Modo escuro', value: _dark, onChanged: (v) => setState(() => _dark = v)),
                          ],
                        ),
                      ),
                    ]),
                    _group('Preferências', [
                      _row(Icons.language, 'Idioma', right: const Text('Português ›', style: TextStyle(fontSize: 12, color: LinkUpColors.textMuted))),
                      _row(Icons.account_balance_wallet_outlined, 'Moeda', right: const Text('MZN ›', style: TextStyle(fontSize: 12, color: LinkUpColors.textMuted))),
                    ]),
                    _group('Sobre', [
                      _row(Icons.shield_outlined, 'Termos & condições'),
                      _row(Icons.chat_bubble_outline, 'Suporte LinkUp'),
                    ]),
                    const SizedBox(height: 20),
                    LuBtn('Terminar sessão', variant: BtnVariant.danger, full: true, icon: Icons.logout, onPressed: () {}),
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

  Widget _row(IconData icon, String label, {Widget? right}) {
    return Container(
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
          right ?? const Icon(Icons.chevron_right, size: 16, color: LinkUpColors.textMuted),
        ],
      ),
    );
  }
}
