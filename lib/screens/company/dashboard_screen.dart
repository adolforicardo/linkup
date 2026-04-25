import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class CompanyDashboardScreen extends StatelessWidget {
  final VoidCallback onJobs;
  final VoidCallback onSearch;
  final VoidCallback onPipeline;
  final VoidCallback onPost;
  final VoidCallback onNotifications;
  const CompanyDashboardScreen({
    super.key,
    required this.onJobs,
    required this.onSearch,
    required this.onPipeline,
    required this.onPost,
    required this.onNotifications,
  });

  @override
  Widget build(BuildContext context) {
    final c = currentCompany;
    final activeJobs = companyJobs.where((j) => j.status == 'activa').take(3).toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Bom dia,', style: TextStyle(fontSize: 12, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(c.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800, letterSpacing: -0.45, color: LinkUpColors.navy),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.verified, size: 16, color: LinkUpColors.gold),
                        ],
                      ),
                    ],
                  ),
                ),
                LuIconBtn(icon: Icons.notifications_none_rounded, badge: '5', onPressed: onNotifications),
                const SizedBox(width: 8),
                LuAvatar(initials: c.avatar, bg: c.avatarBg, size: 38),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: [LinkUpColors.navy, LinkUpColors.navyDark],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('INVESTIDO ESTE ANO', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.1)),
                        ],
                      ),
                      const LuPill('+18%', color: PillColor.gold, size: PillSize.sm, icon: Icons.trending_up),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: c.spent, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.75)),
                        const TextSpan(text: ' MZN', style: TextStyle(color: Colors.white60, fontSize: 14, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      _kpi('${c.openRoles}', 'Vagas activas'),
                      const SizedBox(width: 8),
                      _kpi('${c.activeContracts}', 'Em curso'),
                      const SizedBox(width: 8),
                      _kpi('${c.hiresTotal}', 'Contratações'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onPost,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: LinkUpColors.green,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: LinkUpColors.green.withValues(alpha: 0.2), blurRadius: 14, offset: const Offset(0, 4))],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.add, size: 18, color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Publicar vaga', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                                Text('Encontra talento', style: TextStyle(fontSize: 10.5, color: Colors.white70)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: onSearch,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: LinkUpColors.border)),
                      child: Row(
                        children: [
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(color: LinkUpColors.cream, borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.search, size: 17, color: LinkUpColors.goldDark),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pesquisar talento', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                                Text('2.4k freelancers', style: TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                const LuSectionTitle('Actividade',
                  action: Text('últimos 6 meses', style: TextStyle(fontSize: 11, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
                ),
                LuCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (int i = 0; i < 6; i++) ...[
                              _bar([12, 24, 18, 38, 28, 47][i], i == 5),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (final m in const ['Nov', 'Dez', 'Jan', 'Fev', 'Mar', 'Abr'])
                            Text(m, style: const TextStyle(fontSize: 9.5, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
                        ],
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
                LuSectionTitle('Vagas activas',
                  action: GestureDetector(
                    onTap: onJobs,
                    child: const Text('Gerir →', style: TextStyle(color: LinkUpColors.green, fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ),
                for (final j in activeJobs) Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: LuCard(
                    onTap: onPipeline,
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(j.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, height: 1.3)),
                                  const SizedBox(height: 4),
                                  Text('publicado ${j.posted}', style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
                                ],
                              ),
                            ),
                            const LuPill('activa', color: PillColor.green, size: PillSize.sm),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            LuStat(n: '${j.proposals}', label: 'propostas'),
                            const SizedBox(width: 14),
                            LuStat(n: '${j.shortlist}', label: 'shortlist'),
                            const SizedBox(width: 14),
                            LuStat(n: '${j.views}', label: 'visualizações'),
                          ],
                        ),
                      ],
                    ),
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
                const LuSectionTitle('Pipeline · Mobile banking'),
                Row(
                  children: [
                    _pipeBox('Novos', 3, LinkUpColors.navy, onPipeline),
                    const SizedBox(width: 6),
                    _pipeBox('Shortlist', 2, LinkUpColors.green, onPipeline),
                    const SizedBox(width: 6),
                    _pipeBox('Entrev.', 1, LinkUpColors.gold, onPipeline),
                    const SizedBox(width: 6),
                    _pipeBox('Oferta', 0, LinkUpColors.textMuted, onPipeline),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kpi(String v, String l) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(v, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
              const SizedBox(height: 1),
              Text(l, style: const TextStyle(color: Colors.white70, fontSize: 10.5, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );

  Widget _bar(int v, bool active) {
    return Container(
      width: 32,
      height: v * 1.4,
      decoration: BoxDecoration(
        color: active ? LinkUpColors.green : LinkUpColors.pillGreenBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
      ),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text('$v', style: GoogleFonts.jetBrainsMono(color: active ? Colors.white : LinkUpColors.textSecondary, fontSize: 9, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _pipeBox(String l, int n, Color c, VoidCallback? onTap) => Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: LinkUpColors.border)),
            child: Column(
              children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
                const SizedBox(height: 4),
                Text('$n', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: LinkUpColors.navy, letterSpacing: -0.4)),
                Text(l, style: const TextStyle(fontSize: 9.5, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      );
}
