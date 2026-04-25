import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class WithdrawScreen extends StatefulWidget {
  final int available;
  const WithdrawScreen({super.key, this.available = 128000});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  int _step = 0;
  late int _amount;
  PayoutMethod _method = payoutMethods.first;
  bool _busy = false;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _amount = widget.available;
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

  int get _fee => _method.type == 'bank' ? 25 : 0;
  int get _net => _amount - _fee;

  Future<void> _submit() async {
    setState(() => _busy = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() { _busy = false; _done = true; });
  }

  @override
  Widget build(BuildContext context) {
    if (_done) return _doneScreen();
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                LuTopBar(
                  title: 'Levantar fundos · ${_step + 1}/3',
                  leading: LuIconBtn(icon: Icons.close, onPressed: () => Navigator.pop(context)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Row(
                    children: [
                      for (int i = 0; i < 3; i++) ...[
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: i <= _step ? LinkUpColors.green : LinkUpColors.border,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        if (i < 2) const SizedBox(width: 4),
                      ],
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 130),
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
                      child: _busy
                        ? Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: LinkUpColors.green, borderRadius: BorderRadius.circular(14)),
                            child: const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)),
                          )
                        : LuBtn(
                            _step < 2 ? 'Continuar' : 'Levantar ${_format(_net)} MZN',
                            variant: BtnVariant.primary,
                            size: BtnSize.lg, full: true,
                            icon: _step < 2 ? Icons.arrow_forward_rounded : Icons.check,
                            onPressed: _amount > 0 ? () {
                              if (_step < 2) setState(() => _step++);
                              else _submit();
                            } : null,
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
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [LinkUpColors.green, LinkUpColors.greenDark]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('SALDO DISPONÍVEL', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.0)),
                const SizedBox(height: 6),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(text: _format(widget.available), style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -0.9)),
                    const TextSpan(text: ' MZN', style: TextStyle(color: Colors.white60, fontSize: 16, fontWeight: FontWeight.w600)),
                  ]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Quanto queres levantar?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: LinkUpColors.textSecondary)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: LinkUpColors.border), borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(text: '$_amount'),
                    onChanged: (v) => setState(() => _amount = int.tryParse(v) ?? 0),
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.7, color: LinkUpColors.navy),
                    decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                  ),
                ),
                const Text('MZN', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: LinkUpColors.textMuted)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final p in const [25, 50, 100]) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _amount = (widget.available * p / 100).round()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: LinkUpColors.border), borderRadius: BorderRadius.circular(10)),
                      child: Text('$p%', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: LinkUpColors.navy)),
                    ),
                  ),
                ),
                if (p != 100) const SizedBox(width: 8),
              ],
            ],
          ),
          if (_amount > widget.available) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: LinkUpColors.dangerBg, borderRadius: BorderRadius.circular(10)),
              child: const Row(
                children: [
                  Icon(Icons.error_outline, size: 18, color: LinkUpColors.dangerFg),
                  SizedBox(width: 8),
                  Expanded(child: Text('Excede o saldo disponível.', style: TextStyle(fontSize: 12.5, color: LinkUpColors.dangerFg, fontWeight: FontWeight.w600))),
                ],
              ),
            ),
          ],
        ],
      );
    }
    if (_step == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LuSectionTitle('Para onde?'),
          for (final m in payoutMethods) Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GestureDetector(
              onTap: () => setState(() => _method = m),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: _method.id == m.id ? LinkUpColors.green : LinkUpColors.border, width: _method.id == m.id ? 2 : 1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(color: LinkUpColors.surfaceTint, borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: Text(m.icon, style: const TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.name, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(m.masked, style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                        ],
                      ),
                    ),
                    if (m.primary) const LuPill('principal', color: PillColor.green, size: PillSize.sm),
                    const SizedBox(width: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 22, height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _method.id == m.id ? LinkUpColors.green : LinkUpColors.textDisabled, width: 2),
                      ),
                      child: _method.id == m.id
                        ? Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: LinkUpColors.green, shape: BoxShape.circle)))
                        : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: LinkUpColors.cream, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: const [
                Icon(Icons.info_outline, size: 16, color: LinkUpColors.goldDark),
                SizedBox(width: 8),
                Expanded(child: Text('Levantamentos via M-Pesa são instantâneos e gratuitos.', style: TextStyle(fontSize: 12, color: Color(0xFF5C4710), fontWeight: FontWeight.w600))),
              ],
            ),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LuSectionTitle('Confirma o levantamento'),
        LuCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _row('Valor', '${_format(_amount)} MZN'),
              const LuDivider(margin: 10),
              _row('Método', _method.name + ' · ' + _method.masked),
              const LuDivider(margin: 10),
              _row('Taxa', _fee == 0 ? 'Grátis' : '${_format(_fee)} MZN'),
              const LuDivider(margin: 10),
              _row('Vais receber', '${_format(_net)} MZN', highlight: true),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: LinkUpColors.pillGreenBg, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: const [
              Icon(Icons.shield_outlined, size: 18, color: LinkUpColors.green),
              SizedBox(width: 10),
              Expanded(child: Text('Os fundos chegam à tua conta em segundos via M-Pesa.', style: TextStyle(fontSize: 12, color: LinkUpColors.green, fontWeight: FontWeight.w600))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _row(String l, String v, {bool highlight = false}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(l, style: TextStyle(fontSize: highlight ? 14 : 13, color: highlight ? LinkUpColors.textPrimary : LinkUpColors.textSecondary, fontWeight: highlight ? FontWeight.w700 : FontWeight.w600)),
      Text(v, style: TextStyle(
        fontSize: highlight ? 18 : 13,
        fontWeight: highlight ? FontWeight.w800 : FontWeight.w700,
        color: highlight ? LinkUpColors.green : LinkUpColors.navy,
        letterSpacing: highlight ? -0.4 : 0,
      )),
    ],
  );

  Widget _doneScreen() {
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
                const Text('Levantamento iniciado!', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: LinkUpColors.navy, letterSpacing: -0.5),
                ),
                const SizedBox(height: 10),
                Text(
                  '${_format(_net)} MZN a caminho via ${_method.name}.\nDeves receber em segundos.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: LinkUpColors.textSecondary, height: 1.5),
                ),
                const SizedBox(height: 24),
                LuBtn('Concluir', size: BtnSize.lg, onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
