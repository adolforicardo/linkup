import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  int _step = 0;
  bool _done = false;
  String _title = 'Designer de produto sénior';
  String _category = 'Design & UX';
  String _type = 'projecto';
  final _skills = <String>{'UI/UX', 'Figma'};
  String _budgetMin = '200000';
  String _budgetMax = '350000';
  String _duration = '6-8 semanas';
  String _description = 'Procuramos um designer sénior para liderar...';

  static const _stepLabels = ['Básico', 'Skills & escopo', 'Orçamento', 'Revisão'];

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
                    decoration: const BoxDecoration(color: LinkUpColors.pillGreenBg, shape: BoxShape.circle),
                    child: const Icon(Icons.check, size: 36, color: LinkUpColors.green),
                  ),
                  const SizedBox(height: 20),
                  const Text('Vaga publicada!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -0.5, color: LinkUpColors.navy),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'A IA já está a recomendar candidatos.\nVais receber as primeiras propostas em poucas horas.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: LinkUpColors.textSecondary, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  LuBtn('Ver vaga publicada', variant: BtnVariant.navy, size: BtnSize.lg, onPressed: () => Navigator.pop(context)),
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
                  title: 'Publicar vaga · ${_step + 1}/4',
                  leading: LuIconBtn(icon: Icons.close, onPressed: () => Navigator.pop(context)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < _stepLabels.length; i++) ...[
                            Expanded(
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: i <= _step ? LinkUpColors.navy : LinkUpColors.border,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            if (i < _stepLabels.length - 1) const SizedBox(width: 4),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(_stepLabels[_step].toUpperCase(),
                        style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600, letterSpacing: 0.88),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 130),
                    child: _stepBody(),
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
                    if (_step > 0)
                      LuBtn('Anterior', variant: BtnVariant.secondary, size: BtnSize.lg, onPressed: () => setState(() => _step--)),
                    if (_step > 0) const SizedBox(width: 8),
                    Expanded(
                      child: LuBtn(
                        _step < 3 ? 'Continuar' : 'Publicar vaga',
                        variant: BtnVariant.navy, size: BtnSize.lg, full: true,
                        icon: _step < 3 ? Icons.arrow_forward_rounded : Icons.check,
                        onPressed: () {
                          if (_step < 3) setState(() => _step++);
                          else setState(() => _done = true);
                        },
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

  Widget _stepBody() {
    if (_step == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuInputField(label: 'Título da vaga', value: _title, onChanged: (v) => _title = v),
          const SizedBox(height: 14),
          const Text('Categoria', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6, runSpacing: 6,
            children: [
              for (final c in const ['Design & UX', 'Desenvolvimento', 'Marketing', 'Tradução', 'Contabilidade', 'Vídeo & Foto'])
                _categoryBtn(c),
            ],
          ),
          const SizedBox(height: 14),
          const Text('Tipo de contrato', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
          const SizedBox(height: 6),
          Row(
            children: [
              _typeBtn('projecto', 'Projecto'),
              const SizedBox(width: 6),
              _typeBtn('hora', 'Por hora'),
              const SizedBox(width: 6),
              _typeBtn('recorrente', 'Recorrente'),
            ],
          ),
        ],
      );
    }
    if (_step == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Skills exigidas', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 5, runSpacing: 5,
            children: [
              for (final s in const ['UI/UX', 'Figma', 'Design System', 'Mobile', 'Pesquisa', 'Prototyping', 'Branding'])
                _skillBtn(s),
            ],
          ),
          const SizedBox(height: 14),
          const Text('Descrição do trabalho', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
          const SizedBox(height: 6),
          TextField(
            controller: TextEditingController(text: _description),
            onChanged: (v) => _description = v,
            maxLines: 6,
            decoration: InputDecoration(
              filled: true, fillColor: LinkUpColors.surfaceTint,
              border: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.navy), borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.all(12),
            ),
            style: const TextStyle(fontSize: 13.5, height: 1.5),
          ),
          const SizedBox(height: 14),
          LuInputField(label: 'Duração estimada', value: _duration, onChanged: (v) => _duration = v, icon: Icons.schedule_rounded),
        ],
      );
    }
    if (_step == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: LuInputField(label: 'Mínimo (MZN)', value: _budgetMin, onChanged: (v) => _budgetMin = v)),
              const SizedBox(width: 10),
              Expanded(child: LuInputField(label: 'Máximo (MZN)', value: _budgetMax, onChanged: (v) => _budgetMax = v)),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: LinkUpColors.cream, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE8D7A8))),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.auto_awesome, size: 18, color: LinkUpColors.goldDark),
                SizedBox(width: 10),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Vagas similares no LinkUp são pagas em média '),
                        TextSpan(text: '280.000 MZN', style: TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(text: '. Vagas com orçamento acima da média recebem '),
                        TextSpan(text: '3× mais propostas', style: TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(text: '.'),
                      ],
                    ),
                    style: TextStyle(fontSize: 12, color: Color(0xFF5C4710), height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          LuToggleRow(label: 'Pagamento em escrow', sub: 'Recomendado · liberta por milestone', value: true, onChanged: (_) {}),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LuCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LuPill(_category, color: PillColor.navy, size: PillSize.sm),
              const SizedBox(height: 10),
              Text(_title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.4)),
              const SizedBox(height: 4),
              Text('${_typeLabel(_type)} · $_duration', style: const TextStyle(fontSize: 12, color: LinkUpColors.textMuted)),
              const LuDivider(),
              Text(_description, style: const TextStyle(fontSize: 13, color: LinkUpColors.textSecondary, height: 1.5)),
              const LuDivider(),
              Wrap(spacing: 5, runSpacing: 5, children: [for (final s in _skills) LuPill(s, color: PillColor.green, size: PillSize.sm)]),
              const LuDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Orçamento', style: TextStyle(fontSize: 12, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600)),
                  Text('${_format(_budgetMin)} – ${_format(_budgetMax)} MZN',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: LinkUpColors.navy),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        LuCard(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Visibilidade estimada', style: TextStyle(fontSize: 13, color: LinkUpColors.textSecondary)),
                  Text('~ 1.200 freelancers', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: LinkUpColors.green)),
                ],
              ),
              const LuDivider(margin: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Propostas esperadas (24h)', style: TextStyle(fontSize: 13, color: LinkUpColors.textSecondary)),
                  Text('8 – 14', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: LinkUpColors.green)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryBtn(String c) {
    final on = _category == c;
    return GestureDetector(
      onTap: () => setState(() => _category = c),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: on ? LinkUpColors.pillNavyBg : Colors.white,
          border: Border.all(color: on ? LinkUpColors.navy : LinkUpColors.border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(c, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: on ? LinkUpColors.navy : LinkUpColors.textSecondary)),
      ),
    );
  }

  Widget _typeBtn(String key, String label) {
    final on = _type == key;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _type = key),
        child: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: on ? LinkUpColors.pillNavyBg : Colors.white,
            border: Border.all(color: on ? LinkUpColors.navy : LinkUpColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget _skillBtn(String s) {
    final on = _skills.contains(s);
    return GestureDetector(
      onTap: () => setState(() => on ? _skills.remove(s) : _skills.add(s)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: on ? LinkUpColors.pillGreenBg : Colors.white,
          border: Border.all(color: on ? LinkUpColors.green : LinkUpColors.border),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text((on ? '✓ ' : '') + s,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: on ? LinkUpColors.green : LinkUpColors.textSecondary),
        ),
      ),
    );
  }

  String _typeLabel(String t) => switch (t) {
        'projecto' => 'Projecto fixo',
        'hora' => 'Por hora',
        _ => 'Recorrente',
      };

  String _format(String s) {
    final n = int.tryParse(s) ?? 0;
    final str = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buf.write('.');
      buf.write(str[i]);
    }
    return buf.toString();
  }
}
