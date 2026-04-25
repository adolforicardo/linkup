import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class HomeScreen extends StatelessWidget {
  final void Function(String) onJob;
  final void Function(String) onCompany;
  final VoidCallback onSearch;
  final VoidCallback onNotifications;

  const HomeScreen({
    super.key,
    required this.onJob,
    required this.onCompany,
    required this.onSearch,
    required this.onNotifications,
  });

  @override
  Widget build(BuildContext context) {
    final featured = jobs.take(3).toList();
    final hero = featured.first;
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
                    children: const [
                      Text('Bom dia,', style: TextStyle(fontSize: 13, color: LinkUpColors.textMuted, fontWeight: FontWeight.w500)),
                      SizedBox(height: 2),
                      Text('Aida 👋', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.65, color: LinkUpColors.navy)),
                    ],
                  ),
                ),
                LuIconBtn(icon: Icons.notifications_none_rounded, badge: '3', onPressed: onNotifications),
                const SizedBox(width: 8),
                const LuAvatar(initials: 'AM', bg: LinkUpColors.gold, size: 38),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
            child: GestureDetector(
              onTap: onSearch,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: LinkUpColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 18, color: LinkUpColors.textMuted),
                    const SizedBox(width: 10),
                    const Expanded(child: Text('Pesquisar oportunidades…', style: TextStyle(color: LinkUpColors.textMuted, fontSize: 14))),
                    Container(
                      width: 30, height: 30,
                      decoration: BoxDecoration(color: LinkUpColors.green, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.tune_rounded, size: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: GestureDetector(
              onTap: () => onJob(hero.id),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'RECOMENDADO PARA TI',
                          style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, letterSpacing: 1.2, color: LinkUpColors.gold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(999)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.auto_awesome, size: 12, color: LinkUpColors.gold),
                              const SizedBox(width: 4),
                              Text('${hero.match}% match', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(hero.title,
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.55, height: 1.15),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        LuAvatar(initials: hero.companyAvatar, bg: Colors.white.withValues(alpha: 0.2), size: 24),
                        const SizedBox(width: 8),
                        Text(hero.company, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 13)),
                        if (hero.verified) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, size: 14, color: LinkUpColors.gold),
                        ],
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(spacing: 6, children: [
                      _heroChip(hero.budget),
                      _heroChip(hero.duration),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                _statTile(label: 'Activas', value: '${currentFreelancer.active}', sub: 'candidaturas'),
                const SizedBox(width: 8),
                _statTile(label: 'Ganhos', value: '128k', sub: 'este mês · MZN'),
                const SizedBox(width: 8),
                _statTile(label: 'Avaliação', value: '${currentFreelancer.rating}', sub: '${currentFreelancer.reviews} reviews'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: LuSectionTitle(
              'Mais oportunidades',
              action: GestureDetector(
                onTap: onSearch,
                child: const Text('Ver todas →', style: TextStyle(color: LinkUpColors.green, fontSize: 13, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                for (final j in featured.skip(1)) ...[
                  JobCard(job: j, onTap: () => onJob(j.id)),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: const LuSectionTitle('Empresas em destaque'),
          ),
          SizedBox(
            height: 130,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: companies.take(5).length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final c = companies[i];
                return GestureDetector(
                  onTap: () => onCompany(c.id),
                  child: Container(
                    width: 160,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: LinkUpColors.border),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LuAvatar(initials: c.avatar, bg: c.bg, size: 40),
                            if (c.verified) const Icon(Icons.verified, size: 16, color: LinkUpColors.gold),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(c.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, height: 1.2),
                        ),
                        const SizedBox(height: 2),
                        Text(c.industry, style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted)),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.work_outline, size: 11, color: LinkUpColors.textSecondary),
                            const SizedBox(width: 4),
                            Text('${c.jobs} vagas', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget _heroChip(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(999)),
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
      );

  static Widget _statTile({required String label, required String value, required String sub}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: LinkUpColors.border)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase(), style: const TextStyle(fontSize: 10, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600, letterSpacing: 0.6)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5, color: LinkUpColors.navy)),
            const SizedBox(height: 1),
            Text(sub, style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
          ],
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final JobData job;
  final VoidCallback? onTap;
  final bool compact;
  const JobCard({super.key, required this.job, this.onTap, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return LuCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuAvatar(initials: job.companyAvatar, bg: job.companyBg, size: 42),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              job.company,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary),
                            ),
                          ),
                          if (job.verified) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.verified, size: 12, color: LinkUpColors.gold),
                          ],
                        ],
                      ),
                    ),
                    Text(job.posted, style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(job.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, height: 1.25, letterSpacing: -0.4)),
                if (!compact) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [for (final s in job.skills.take(3)) LuPill(s, color: PillColor.neutral, size: PillSize.sm)],
                  ),
                ],
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        job.budget,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: LinkUpColors.navy),
                      ),
                    ),
                    LuPill('${job.match}% match', color: PillColor.green, size: PillSize.sm, icon: Icons.auto_awesome),
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
