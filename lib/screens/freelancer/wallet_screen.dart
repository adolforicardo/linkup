import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final total = payments.where((p) => p.status == 'recebido').fold<int>(0, (s, p) => s + p.amount);
    final pending = payments.where((p) => p.status != 'recebido').fold<int>(0, (s, p) => s + p.amount);
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Carteira',
              large: true,
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: [LuIconBtn(icon: Icons.download_rounded, onPressed: () {})],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft, end: Alignment.bottomRight,
                          colors: [LinkUpColors.navy, Color(0xFF0F2238)],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('TOTAL GANHO',
                                style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.1),
                              ),
                              LuPill('2026', color: PillColor.gold, size: PillSize.sm),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: _format(total),
                                  style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800, letterSpacing: -1.1)),
                                const TextSpan(text: ' MZN', style: TextStyle(color: Colors.white60, fontSize: 18, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Pendente / escrow', style: TextStyle(color: Colors.white70, fontSize: 10.5, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 2),
                                    Text('${_format(pending)} MZN', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Disponível p/ levantar', style: TextStyle(color: Colors.white70, fontSize: 10.5, fontWeight: FontWeight.w600)),
                                    SizedBox(height: 2),
                                    Text('128.000 MZN', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              LuBtn('Levantar', variant: BtnVariant.gold, size: BtnSize.sm, onPressed: () {}),
                              const SizedBox(width: 8),
                              LuBtn('Histórico', variant: BtnVariant.secondary, size: BtnSize.sm, onPressed: () {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const LuSectionTitle('Métodos de pagamento'),
                    LuCard(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 38, height: 38,
                            decoration: BoxDecoration(color: LinkUpColors.surfaceTint, borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: const Text('📱', style: TextStyle(fontSize: 18)),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(child: Text('M-Pesa · 84·····321', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                          const LuPill('principal', color: PillColor.green, size: PillSize.sm),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    LuCard(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 38, height: 38,
                            decoration: BoxDecoration(color: LinkUpColors.surfaceTint, borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: const Text('🏦', style: TextStyle(fontSize: 18)),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(child: Text('Banco Hércules · IBAN ····5482', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const LuSectionTitle('Transações'),
                    for (final p in payments) Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: LuCard(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(color: LinkUpColors.surfaceTint, borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: Icon(
                                p.status == 'recebido' ? Icons.arrow_outward : Icons.schedule_rounded,
                                size: 16,
                                color: _txColor(p.status).fg,
                              ),
                            ),
                            const SizedBox(width: 10),
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
                                  decoration: BoxDecoration(color: _txColor(p.status).bg, borderRadius: BorderRadius.circular(999)),
                                  child: Text(p.status.replaceAll('-', ' '),
                                    style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: _txColor(p.status).fg),
                                  ),
                                ),
                              ],
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

  ({Color bg, Color fg}) _txColor(String status) => switch (status) {
        'recebido' => (bg: LinkUpColors.successBg, fg: LinkUpColors.successFg),
        'em-escrow' => (bg: LinkUpColors.cream, fg: LinkUpColors.goldDark),
        _ => (bg: LinkUpColors.pillNeutralBg, fg: LinkUpColors.textSecondary),
      };

  String _format(int amount) {
    final s = amount.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}
