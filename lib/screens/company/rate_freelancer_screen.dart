import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';

class RateFreelancerScreen extends StatefulWidget {
  const RateFreelancerScreen({super.key});

  @override
  State<RateFreelancerScreen> createState() => _RateFreelancerScreenState();
}

class _RateFreelancerScreenState extends State<RateFreelancerScreen> {
  int _rating = 5;
  bool _done = false;
  final _ctrl = TextEditingController();
  final _dims = const [
    ('qualidade', 'Qualidade do trabalho'),
    ('pontualidade', 'Pontualidade'),
    ('comunicacao', 'Comunicação'),
    ('profissionalismo', 'Profissionalismo'),
  ];
  late final Map<String, int> _scores;

  @override
  void initState() {
    super.initState();
    _scores = {for (final d in _dims) d.$1: 5};
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    decoration: const BoxDecoration(color: LinkUpColors.cream, shape: BoxShape.circle),
                    child: const Icon(Icons.star_rounded, size: 36, color: LinkUpColors.gold),
                  ),
                  const SizedBox(height: 20),
                  const Text('Obrigado pela tua avaliação!', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.5, color: LinkUpColors.navy),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'A reputação no LinkUp depende de pessoas como tu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: LinkUpColors.textSecondary, fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  LuBtn('Voltar', variant: BtnVariant.navy, size: BtnSize.lg, onPressed: () => Navigator.pop(context)),
                ],
              ),
            ),
          ),
        ),
      );
    }
    final labels = const ['Insatisfeito', 'Razoável', 'Bom', 'Muito bom', 'Excelente'];
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                LuTopBar(
                  title: 'Avaliar freelancer',
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
                            children: const [
                              LuAvatar(initials: 'AM', bg: LinkUpColors.gold, size: 48),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Aida Macuácua', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                                    SizedBox(height: 1),
                                    Text('Redesenhar app de mobile banking', style: TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text('Como foi a experiência?',
                            style: TextStyle(fontSize: 13, color: LinkUpColors.textSecondary, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 1; i <= 5; i++) GestureDetector(
                              onTap: () => setState(() => _rating = i),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 3),
                                child: Icon(Icons.star_rounded, size: 36, color: i <= _rating ? LinkUpColors.gold : LinkUpColors.textDisabled),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Center(
                          child: Text(labels[_rating - 1], style: const TextStyle(fontSize: 12, color: LinkUpColors.green, fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(height: 20),
                        const LuSectionTitle('Detalhes'),
                        LuCard(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            children: [
                              for (int i = 0; i < _dims.length; i++) Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  border: i < _dims.length - 1 ? const Border(bottom: BorderSide(color: LinkUpColors.border)) : null,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(_dims[i].$2, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600))),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        for (int n = 1; n <= 5; n++) GestureDetector(
                                          onTap: () => setState(() => _scores[_dims[i].$1] = n),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1),
                                            child: Icon(Icons.star_rounded, size: 16,
                                              color: n <= (_scores[_dims[i].$1] ?? 5) ? LinkUpColors.gold : LinkUpColors.textDisabled,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Comentário público', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _ctrl,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Conta como foi trabalhar com a Aida...',
                            filled: true, fillColor: LinkUpColors.surfaceTint,
                            border: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.navy), borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          style: const TextStyle(fontSize: 13.5, height: 1.5),
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
                child: LuBtn('Submeter avaliação', variant: BtnVariant.navy, size: BtnSize.lg, full: true, onPressed: () => setState(() => _done = true)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
