import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';
import 'home_screen.dart';
import 'chat_screen.dart';
import 'job_detail_screen.dart';

class CompanyProfileScreen extends StatefulWidget {
  final String companyId;
  const CompanyProfileScreen({super.key, required this.companyId});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  String _tab = 'sobre';

  @override
  Widget build(BuildContext context) {
    final c = companies.firstWhere((x) => x.id == widget.companyId, orElse: () => companies.first);
    final companyJobs = jobs.where((j) => j.companyId == widget.companyId).toList();
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                LuTopBar(
                  title: 'Empresa',
                  leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
                  actions: [LuIconBtn(icon: Icons.more_horiz, onPressed: () {})],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 130),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LuCard(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  LuAvatar(initials: c.avatar, bg: c.bg, size: 64),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(c.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.4),
                                              ),
                                            ),
                                            if (c.verified) ...[
                                              const SizedBox(width: 6),
                                              const Icon(Icons.verified, color: LinkUpColors.gold, size: 16),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Text('${c.industry} · ${c.city}',
                                          style: const TextStyle(fontSize: 12.5, color: LinkUpColors.textSecondary),
                                        ),
                                        const SizedBox(height: 6),
                                        LuStars(value: c.rating, size: 12, showNumber: true),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (c.verified) ...[
                                const SizedBox(height: 14),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: LinkUpColors.cream, borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.shield_outlined, color: LinkUpColors.goldDark, size: 18),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text('Empresa verificada pela Ubuntu',
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF5C4710)),
                                            ),
                                            SizedBox(height: 1),
                                            Text('NUIT validado · histórico de pagamento confirmado',
                                              style: TextStyle(fontSize: 10.5, color: LinkUpColors.goldDark),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _stat('${c.jobs}', 'Vagas activas'),
                            const SizedBox(width: 8),
                            _stat('${c.hires}', 'Contratações'),
                            const SizedBox(width: 8),
                            _stat('${c.rating}', 'Avaliação'),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(color: LinkUpColors.border, borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              _tabBtn('sobre', 'Sobre'),
                              _tabBtn('vagas', 'Vagas (${companyJobs.length})'),
                              _tabBtn('reviews', 'Reviews'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        if (_tab == 'sobre')
                          LuCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${c.name} é uma referência em ${c.industry.toLowerCase()} em Moçambique. Trabalhamos com freelancers em projectos de transformação digital, design, marketing e desenvolvimento de software.',
                                  style: const TextStyle(fontSize: 13.5, height: 1.55, color: LinkUpColors.textSecondary),
                                ),
                                const LuDivider(),
                                const Text('SEDE', style: TextStyle(fontSize: 12, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text('${c.city}, Moçambique', style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          )
                        else if (_tab == 'vagas')
                          if (companyJobs.isEmpty)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Center(child: Text('Sem vagas activas.', style: TextStyle(color: LinkUpColors.textMuted))),
                            )
                          else
                            Column(
                              children: [
                                for (final j in companyJobs) ...[
                                  JobCard(job: j, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => JobDetailScreen(jobId: j.id)))),
                                  const SizedBox(height: 10),
                                ],
                              ],
                            )
                        else
                          Column(
                            children: [
                              for (int i = 1; i <= 3; i++) ...[
                                LuCard(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const LuStars(value: 5, size: 13),
                                          Text('há $i ${i == 1 ? "mês" : "meses"}', style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Pagamento pontual e comunicação clara. Equipa profissional e respeitadora dos prazos.',
                                        style: TextStyle(fontSize: 13, height: 1.5, color: LinkUpColors.textSecondary),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text('— Freelancer verificado',
                                        style: TextStyle(fontSize: 12, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0, right: 0, bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Color(0xCCFFFFFF), Colors.white],
                  ),
                ),
                child: LuBtn('Enviar mensagem',
                  full: true, size: BtnSize.lg, icon: Icons.chat_bubble_outline,
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen(chatId: 'ch1'))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String v, String l) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: LinkUpColors.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Text(v, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: LinkUpColors.navy, letterSpacing: -0.4)),
              const SizedBox(height: 2),
              Text(l, style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );

  Widget _tabBtn(String key, String label) {
    final on = _tab == key;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tab = key),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: on ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: on ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 3, offset: const Offset(0, 1))] : null,
          ),
          child: Center(
            child: Text(label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: on ? FontWeight.w700 : FontWeight.w500,
                color: on ? LinkUpColors.green : LinkUpColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
