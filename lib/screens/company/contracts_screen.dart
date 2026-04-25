import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../widgets.dart';
import 'contract_detail_screen.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  static const _contracts = [
    (id: 'co1', title: 'Mobile banking redesign', f: 'Aida Macuácua', a: 'AM', bg: LinkUpColors.gold, amount: 320000, status: 'em-curso', progress: 45, due: '15 Mai'),
    (id: 'co2', title: 'Frontend internet banking', f: 'Délcio Nhantumbo', a: 'DN', bg: LinkUpColors.green, amount: 280000, status: 'em-curso', progress: 70, due: '08 Mai'),
    (id: 'co3', title: 'Tradução relatório anual', f: 'Eunice Cossa', a: 'EC', bg: LinkUpColors.greenDark, amount: 45000, status: 'concluido', progress: 100, due: '20 Abr'),
    (id: 'co4', title: 'Auditoria Q1 2026', f: 'Tomás Sitoe', a: 'TS', bg: LinkUpColors.gold, amount: 90000, status: 'pendente', progress: 0, due: '30 Abr'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Contratos',
              large: true,
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: [LuIconBtn(icon: Icons.download_rounded, onPressed: () => luSnack(context, 'Contratos exportados em PDF.'))],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LuCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('EM ESCROW', style: TextStyle(fontSize: 11, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600, letterSpacing: 0.88)),
                          const SizedBox(height: 4),
                          Text.rich(
                            TextSpan(children: [
                              const TextSpan(text: '415.000', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.7, color: LinkUpColors.navy)),
                              const TextSpan(text: ' MZN', style: TextStyle(fontSize: 14, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
                            ]),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              _kv('2', 'Activos'),
                              const SizedBox(width: 16),
                              _kv('1', 'Pendentes'),
                              const SizedBox(width: 16),
                              _kv('1', 'Concluídos'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (final c in _contracts) Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: LuCard(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (_) => ContractDetailScreen(
                            contractId: c.id,
                            title: c.title,
                            freelancer: c.f,
                            avatar: c.a,
                            avatarBg: c.bg,
                            amount: c.amount,
                            status: c.status,
                            due: c.due,
                          ),
                        )),
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LuAvatar(initials: c.a, bg: c.bg, size: 40),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(c.title, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, height: 1.3)),
                                            const SizedBox(height: 2),
                                            Text(c.f, style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                                          ],
                                        ),
                                      ),
                                      LuPill(
                                        c.status.replaceAll('-', ' '),
                                        color: switch (c.status) {
                                          'em-curso' => PillColor.green,
                                          'pendente' => PillColor.gold,
                                          _ => PillColor.neutral,
                                        },
                                        size: PillSize.sm,
                                      ),
                                    ],
                                  ),
                                  if (c.status != 'pendente') ...[
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Progresso', style: TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
                                        Text('${c.progress}%', style: GoogleFonts.jetBrainsMono(fontSize: 10.5, fontWeight: FontWeight.w700, color: LinkUpColors.green)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    LuProgressBar(value: c.progress.toDouble(), height: 4),
                                  ],
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${(c.amount / 1000).toStringAsFixed(0)}k MZN',
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: LinkUpColors.navy),
                                      ),
                                      Text('vence ${c.due}', style: const TextStyle(fontSize: 12, color: LinkUpColors.textMuted)),
                                    ],
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _kv(String v, String l) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l, style: const TextStyle(color: LinkUpColors.textMuted, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(v, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: LinkUpColors.navy)),
        ],
      );
}
