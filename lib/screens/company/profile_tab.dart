import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class CompanyProfileTab extends StatelessWidget {
  final VoidCallback onContracts;
  final VoidCallback onRate;
  final VoidCallback onSettings;
  const CompanyProfileTab({super.key, required this.onContracts, required this.onRate, required this.onSettings});

  @override
  Widget build(BuildContext context) {
    final c = currentCompany;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Row(
              children: [
                const Text('EMPRESA', style: TextStyle(fontSize: 12, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600, letterSpacing: 0.96)),
                const Spacer(),
                LuIconBtn(icon: Icons.settings_outlined, onPressed: onSettings),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: [LinkUpColors.navy, LinkUpColors.navyDark],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      LuAvatar(initials: c.avatar, bg: LinkUpColors.navyDark, size: 66, ring: true),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(child: Text(c.name, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.4))),
                                const SizedBox(width: 6),
                                const Icon(Icons.verified, size: 15, color: LinkUpColors.gold),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text('${c.industry} · Maputo', style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                            const SizedBox(height: 6),
                            const LuPill('Verificada Ubuntu', color: PillColor.gold, size: PillSize.sm, icon: Icons.verified),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _stat('${c.openRoles}', 'Vagas'),
                      const SizedBox(width: 6),
                      _stat('${c.hiresTotal}', 'Contratações'),
                      const SizedBox(width: 6),
                      _stat('${c.rating}', 'Avaliação'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                _row(Icons.work_outline, 'Contratos & faturação', right: const LuPill('2 activos', color: PillColor.green, size: PillSize.sm), onTap: onContracts),
                const SizedBox(height: 6),
                _row(Icons.account_balance_wallet_outlined, 'Pagamentos & escrow', onTap: onContracts),
                const SizedBox(height: 6),
                _row(Icons.star_outline_rounded, 'Avaliar freelancer', onTap: onRate),
                const SizedBox(height: 6),
                _row(Icons.group_outlined, 'Equipa & permissões'),
                const SizedBox(height: 6),
                _row(Icons.business_rounded, 'Editar perfil da empresa'),
                const SizedBox(height: 6),
                _row(Icons.shield_outlined, 'Verificação Ubuntu', right: const LuPill('activa', color: PillColor.gold, size: PillSize.sm)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String v, String l) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Text(v, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text(l, style: const TextStyle(color: Colors.white70, fontSize: 9.5, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );

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
