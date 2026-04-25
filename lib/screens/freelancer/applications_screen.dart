import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class ApplicationsScreen extends StatefulWidget {
  final void Function(String) onJob;
  const ApplicationsScreen({super.key, required this.onJob});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  String _tab = 'todas';

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ('todas', 'Todas', applications.length),
      ('shortlisted', 'Pré-selecção', applications.where((a) => a.status == 'shortlisted').length),
      ('em-revisao', 'Em revisão', applications.where((a) => a.status == 'em-revisao').length),
      ('aceite', 'Aceites', applications.where((a) => a.status == 'aceite').length),
    ];
    final list = _tab == 'todas' ? applications : applications.where((a) => a.status == _tab).toList();
    return Column(
      children: [
        const LuTopBar(title: 'Candidaturas', large: true),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (_, i) {
                final t = tabs[i];
                final on = _tab == t.$1;
                return GestureDetector(
                  onTap: () => setState(() => _tab = t.$1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: on ? LinkUpColors.green : Colors.white,
                      border: Border.all(color: on ? LinkUpColors.green : LinkUpColors.border),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      children: [
                        Text(t.$2, style: TextStyle(color: on ? Colors.white : LinkUpColors.textPrimary, fontSize: 12.5, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 4),
                        Text('${t.$3}', style: TextStyle(color: (on ? Colors.white : LinkUpColors.textPrimary).withValues(alpha: 0.6), fontSize: 11)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final a = list[i];
              final s = statusLabels[a.status]!;
              return LuCard(
                onTap: () => widget.onJob(a.jobId),
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LuAvatar(initials: a.companyAvatar, bg: a.companyBg, size: 44),
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
                                    Text(a.company, style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 2),
                                    Text(a.jobTitle, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, letterSpacing: -0.3, height: 1.25)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                                decoration: BoxDecoration(color: s.bg, borderRadius: BorderRadius.circular(999)),
                                child: Text(s.label, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: s.fg)),
                              ),
                            ],
                          ),
                          const LuDivider(margin: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  style: const TextStyle(fontSize: 11.5),
                                  children: [
                                    const TextSpan(text: 'Proposta: ', style: TextStyle(color: LinkUpColors.textMuted)),
                                    TextSpan(text: a.bid, style: const TextStyle(fontWeight: FontWeight.w700, color: LinkUpColors.navy)),
                                  ],
                                ),
                              ),
                              Text(a.appliedAt, style: const TextStyle(color: LinkUpColors.textMuted, fontSize: 11.5)),
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
    );
  }
}
