import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class ApplyScreen extends StatefulWidget {
  final String jobId;
  const ApplyScreen({super.key, required this.jobId});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final _bidCtrl = TextEditingController(text: '320000');
  final _coverCtrl = TextEditingController(
    text: 'Olá! Tenho 6 anos de experiência em design de produtos fintech, incluindo projectos para a Letshego e a Mukuru. Gostaria muito de contribuir.',
  );
  bool _milestones = true;
  bool _done = false;

  @override
  void dispose() {
    _bidCtrl.dispose();
    _coverCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final job = jobs.firstWhere((j) => j.id == widget.jobId, orElse: () => jobs.first);
    if (_done) {
      return Scaffold(
        backgroundColor: LinkUpColors.background,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80, height: 80,
                    decoration: const BoxDecoration(color: LinkUpColors.pillGreenBg, shape: BoxShape.circle),
                    child: const Icon(Icons.check, size: 36, color: LinkUpColors.green),
                  ),
                  const SizedBox(height: 20),
                  const Text('Proposta enviada!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -0.5, color: LinkUpColors.navy),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'A ${job.company} vai analisar a tua candidatura.\nReceberás notificação assim que houver resposta.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: LinkUpColors.textSecondary, fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  LuBtn('Voltar à oportunidade', size: BtnSize.lg, onPressed: () => Navigator.pop(context)),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                LuTopBar(
                  title: 'Candidatar',
                  leading: LuIconBtn(icon: Icons.close, onPressed: () => Navigator.pop(context)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 130),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LuCard(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              LuAvatar(initials: job.companyAvatar, bg: job.companyBg, size: 40),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(job.company, style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
                                    Text(job.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: -0.3)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        LuInputField(
                          label: 'A tua proposta (MZN)',
                          value: _bidCtrl.text,
                          onChanged: (v) => _bidCtrl.text = v,
                          icon: Icons.account_balance_wallet_outlined,
                          type: TextInputType.number,
                        ),
                        const SizedBox(height: 14),
                        const Text('Carta de apresentação', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _coverCtrl,
                          maxLines: 6,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: LinkUpColors.surfaceTint,
                            border: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.green), borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          style: const TextStyle(fontSize: 13.5, height: 1.5),
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('${_coverCtrl.text.length} / 600',
                            style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted),
                          ),
                        ),
                        const SizedBox(height: 14),
                        LuCard(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            children: [
                              LuToggleRow(
                                label: 'Dividir em milestones',
                                sub: 'Recomendado para projectos > 100.000 MZN',
                                value: _milestones,
                                onChanged: (v) => setState(() => _milestones = v),
                              ),
                              if (_milestones) ...[
                                const SizedBox(height: 4),
                                _milestoneRow(1, 'Pesquisa & descoberta', '30%'),
                                _milestoneRow(2, 'Wireframes & estrutura', '30%'),
                                _milestoneRow(3, 'Design final + handoff', '40%', last: true),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: LinkUpColors.cream, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE8D7A8))),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.shield_outlined, color: LinkUpColors.goldDark, size: 18),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: 'Pagamento protegido: ', style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF5C4710))),
                                      TextSpan(text: 'os fundos ficam em escrow até validares cada milestone.', style: TextStyle(color: Color(0xFF5C4710))),
                                    ],
                                  ),
                                  style: TextStyle(fontSize: 12, height: 1.45),
                                ),
                              ),
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
                child: LuBtn('Enviar proposta',
                  full: true, size: BtnSize.lg, icon: Icons.send_rounded,
                  onPressed: () => setState(() => _done = true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _milestoneRow(int n, String label, String value, {bool last = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: LinkUpColors.border))),
      child: Row(
        children: [
          Container(
            width: 22, height: 22,
            decoration: const BoxDecoration(color: LinkUpColors.green, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text('$n', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
          Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: LinkUpColors.navy)),
        ],
      ),
    );
  }
}
