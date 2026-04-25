import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class WalletHistoryScreen extends StatefulWidget {
  const WalletHistoryScreen({super.key});

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen> {
  String _tab = 'levantamentos';

  String _format(int v) {
    final s = v.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  @override
  Widget build(BuildContext context) {
    final totalLevantado = withdrawalHistory.fold<int>(0, (s, w) => s + w.amount);
    final totalRecebido = payments.where((p) => p.status == 'recebido').fold<int>(0, (s, p) => s + p.amount);
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Histórico',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: [LuIconBtn(icon: Icons.tune_rounded, onPressed: () => _showFilters())],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [LinkUpColors.navy, LinkUpColors.navyDark]),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Recebido', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.88)),
                          const SizedBox(height: 4),
                          Text('${_format(totalRecebido)}', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                          const Text('MZN', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 50, color: Colors.white24),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Levantado', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.88)),
                          const SizedBox(height: 4),
                          Text('${_format(totalLevantado)}', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                          const Text('MZN', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: LinkUpColors.border, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    _segBtn('levantamentos', 'Levantamentos'),
                    _segBtn('transacoes', 'Transações'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _tab == 'levantamentos' ? _withdrawalList() : _transactionList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _segBtn(String key, String label) {
    final on = _tab == key;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tab = key),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: on ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(
            child: Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: on ? LinkUpColors.green : LinkUpColors.textSecondary)),
          ),
        ),
      ),
    );
  }

  Widget _withdrawalList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      itemCount: withdrawalHistory.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final w = withdrawalHistory[i];
        return LuCard(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(color: LinkUpColors.pillGreenBg, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.south_rounded, size: 18, color: LinkUpColors.green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(w.method, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text('${w.date} · taxa ${w.fee == 0 ? "0" : w.fee.toString()} MZN',
                      style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${_format(w.amount)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: LinkUpColors.navy, letterSpacing: -0.3)),
                  const SizedBox(height: 2),
                  const LuPill('concluído', color: PillColor.success, size: PillSize.sm),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _transactionList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      itemCount: payments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final p = payments[i];
        final colors = switch (p.status) {
          'recebido' => (bg: LinkUpColors.successBg, fg: LinkUpColors.successFg),
          'em-escrow' => (bg: LinkUpColors.cream, fg: LinkUpColors.goldDark),
          _ => (bg: LinkUpColors.pillNeutralBg, fg: LinkUpColors.textSecondary),
        };
        return LuCard(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(color: LinkUpColors.surfaceTint, borderRadius: BorderRadius.circular(10)),
                child: Icon(p.status == 'recebido' ? Icons.arrow_outward : Icons.schedule_rounded, size: 16, color: colors.fg),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.desc, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, height: 1.3)),
                    const SizedBox(height: 2),
                    Text('${p.date} · ${p.method}', style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('+${(p.amount / 1000).toStringAsFixed(0)}k', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: LinkUpColors.navy, letterSpacing: -0.3)),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: colors.bg, borderRadius: BorderRadius.circular(999)),
                    child: Text(p.status.replaceAll('-', ' '), style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: colors.fg)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilters() {
    LuBottomSheet.show(context, title: 'Filtrar histórico', actions: [
      LuBottomSheetAction(icon: Icons.calendar_today_outlined, label: 'Por mês', sub: 'Abril 2026', onTap: () {}),
      LuBottomSheetAction(icon: Icons.flag_outlined, label: 'Por estado', sub: 'Todos', onTap: () {}),
      LuBottomSheetAction(icon: Icons.payment_outlined, label: 'Por método', sub: 'Todos', onTap: () {}),
    ]);
  }
}
