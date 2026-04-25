import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';

class CompanyOnboardingScreen extends StatelessWidget {
  final VoidCallback onLogin;
  const CompanyOnboardingScreen({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    final benefits = [
      (icon: Icons.auto_awesome, title: 'Match score por IA', sub: 'Recomendamos os melhores candidatos'),
      (icon: Icons.shield_outlined, title: 'Pagamento em escrow', sub: 'Liberta fundos por milestone'),
      (icon: Icons.verified, title: 'Selo Ubuntu', sub: 'A tua empresa em destaque'),
    ];
    return Container(
      color: LinkUpColors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          children: [
            Row(
              children: const [
                LuLogoMark(background: LinkUpColors.navy),
                SizedBox(width: 8),
                LuWordmark(),
                SizedBox(width: 6),
                LuPill('empresa', color: PillColor.navy, size: PillSize.sm),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: LinkUpColors.navy,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.business_rounded, size: 86, color: LinkUpColors.gold),
            ),
            const SizedBox(height: 26),
            const Align(
              alignment: Alignment.centerLeft,
              child: LuPill('Para empresas', color: PillColor.gold),
            ),
            const SizedBox(height: 14),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Encontra talento\nverificado em horas.',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, height: 1.05, letterSpacing: -0.85, color: LinkUpColors.navy),
              ),
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Acede a uma rede de freelancers em Moçambique. Pré-selecciona, conversa e contrata — tudo no LinkUp.',
                style: TextStyle(fontSize: 15, color: LinkUpColors.textSecondary, height: 1.5),
              ),
            ),
            const SizedBox(height: 20),
            for (final b in benefits) Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: LinkUpColors.border)),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: LinkUpColors.pillGreenBg, borderRadius: BorderRadius.circular(10)),
                      child: Icon(b.icon, size: 17, color: LinkUpColors.green),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(b.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 1),
                          Text(b.sub, style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            LuBtn('Registar a minha empresa', variant: BtnVariant.navy, full: true, size: BtnSize.lg, onPressed: onLogin),
            const SizedBox(height: 10),
            LuBtn('Já temos conta', variant: BtnVariant.secondary, full: true, size: BtnSize.lg, onPressed: onLogin),
          ],
        ),
      ),
    );
  }
}
