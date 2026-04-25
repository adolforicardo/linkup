import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';

class CompanyNotificationsScreen extends StatelessWidget {
  const CompanyNotificationsScreen({super.key});

  static const _items = [
    (t: 'Nova proposta recebida', d: 'Aida Macuácua candidatou-se a Mobile banking redesign', i: '📥', u: true, time: 'há 8 min'),
    (t: '5 propostas novas', d: 'Frontend internet banking · 23 ao todo', i: '🎯', u: true, time: 'há 1 h'),
    (t: 'Délcio passou para entrevista', d: 'Pipeline · Frontend dev', i: '⭐', u: true, time: 'há 3 h'),
    (t: 'Milestone validado', d: 'Mobile banking · Sprint 2 concluído', i: '✓', u: true, time: 'há 5 h'),
    (t: 'Pagamento processado', d: 'Eunice Cossa · 45.000 MZN', i: '💰', u: false, time: 'ontem'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Notificações',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Text('Limpar', style: TextStyle(color: LinkUpColors.navy, fontWeight: FontWeight.w700, fontSize: 13)),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: _items.length,
                itemBuilder: (_, i) {
                  final n = _items[i];
                  return Container(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                    decoration: BoxDecoration(
                      color: n.u ? LinkUpColors.surfaceTint : Colors.transparent,
                      border: const Border(bottom: BorderSide(color: LinkUpColors.border)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (n.u) Container(
                          width: 6, height: 6, margin: const EdgeInsets.only(top: 8, right: 8),
                          decoration: const BoxDecoration(color: LinkUpColors.navy, shape: BoxShape.circle),
                        ),
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(color: LinkUpColors.pillNavyBg, borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          child: Text(n.i, style: const TextStyle(fontSize: 18)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(n.t, style: TextStyle(fontSize: 13.5, fontWeight: n.u ? FontWeight.w700 : FontWeight.w600, height: 1.3)),
                              const SizedBox(height: 2),
                              Text(n.d, style: const TextStyle(fontSize: 12, color: LinkUpColors.textSecondary)),
                              const SizedBox(height: 4),
                              Text(n.time, style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
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
