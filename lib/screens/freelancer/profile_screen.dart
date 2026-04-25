import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onPortfolio;
  final VoidCallback onReviews;
  final VoidCallback onSettings;
  final VoidCallback onWallet;

  const ProfileScreen({
    super.key,
    required this.onEdit,
    required this.onPortfolio,
    required this.onReviews,
    required this.onSettings,
    required this.onWallet,
  });

  static const _radarData = [
    RadarPoint('Qualidade', 96),
    RadarPoint('Pontualidade', 92),
    RadarPoint('Comunicação', 98),
    RadarPoint('Profissionalismo', 95),
    RadarPoint('Recomendação', 94),
  ];

  @override
  Widget build(BuildContext context) {
    final u = currentFreelancer;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Row(
              children: [
                const Text('PERFIL PÚBLICO', style: TextStyle(fontSize: 12, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600, letterSpacing: 0.96)),
                const Spacer(),
                LuIconBtn(icon: Icons.edit_outlined, onPressed: onEdit),
                const SizedBox(width: 6),
                LuIconBtn(icon: Icons.settings_outlined, onPressed: onSettings),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: [LinkUpColors.green, LinkUpColors.greenDark],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      LuAvatar(initials: u.avatar, bg: u.avatarBg, size: 66, ring: true),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(u.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.55),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.verified, size: 15, color: LinkUpColors.gold),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(u.title, style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6, runSpacing: 6,
                              children: [
                                LuPill(u.level, color: PillColor.gold, size: PillSize.sm, icon: Icons.auto_awesome),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(999)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.location_on_outlined, size: 10, color: Colors.white),
                                      const SizedBox(width: 3),
                                      Text(u.city.split(',').first, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (u.videoIntro) ...[
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        children: [
                          Container(
                            width: 36, height: 36,
                            decoration: const BoxDecoration(color: LinkUpColors.gold, shape: BoxShape.circle),
                            child: const Icon(Icons.play_arrow_rounded, size: 18, color: LinkUpColors.navy),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Vídeo de apresentação', style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w700)),
                                SizedBox(height: 1),
                                Text('00:42 · gravado a 12 Mar', style: TextStyle(color: Colors.white70, fontSize: 10.5)),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, size: 16, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
            child: Row(
              children: [
                _miniStat('${u.rating}', 'Avaliação', '${u.reviews} reviews'),
                const SizedBox(width: 6),
                _miniStat('${u.completion}%', 'Conclusão', 'taxa'),
                const SizedBox(width: 6),
                _miniStat('${u.completed}', 'Projectos', 'concluídos'),
                const SizedBox(width: 6),
                _miniStat(u.responseTime, 'Resposta', 'média'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LuSectionTitle('Sobre mim'),
                Text(u.bio, style: const TextStyle(fontSize: 13.5, height: 1.55, color: LinkUpColors.textSecondary)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LuSectionTitle('Score de reputação'),
                LuCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const LuReputationRadar(data: _radarData, size: 150),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          children: [
                            for (final d in _radarData) Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(d.label, style: const TextStyle(color: LinkUpColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 11)),
                                      Text('${d.value}', style: GoogleFonts.jetBrainsMono(color: LinkUpColors.green, fontWeight: FontWeight.w700, fontSize: 11)),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  LuProgressBar(value: d.value.toDouble(), height: 4),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LuSectionTitle('Skills'),
                Wrap(
                  spacing: 6, runSpacing: 6,
                  children: [
                    for (final s in u.skills) LuPill(s, color: PillColor.green),
                    const LuPill('+ adicionar', color: PillColor.neutral),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LuSectionTitle('Portfólio',
                  action: GestureDetector(
                    onTap: onPortfolio,
                    child: const Text('Ver tudo →', style: TextStyle(color: LinkUpColors.green, fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.05,
                  children: [
                    for (final p in portfolio.take(4)) GestureDetector(
                      onTap: onPortfolio,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 90,
                            decoration: BoxDecoration(color: p.cover, borderRadius: BorderRadius.circular(12)),
                            alignment: Alignment.center,
                            child: Text(p.title.split(' ').first, style: linkupSerif(size: 28, color: p.accent)),
                          ),
                          const SizedBox(height: 6),
                          Text(p.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, height: 1.25),
                          ),
                          Text(p.tag, style: const TextStyle(fontSize: 10, color: LinkUpColors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LuSectionTitle('Avaliações',
                  action: GestureDetector(
                    onTap: onReviews,
                    child: const Text('Ver tudo →', style: TextStyle(color: LinkUpColors.green, fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ),
                LuCard(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${u.rating}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -1, color: LinkUpColors.navy, height: 1)),
                          LuStars(value: u.rating, size: 11),
                          const SizedBox(height: 2),
                          Text('${u.reviews} avaliações', style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
                        ],
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          children: [
                            for (final n in [5, 4, 3, 2, 1]) Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Row(
                                children: [
                                  SizedBox(width: 10, child: Text('$n', style: const TextStyle(color: LinkUpColors.textMuted, fontWeight: FontWeight.w600, fontSize: 10))),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: LuProgressBar(
                                      value: n == 5 ? 88 : n == 4 ? 9 : n == 3 ? 2 : 1,
                                      color: LinkUpColors.gold,
                                      height: 4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: LuBtn('Carteira & pagamentos', full: true, size: BtnSize.md, icon: Icons.account_balance_wallet_outlined, variant: BtnVariant.secondary, onPressed: onWallet),
          ),
        ],
      ),
    );
  }

  Widget _miniStat(String v, String l, String sub) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: LinkUpColors.border)),
          child: Column(
            children: [
              Text(v, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: LinkUpColors.navy, letterSpacing: -0.5)),
              const SizedBox(height: 2),
              Text(l, style: const TextStyle(fontSize: 9.5, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );
}
