import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class JobsManagementScreen extends StatefulWidget {
  final VoidCallback onPost;
  final VoidCallback onPipeline;
  const JobsManagementScreen({super.key, required this.onPost, required this.onPipeline});

  @override
  State<JobsManagementScreen> createState() => _JobsManagementScreenState();
}

class _JobsManagementScreenState extends State<JobsManagementScreen> {
  String _tab = 'activa';

  @override
  Widget build(BuildContext context) {
    final list = companyJobs.where((j) => j.status == _tab).toList();
    final tabs = const [('activa', 'Activas'), ('rascunho', 'Rascunhos'), ('fechada', 'Fechadas')];
    return Column(
      children: [
        LuTopBar(
          title: 'Vagas',
          large: true,
          actions: [LuIconBtn(icon: Icons.add, onPressed: widget.onPost, bg: LinkUpColors.navy, color: Colors.white)],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Row(
            children: [
              for (final t in tabs) ...[
                _tabBtn(t.$1, t.$2),
                const SizedBox(width: 6),
              ],
            ],
          ),
        ),
        Expanded(
          child: list.isEmpty
              ? const Center(child: Text('Nenhuma vaga.', style: TextStyle(color: LinkUpColors.textMuted)))
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final j = list[i];
                    return LuCard(
                      onTap: widget.onPipeline,
                      padding: const EdgeInsets.all(14),
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
                                    Text(j.title, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, height: 1.25, letterSpacing: -0.3)),
                                    const SizedBox(height: 4),
                                    Text('publicado ${j.posted}', style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
                                  ],
                                ),
                              ),
                              LuPill(j.status, color: _statusColor(j.status), size: PillSize.sm),
                            ],
                          ),
                          const LuDivider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LuStat(n: '${j.proposals}', label: 'propostas'),
                              LuStat(n: '${j.shortlist}', label: 'shortlist'),
                              LuStat(n: '${j.views}', label: 'visualizações'),
                              const Icon(Icons.more_horiz, size: 18, color: LinkUpColors.textMuted),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _tabBtn(String key, String label) {
    final on = _tab == key;
    return GestureDetector(
      onTap: () => setState(() => _tab = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: on ? LinkUpColors.navy : Colors.white,
          border: Border.all(color: on ? LinkUpColors.navy : LinkUpColors.border),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            Text(label, style: TextStyle(color: on ? Colors.white : LinkUpColors.textPrimary, fontSize: 12.5, fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            Text('${companyJobs.where((j) => j.status == key).length}',
              style: TextStyle(color: (on ? Colors.white : LinkUpColors.textPrimary).withValues(alpha: 0.6), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  PillColor _statusColor(String s) => switch (s) {
        'activa' => PillColor.green,
        'fechada' => PillColor.neutral,
        _ => PillColor.gold,
      };
}
