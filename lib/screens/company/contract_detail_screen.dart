import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';
import '../freelancer/chat_screen.dart';

class ContractDetailScreen extends StatefulWidget {
  final String contractId;
  final String title;
  final String freelancer;
  final String avatar;
  final Color avatarBg;
  final int amount;
  final String status;
  final String due;

  const ContractDetailScreen({
    super.key,
    required this.contractId,
    required this.title,
    required this.freelancer,
    required this.avatar,
    required this.avatarBg,
    required this.amount,
    required this.status,
    required this.due,
  });

  @override
  State<ContractDetailScreen> createState() => _ContractDetailScreenState();
}

class _ContractDetailScreenState extends State<ContractDetailScreen> {
  late List<MilestoneData> _milestones;

  @override
  void initState() {
    super.initState();
    _milestones = List<MilestoneData>.from(contractMilestones[widget.contractId] ?? []);
  }

  String _format(int v) {
    final s = v.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  Future<void> _release(MilestoneData m) async {
    final ok = await LuConfirmDialog.show(context,
      title: 'Libertar fundos?',
      message: 'Vais transferir ${_format(m.amount)} MZN para ${widget.freelancer}. Esta acção é definitiva.',
      confirmLabel: 'Libertar',
    );
    if (!ok || !mounted) return;
    setState(() {
      _milestones = _milestones.map((x) => x.id == m.id
        ? MilestoneData(id: x.id, label: x.label, amount: x.amount, dueDate: x.dueDate, status: 'concluido', order: x.order)
        : x).toList();
    });
    luSnack(context, '${_format(m.amount)} MZN libertados para ${widget.freelancer}.');
  }

  void _dispute() => LuBottomSheet.show(context, title: 'Disputar contrato', actions: [
    LuBottomSheetAction(icon: Icons.report_outlined, label: 'Atraso na entrega', onTap: () => luSnack(context, 'Disputa aberta. Mediador atribuído em 3 dias.')),
    LuBottomSheetAction(icon: Icons.thumb_down_outlined, label: 'Qualidade abaixo do esperado', onTap: () => luSnack(context, 'Disputa aberta.')),
    LuBottomSheetAction(icon: Icons.handshake_outlined, label: 'Cancelar por mútuo acordo', onTap: () => luSnack(context, 'Cancelamento iniciado.')),
  ]);

  @override
  Widget build(BuildContext context) {
    final completed = _milestones.where((m) => m.status == 'concluido').length;
    final progress = _milestones.isEmpty ? 0.0 : (completed / _milestones.length) * 100;
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                LuTopBar(
                  title: 'Contrato',
                  leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
                  actions: [
                    LuIconBtn(icon: Icons.download_rounded, onPressed: () => luSnack(context, 'Contrato exportado em PDF.')),
                    LuIconBtn(icon: Icons.more_horiz, onPressed: _dispute),
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
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [LinkUpColors.navy, LinkUpColors.navyDark]),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  LuAvatar(initials: widget.avatar, bg: widget.avatarBg, size: 52),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.4, height: 1.25)),
                                        const SizedBox(height: 2),
                                        Text(widget.freelancer, style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('VALOR TOTAL', style: TextStyle(color: Colors.white60, fontSize: 10.5, fontWeight: FontWeight.w600, letterSpacing: 0.88)),
                                        const SizedBox(height: 4),
                                        Text('${_format(widget.amount)} MZN', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text('VENCE', style: TextStyle(color: Colors.white60, fontSize: 10.5, fontWeight: FontWeight.w600, letterSpacing: 0.88)),
                                      const SizedBox(height: 4),
                                      Text(widget.due, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('$completed de ${_milestones.length} milestones', style: const TextStyle(color: Colors.white70, fontSize: 11.5, fontWeight: FontWeight.w600)),
                                  Text('${progress.toStringAsFixed(0)}%', style: GoogleFonts.jetBrainsMono(color: LinkUpColors.gold, fontSize: 11.5, fontWeight: FontWeight.w700)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              LuProgressBar(value: progress, color: LinkUpColors.gold, bg: Colors.white24, height: 5),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        const LuSectionTitle('Milestones'),
                        for (int i = 0; i < _milestones.length; i++) Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: LuCard(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 28, height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: switch (_milestones[i].status) {
                                      'concluido' => LinkUpColors.green,
                                      'em-curso' => LinkUpColors.gold,
                                      _ => LinkUpColors.border,
                                    },
                                  ),
                                  alignment: Alignment.center,
                                  child: _milestones[i].status == 'concluido'
                                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                                    : Text('${_milestones[i].order}', style: TextStyle(color: _milestones[i].status == 'em-curso' ? LinkUpColors.navy : LinkUpColors.textMuted, fontSize: 12, fontWeight: FontWeight.w800)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Text(_milestones[i].label, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700))),
                                          LuPill(_milestones[i].status.replaceAll('-', ' '),
                                            color: switch (_milestones[i].status) {
                                              'concluido' => PillColor.success,
                                              'em-curso' => PillColor.gold,
                                              _ => PillColor.neutral,
                                            },
                                            size: PillSize.sm,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('vence ${_milestones[i].dueDate}', style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                                          Text('${_format(_milestones[i].amount)} MZN', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: LinkUpColors.navy)),
                                        ],
                                      ),
                                      if (_milestones[i].status == 'em-curso') ...[
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(child: LuBtn('Libertar fundos', variant: BtnVariant.navy, size: BtnSize.sm, full: true,
                                              icon: Icons.lock_open_rounded,
                                              onPressed: () => _release(_milestones[i]),
                                            )),
                                          ],
                                        ),
                                      ],
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
            Positioned(
              left: 0, right: 0, bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xCCFFFFFF), Colors.white])),
                child: Row(
                  children: [
                    LuBtn('Mensagem', variant: BtnVariant.secondary, size: BtnSize.lg, icon: Icons.chat_bubble_outline,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen(chatId: 'ch1')))),
                    const SizedBox(width: 8),
                    Expanded(child: LuBtn('Disputar', variant: BtnVariant.danger, size: BtnSize.lg, full: true, icon: Icons.report_outlined, onPressed: _dispute)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
