import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final u = currentFreelancer;
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Avaliações recebidas',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LuCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${u.rating}', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w800, letterSpacing: -1.2, color: LinkUpColors.navy, height: 1)),
                              LuStars(value: u.rating, size: 13),
                              const SizedBox(height: 3),
                              Text('${u.reviews} reviews', style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted)),
                            ],
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              children: [
                                _bar(5, 88, 76),
                                _bar(4, 9, 8),
                                _bar(3, 2, 2),
                                _bar(2, 1, 1),
                                _bar(1, 1, 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (final r in reviews) Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: LuCard(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LuAvatar(initials: r.avatar, bg: r.bg, size: 38),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(r.from, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                                      LuStars(value: r.rating.toDouble(), size: 11),
                                    ],
                                  ),
                                  const SizedBox(height: 1),
                                  Text('${r.company} · ${r.project}', style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted)),
                                  const SizedBox(height: 8),
                                  Text(r.text, style: const TextStyle(fontSize: 13, height: 1.5, color: LinkUpColors.textSecondary)),
                                  const SizedBox(height: 8),
                                  Text(r.date, style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
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

  Widget _bar(int n, double pct, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(width: 10, child: Text('$n', style: const TextStyle(color: LinkUpColors.textSecondary, fontWeight: FontWeight.w700, fontSize: 11))),
          const SizedBox(width: 8),
          Expanded(child: LuProgressBar(value: pct, color: LinkUpColors.gold, height: 6)),
          const SizedBox(width: 8),
          SizedBox(
            width: 28, child: Text('$count', textAlign: TextAlign.right, style: GoogleFonts.jetBrainsMono(color: LinkUpColors.textMuted, fontSize: 10)),
          ),
        ],
      ),
    );
  }
}
