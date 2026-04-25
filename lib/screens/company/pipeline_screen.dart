import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class PipelineScreen extends StatefulWidget {
  const PipelineScreen({super.key});

  @override
  State<PipelineScreen> createState() => _PipelineScreenState();
}

class _PipelineScreenState extends State<PipelineScreen> {
  String _col = 'novos';

  @override
  Widget build(BuildContext context) {
    final cols = [
      ('novos', 'Novos', LinkUpColors.navy),
      ('shortlist', 'Shortlist', LinkUpColors.green),
      ('entrevista', 'Entrevista', LinkUpColors.gold),
      ('oferta', 'Oferta', LinkUpColors.goldDark),
    ];
    final list = candidatesPipeline[_col] ?? const <CandidateData>[];
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Pipeline',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: [LuIconBtn(icon: Icons.view_kanban_outlined, onPressed: () {})],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 6),
              child: LuCard(
                padding: const EdgeInsets.all(12),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('VAGA', style: TextStyle(fontSize: 11, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
                    SizedBox(height: 2),
                    Text('Redesenhar app de mobile banking', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: SizedBox(
                height: 32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final c in cols) Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: GestureDetector(
                        onTap: () => setState(() => _col = c.$1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: _col == c.$1 ? c.$3 : Colors.white,
                            border: Border.all(color: _col == c.$1 ? c.$3 : LinkUpColors.border),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            children: [
                              Text(c.$2, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _col == c.$1 ? Colors.white : LinkUpColors.textPrimary)),
                              const SizedBox(width: 5),
                              Text('${(candidatesPipeline[c.$1] ?? const []).length}',
                                style: TextStyle(fontSize: 12, color: (_col == c.$1 ? Colors.white : LinkUpColors.textPrimary).withValues(alpha: 0.7)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: list.isEmpty
                  ? const Center(child: Text('Nenhum candidato nesta etapa.', style: TextStyle(color: LinkUpColors.textMuted, fontSize: 13)))
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) {
                        final c = list[i];
                        return LuCard(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LuAvatar(initials: c.avatar, bg: c.bg, size: 44),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(c.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                                        LuPill('${c.match}%', color: PillColor.green, size: PillSize.sm),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text.rich(
                                      TextSpan(
                                        style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted),
                                        children: [
                                          const TextSpan(text: 'Proposta: '),
                                          TextSpan(text: c.bid, style: const TextStyle(fontWeight: FontWeight.w700, color: LinkUpColors.navy)),
                                          TextSpan(text: ' · ${c.appliedAt}'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        LuBtn('Mensagem', variant: BtnVariant.secondary, size: BtnSize.sm, icon: Icons.chat_bubble_outline, onPressed: () {}),
                                        const SizedBox(width: 6),
                                        LuBtn('Avançar', variant: BtnVariant.navy, size: BtnSize.sm, icon: Icons.arrow_forward_rounded, onPressed: () {}),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
