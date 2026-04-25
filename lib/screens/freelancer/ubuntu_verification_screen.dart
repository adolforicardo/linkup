import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';

class UbuntuVerificationScreen extends StatelessWidget {
  const UbuntuVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      (icon: Icons.shield_outlined, title: 'NUIT validado', sub: 'Confirmado a 12 Mar 2026', done: true),
      (icon: Icons.badge_outlined, title: 'Documento de identidade', sub: 'BI/Passaporte verificado', done: true),
      (icon: Icons.videocam_outlined, title: 'Vídeo de verificação', sub: 'Confirma que és quem dizes ser · 30s', done: true),
      (icon: Icons.history_rounded, title: '5+ projectos concluídos', sub: '41 projectos · 4.9★ médio', done: true),
    ];
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Verificação Ubuntu',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [LinkUpColors.gold, LinkUpColors.goldDark]),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 56, height: 56,
                                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), shape: BoxShape.circle),
                                child: const Icon(Icons.verified, size: 32, color: Colors.white),
                              ),
                              const SizedBox(width: 14),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Estás verificada',
                                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                                    ),
                                    SizedBox(height: 2),
                                    Text('Selo Ubuntu activo · renovado em Jan 2026',
                                      style: TextStyle(color: Color(0xFFFAF7F1), fontSize: 12.5, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                            child: const Text(
                              'Empresas vêem o teu selo no perfil. Recebes em média 3× mais convites do que perfis não verificados.',
                              style: TextStyle(color: Colors.white, fontSize: 12.5, height: 1.45),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const LuSectionTitle('Critérios cumpridos'),
                    for (int i = 0; i < steps.length; i++) Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: LuCard(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(color: LinkUpColors.pillGreenBg, borderRadius: BorderRadius.circular(11)),
                              child: Icon(steps[i].icon, size: 20, color: LinkUpColors.green),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(steps[i].title, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 2),
                                  Text(steps[i].sub, style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                                ],
                              ),
                            ),
                            const Icon(Icons.check_circle_rounded, size: 22, color: LinkUpColors.green),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: LinkUpColors.pillNavyBg, borderRadius: BorderRadius.circular(14)),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline, size: 18, color: LinkUpColors.navy),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'A verificação é renovada automaticamente a cada 6 meses se mantiveres avaliação ≥ 4.5.',
                              style: TextStyle(fontSize: 12, color: LinkUpColors.navy, fontWeight: FontWeight.w600, height: 1.45),
                            ),
                          ),
                        ],
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
}
