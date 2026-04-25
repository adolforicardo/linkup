import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';
import 'apply_screen.dart';
import 'company_profile_screen.dart';
import 'chat_screen.dart';

class JobDetailScreen extends StatelessWidget {
  final String jobId;
  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final job = jobs.firstWhere((j) => j.id == jobId, orElse: () => jobs.first);
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LuTopBar(
                  title: 'Oportunidade',
                  leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
                  actions: [
                    LuIconBtn(icon: Icons.star_outline_rounded,
                      onPressed: () => luSnack(context, 'Vaga guardada nos favoritos.', icon: Icons.star_rounded),
                    ),
                    LuIconBtn(icon: Icons.more_horiz, onPressed: () => LuBottomSheet.show(context, title: 'Vaga', actions: [
                      LuBottomSheetAction(icon: Icons.share_outlined, label: 'Partilhar', onTap: () => luSnack(context, 'Link copiado.')),
                      LuBottomSheetAction(icon: Icons.link_rounded, label: 'Copiar link', onTap: () => luSnack(context, 'Link copiado.')),
                      LuBottomSheetAction(icon: Icons.notifications_off_outlined, label: 'Não me mostrar similares', onTap: () => luSnack(context, 'Vagas similares ocultadas.')),
                      LuBottomSheetAction(icon: Icons.report_outlined, label: 'Reportar vaga', destructive: true, onTap: () => luSnack(context, 'Reporte enviado.')),
                    ])),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 130),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft, end: Alignment.bottomRight,
                              colors: [job.companyBg, job.companyBg.withValues(alpha: 0.85)],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  LuAvatar(initials: job.companyAvatar, bg: Colors.white.withValues(alpha: 0.2), size: 48),
                                  LuPill('${job.match}% match', color: PillColor.gold, icon: Icons.auto_awesome),
                                ],
                              ),
                              const SizedBox(height: 14),
                              GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(
                                  builder: (_) => CompanyProfileScreen(companyId: job.companyId),
                                )),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(job.company,
                                      style: const TextStyle(color: Colors.white70, fontSize: 12.5, fontWeight: FontWeight.w600),
                                    ),
                                    if (job.verified) ...[
                                      const SizedBox(width: 4),
                                      const Icon(Icons.verified, size: 13, color: LinkUpColors.gold),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(job.title,
                                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.55, height: 1.2),
                              ),
                              if (job.urgent) ...[
                                const SizedBox(height: 10),
                                LuPill('Urgente', color: PillColor.red, size: PillSize.sm, icon: Icons.flag_outlined),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            _kv('Orçamento', job.budget, Icons.account_balance_wallet_outlined),
                            const SizedBox(width: 8),
                            _kv('Duração', job.duration, Icons.schedule_rounded),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _kv('Tipo', job.type, Icons.work_outline),
                            const SizedBox(width: 8),
                            _kv('Local', job.location, Icons.location_on_outlined),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const LuSectionTitle('Descrição'),
                        Text(job.description, style: const TextStyle(fontSize: 14, height: 1.55, color: LinkUpColors.textSecondary)),
                        const SizedBox(height: 20),
                        const LuSectionTitle('Skills exigidas'),
                        Wrap(
                          spacing: 6, runSpacing: 6,
                          children: [for (final s in job.skills) LuPill(s, color: PillColor.green)],
                        ),
                        const SizedBox(height: 20),
                        const LuSectionTitle('Actividade'),
                        LuCard(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _activity('Propostas', '${job.proposals}'),
                              _activity('Pré-seleccionados', '3'),
                              _activity('Publicado', job.posted),
                            ],
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
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Color(0xCCFFFFFF), Colors.white],
                  ),
                ),
                child: Row(
                  children: [
                    LuBtn('Mensagem', variant: BtnVariant.secondary, size: BtnSize.lg,
                      icon: Icons.chat_bubble_outline,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen(chatId: 'ch1'))),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: LuBtn('Candidatar-me', variant: BtnVariant.primary, size: BtnSize.lg, full: true,
                        icon: Icons.send_rounded,
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ApplyScreen(jobId: job.id))),
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

  Widget _kv(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: LinkUpColors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 12, color: LinkUpColors.textMuted),
                const SizedBox(width: 4),
                Text(label, style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: LinkUpColors.navy)),
          ],
        ),
      ),
    );
  }

  Widget _activity(String l, String v) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l, style: const TextStyle(color: LinkUpColors.textMuted, fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(v, style: const TextStyle(fontWeight: FontWeight.w700, color: LinkUpColors.navy, fontSize: 13)),
      ],
    );
  }
}
