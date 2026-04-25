import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';
import 'freelancer_detail_screen.dart';
import '../freelancer/chat_screen.dart';

class PipelineScreen extends StatefulWidget {
  const PipelineScreen({super.key});

  @override
  State<PipelineScreen> createState() => _PipelineScreenState();
}

class _PipelineScreenState extends State<PipelineScreen> {
  String _col = 'novos';
  bool _kanban = false;
  late Map<String, List<CandidateData>> _pipeline;

  static const _cols = [
    ('novos', 'Novos', LinkUpColors.navy),
    ('shortlist', 'Shortlist', LinkUpColors.green),
    ('entrevista', 'Entrevista', LinkUpColors.gold),
    ('oferta', 'Oferta', LinkUpColors.goldDark),
  ];

  @override
  void initState() {
    super.initState();
    _pipeline = {
      for (final entry in candidatesPipeline.entries)
        entry.key: List<CandidateData>.from(entry.value),
    };
  }

  void _advance(CandidateData c) {
    final idx = _cols.indexWhere((col) => col.$1 == _col);
    if (idx >= _cols.length - 1) {
      luSnack(context, '${c.name} já está na fase final.');
      return;
    }
    final nextKey = _cols[idx + 1].$1;
    setState(() {
      _pipeline[_col]!.removeWhere((x) => x.id == c.id);
      _pipeline[nextKey]!.add(c);
    });
    luSnack(context, '${c.name} movido para ${_cols[idx + 1].$2}.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Pipeline',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: [
                LuIconBtn(
                  icon: _kanban ? Icons.view_agenda_outlined : Icons.view_kanban_outlined,
                  onPressed: () => setState(() => _kanban = !_kanban),
                ),
              ],
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
            if (!_kanban) Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: SizedBox(
                height: 32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final c in _cols) Padding(
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
                              Text('${(_pipeline[c.$1] ?? const []).length}',
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
            Expanded(child: _kanban ? _kanbanBody() : _listBody()),
          ],
        ),
      ),
    );
  }

  Widget _listBody() {
    final list = _pipeline[_col] ?? const <CandidateData>[];
    if (list.isEmpty) {
      return const Center(child: Text('Nenhum candidato nesta etapa.', style: TextStyle(color: LinkUpColors.textMuted, fontSize: 13)));
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) => _candidateCard(list[i]),
    );
  }

  Widget _kanbanBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final c in _cols) Container(
            width: 280,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: LinkUpColors.border)),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 6, height: 6, decoration: BoxDecoration(color: c.$3, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text(c.$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: LinkUpColors.navy, letterSpacing: -0.3)),
                    const SizedBox(width: 6),
                    Text('${(_pipeline[c.$1] ?? const []).length}', style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 12),
                if ((_pipeline[c.$1] ?? const []).isEmpty)
                  Container(
                    height: 80, alignment: Alignment.center,
                    decoration: BoxDecoration(color: LinkUpColors.surfaceTint, borderRadius: BorderRadius.circular(10), border: Border.all(color: LinkUpColors.border, style: BorderStyle.solid)),
                    child: const Text('Vazio', style: TextStyle(color: LinkUpColors.textMuted, fontSize: 11.5)),
                  )
                else
                  for (final cd in _pipeline[c.$1]!) Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => FreelancerDetailScreen(freelancerId: cd.id.replaceFirst('cd', 'f')),
                      )),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: LinkUpColors.surfaceTint, borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            LuAvatar(initials: cd.avatar, bg: cd.bg, size: 32),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cd.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                                  Text(cd.bid, style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
                                ],
                              ),
                            ),
                            LuPill('${cd.match}%', color: PillColor.green, size: PillSize.sm),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _candidateCard(CandidateData c) {
    return LuCard(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => FreelancerDetailScreen(freelancerId: c.id.replaceFirst('cd', 'f')),
      )),
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
                    LuBtn('Mensagem', variant: BtnVariant.secondary, size: BtnSize.sm, icon: Icons.chat_bubble_outline,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen(chatId: 'ch1')))),
                    const SizedBox(width: 6),
                    LuBtn('Avançar', variant: BtnVariant.navy, size: BtnSize.sm, icon: Icons.arrow_forward_rounded,
                      onPressed: () => _advance(c)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
