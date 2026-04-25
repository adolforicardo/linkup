import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../shell.dart';
import 'auth_scaffold.dart';

class ResetPasswordScreen extends StatefulWidget {
  final LinkUpRole role;
  const ResetPasswordScreen({super.key, required this.role});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  bool _busy = false;
  bool _done = false;

  @override
  void dispose() { _new.dispose(); _confirm.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (_new.text.length < 6 || _new.text != _confirm.text) return;
    setState(() => _busy = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() { _busy = false; _done = true; });
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.role == LinkUpRole.freelancer ? LinkUpColors.green : LinkUpColors.navy;
    final btnVariant = widget.role == LinkUpRole.freelancer ? BtnVariant.primary : BtnVariant.navy;
    return AuthScaffold(
      role: widget.role,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 32),
        child: _done ? _doneState(accent, btnVariant) : _formState(accent, btnVariant),
      ),
    );
  }

  Widget _formState(Color accent, BtnVariant variant) {
    final mismatch = _confirm.text.isNotEmpty && _new.text != _confirm.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 72, height: 72,
          decoration: BoxDecoration(color: LinkUpColors.cream, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: const Icon(Icons.password_rounded, size: 34, color: LinkUpColors.gold),
        ),
        const SizedBox(height: 18),
        Text('Nova palavra-passe', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.85, color: accent)),
        const SizedBox(height: 6),
        const Text('Escolhe algo seguro. Não a partilhes com ninguém.',
          style: TextStyle(fontSize: 14, color: LinkUpColors.textSecondary, height: 1.45),
        ),
        const SizedBox(height: 24),
        LuPasswordField(label: 'Nova palavra-passe', controller: _new),
        const SizedBox(height: 8),
        LuPasswordStrength(password: _new.text),
        const SizedBox(height: 14),
        LuPasswordField(label: 'Confirmar', controller: _confirm),
        if (mismatch) ...[
          const SizedBox(height: 8),
          Text('As palavras-passe não coincidem.', style: TextStyle(fontSize: 12, color: LinkUpColors.danger, fontWeight: FontWeight.w600)),
        ],
        const SizedBox(height: 22),
        _busy
          ? Container(
              height: 50, alignment: Alignment.center,
              decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(14)),
              child: const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)),
            )
          : LuBtn('Guardar', variant: variant, full: true, size: BtnSize.lg, icon: Icons.check,
              onPressed: (_new.text.length >= 6 && _new.text == _confirm.text) ? _submit : null),
      ],
    );
  }

  Widget _doneState(Color accent, BtnVariant variant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80, height: 80,
          decoration: const BoxDecoration(color: LinkUpColors.pillGreenBg, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: const Icon(Icons.check, size: 38, color: LinkUpColors.green),
        ),
        const SizedBox(height: 18),
        Text('Pronto!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.85, color: accent)),
        const SizedBox(height: 6),
        const Text('A tua palavra-passe foi actualizada. Já podes voltar a iniciar sessão.',
          style: TextStyle(fontSize: 14, color: LinkUpColors.textSecondary, height: 1.45),
        ),
        const SizedBox(height: 24),
        LuBtn('Voltar ao login', variant: variant, full: true, size: BtnSize.lg, icon: Icons.arrow_forward_rounded,
          onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
        ),
      ],
    );
  }
}
