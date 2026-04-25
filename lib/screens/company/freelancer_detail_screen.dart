import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';
import 'pipeline_screen.dart';
import '../freelancer/chat_screen.dart';

class FreelancerDetailScreen extends StatelessWidget {
  final String freelancerId;
  const FreelancerDetailScreen({super.key, required this.freelancerId});

  static const _radarData = [
    RadarPoint('Qualidade', 96),
    RadarPoint('Pontualidade', 92),
    RadarPoint('Comunicação', 98),
    RadarPoint('Profissionalismo', 95),
    RadarPoint('Recomendação', 94),
  ];

  @override
  Widget build(BuildContext context) {
    final f = freelancers.firstWhere((x) => x.id == freelancerId, orElse: () => freelancers.first);
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                LuTopBar(
                  title: 'Freelancer',
                  leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
                  actions: [
                    LuIconBtn(icon: Icons.star_outline_rounded,
                      onPressed: () => luSnack(context, 'Freelancer adicionado aos favoritos.', icon: Icons.star_rounded),
                    ),
                    LuIconBtn(icon: Icons.more_horiz, onPressed: () => LuBottomSheet.show(context, title: f.name, actions: [
                      LuBottomSheetAction(icon: Icons.share_outlined, label: 'Partilhar perfil', onTap: () => luSnack(context, 'Link copiado.')),
                      LuBottomSheetAction(icon: Icons.bookmark_border_rounded, label: 'Guardar para mais tarde', onTap: () => luSnack(context, 'Freelancer guardado.')),
                      LuBottomSheetAction(icon: Icons.report_outlined, label: 'Reportar', destructive: true, onTap: () => luSnack(context, 'Reporte enviado.')),
                    ])),
                  ],
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
                            children: [
                              Row(
                                children: [
                                  LuAvatar(initials: f.avatar, bg: f.bg, size: 64, online: f.available),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(child: Text(f.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.4))),
                                            if (f.verified) ...[
                                              const SizedBox(width: 6),
                                              const Icon(Icons.verified, size: 15, color: LinkUpColors.gold),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Text(f.title, style: const TextStyle(fontSize: 12.5, color: LinkUpColors.textSecondary)),
                                        const SizedBox(height: 6),
                                        Wrap(
                                          spacing: 6, runSpacing: 6,
                                          children: [
                                            LuPill(f.level, color: PillColor.gold, size: PillSize.sm, icon: Icons.auto_awesome),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.location_on_outlined, size: 10, color: LinkUpColors.textMuted),
                                                Text(f.city, style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                                    colors: [LinkUpColors.navy, LinkUpColors.navyDark],
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('MATCH COM A TUA VAGA',
                                          style: TextStyle(color: Colors.white70, fontSize: 10.5, fontWeight: FontWeight.w600, letterSpacing: 0.84),
                                        ),
                                        Text('${f.match}%', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.7)),
                                      ],
                                    ),
                                    Container(
                                      width: 56, height: 56,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: LinkUpColors.gold, width: 4),
                                      ),
                                      child: const Icon(Icons.auto_awesome, size: 22, color: LinkUpColors.gold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        LuPlaceholder(label: 'Vídeo de apresentação · 00:42', height: 140, color: f.bg),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _stat('${f.rating}', 'Avaliação'),
                            const SizedBox(width: 8),
                            _stat('${f.reviews}', 'Reviews'),
                            const SizedBox(width: 8),
                            _stat(_format(f.rate), 'MZN/h'),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const LuSectionTitle('Skills'),
                        Wrap(
                          spacing: 6, runSpacing: 6,
                          children: [for (final s in f.skills) LuPill(s, color: PillColor.green)],
                        ),
                        const SizedBox(height: 18),
                        const LuSectionTitle('Score de reputação'),
                        LuCard(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              const LuReputationRadar(data: _radarData, size: 130),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  children: [
                                    for (final d in _radarData.take(4)) Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(d.label, style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textSecondary, fontWeight: FontWeight.w600)),
                                              Text('${d.value}', style: GoogleFonts.jetBrainsMono(color: LinkUpColors.green, fontWeight: FontWeight.w700, fontSize: 10.5)),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          LuProgressBar(value: d.value.toDouble(), height: 3.5),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        const LuSectionTitle('Portfólio'),
                        SizedBox(
                          height: 110,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (_, i) {
                              final colors = [LinkUpColors.green, LinkUpColors.navy, LinkUpColors.gold, LinkUpColors.greenDark];
                              return SizedBox(
                                width: 130,
                                child: LuPlaceholder(label: 'projecto ${i + 1}', height: 100, color: colors[i]),
                              );
                            },
                          ),
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
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xCCFFFFFF), Colors.white]),
                ),
                child: Row(
                  children: [
                    LuBtn('Mensagem', variant: BtnVariant.secondary, size: BtnSize.lg, icon: Icons.chat_bubble_outline,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen(chatId: 'ch1')))),
                    const SizedBox(width: 8),
                    Expanded(
                      child: LuBtn('Convidar para vaga', variant: BtnVariant.navy, size: BtnSize.lg, full: true, icon: Icons.send_rounded,
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PipelineScreen()))),
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

  Widget _stat(String v, String l) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: LinkUpColors.border), borderRadius: BorderRadius.circular(14)),
          child: Column(
            children: [
              Text(v, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: LinkUpColors.navy, letterSpacing: -0.4)),
              const SizedBox(height: 2),
              Text(l, style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );

  String _format(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}
