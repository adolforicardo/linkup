import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
  bool _twoFA = true;
  bool _busy = false;

  @override
  void dispose() { _current.dispose(); _next.dispose(); _confirm.dispose(); super.dispose(); }

  Future<void> _submit() async {
    setState(() => _busy = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _busy = false);
    luSnack(context, 'Palavra-passe actualizada com sucesso.');
    Navigator.pop(context);
  }

  bool get _canSubmit => _current.text.length >= 6 && _next.text.length >= 6 && _next.text == _confirm.text;

  @override
  Widget build(BuildContext context) {
    final mismatch = _confirm.text.isNotEmpty && _next.text != _confirm.text;
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                LuTopBar(
                  title: 'Palavra-passe e segurança',
                  leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 130),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LuSectionTitle('Alterar palavra-passe'),
                        LuPasswordField(label: 'Palavra-passe actual', controller: _current),
                        const SizedBox(height: 14),
                        LuPasswordField(label: 'Nova palavra-passe', controller: _next),
                        const SizedBox(height: 8),
                        LuPasswordStrength(password: _next.text),
                        const SizedBox(height: 14),
                        LuPasswordField(label: 'Confirmar', controller: _confirm),
                        if (mismatch) ...[
                          const SizedBox(height: 8),
                          const Text('As palavras-passe não coincidem.', style: TextStyle(fontSize: 12, color: LinkUpColors.danger, fontWeight: FontWeight.w600)),
                        ],
                        const SizedBox(height: 24),
                        const LuSectionTitle('Segurança extra'),
                        LuCard(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: LuToggleRow(
                            label: 'Autenticação em 2 passos',
                            sub: 'Receberás um código por SMS sempre que entrares de um dispositivo novo.',
                            value: _twoFA,
                            onChanged: (v) => setState(() => _twoFA = v),
                          ),
                        ),
                        const SizedBox(height: 14),
                        LuCard(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.devices_other_rounded, size: 18, color: LinkUpColors.green),
                                  SizedBox(width: 8),
                                  Text('Sessões activas', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              _device('iPhone 15 · Maputo', 'Este dispositivo · agora', true),
                              const LuDivider(margin: 8),
                              _device('MacBook · Maputo', 'há 2h', false),
                              const LuDivider(margin: 8),
                              _device('Browser · Beira', 'há 4 dias', false),
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
                decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xCCFFFFFF), Colors.white])),
                child: _busy
                  ? Container(
                      height: 50, alignment: Alignment.center,
                      decoration: BoxDecoration(color: LinkUpColors.green, borderRadius: BorderRadius.circular(14)),
                      child: const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)),
                    )
                  : LuBtn('Guardar alterações', full: true, size: BtnSize.lg, icon: Icons.check, onPressed: _canSubmit ? _submit : null),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _device(String name, String sub, bool current) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
              Text(sub, style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
            ],
          ),
        ),
        if (current)
          const LuPill('actual', color: PillColor.green, size: PillSize.sm)
        else
          GestureDetector(
            onTap: () => luSnack(context, 'Sessão terminada.'),
            child: const Text('Terminar', style: TextStyle(color: LinkUpColors.danger, fontSize: 11.5, fontWeight: FontWeight.w700)),
          ),
      ],
    );
  }
}
