import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../shell.dart';
import 'auth_scaffold.dart';

enum OtpPurpose { verifyAccount, resetPassword }

class OtpVerifyScreen extends StatefulWidget {
  final LinkUpRole role;
  final String email;
  final OtpPurpose purpose;
  final VoidCallback onSuccess;
  const OtpVerifyScreen({super.key, required this.role, required this.email, required this.purpose, required this.onSuccess});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  String _code = '';
  bool _error = false;
  bool _busy = false;
  int _seconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _seconds = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_seconds <= 0) { _timer?.cancel(); return; }
      setState(() => _seconds--);
    });
  }

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }

  Future<void> _verify() async {
    if (_code.length < 6) return;
    setState(() { _busy = true; _error = false; });
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    // Mock: aceita qualquer código com 6 dígitos diferente de "000000"
    final ok = _code != '000000';
    setState(() { _busy = false; _error = !ok; });
    if (ok) widget.onSuccess();
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.role == LinkUpRole.freelancer ? LinkUpColors.green : LinkUpColors.navy;
    final btnVariant = widget.role == LinkUpRole.freelancer ? BtnVariant.primary : BtnVariant.navy;
    final title = widget.purpose == OtpPurpose.verifyAccount ? 'Confirma o teu email' : 'Confirma a tua identidade';
    final sub = widget.purpose == OtpPurpose.verifyAccount
      ? 'Para activarmos a tua conta, introduz o código que enviámos.'
      : 'Para reiniciar a palavra-passe, introduz o código que enviámos.';
    return AuthScaffold(
      role: widget.role,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(color: LinkUpColors.cream, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: const Icon(Icons.shield_outlined, size: 34, color: LinkUpColors.gold),
            ),
            const SizedBox(height: 18),
            Text(title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.85, color: accent)),
            const SizedBox(height: 6),
            Text.rich(
              TextSpan(
                style: const TextStyle(fontSize: 14, color: LinkUpColors.textSecondary, height: 1.45),
                children: [
                  TextSpan(text: '$sub Enviado para '),
                  TextSpan(text: widget.email, style: const TextStyle(fontWeight: FontWeight.w700, color: LinkUpColors.textPrimary)),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
            const SizedBox(height: 28),
            LuOtpInput(
              error: _error,
              onChanged: (v) => setState(() { _code = v; _error = false; }),
              onCompleted: (v) { _code = v; _verify(); },
            ),
            if (_error) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: LinkUpColors.dangerBg, borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  children: [
                    Icon(Icons.error_outline, size: 18, color: LinkUpColors.dangerFg),
                    SizedBox(width: 8),
                    Expanded(child: Text('Código incorrecto. Tenta novamente.',
                      style: TextStyle(fontSize: 12.5, color: LinkUpColors.dangerFg, fontWeight: FontWeight.w600),
                    )),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 22),
            _busy
              ? Container(
                  height: 50, alignment: Alignment.center,
                  decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(14)),
                  child: const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)),
                )
              : LuBtn('Verificar', variant: btnVariant, full: true, size: BtnSize.lg, icon: Icons.check, onPressed: _code.length == 6 ? _verify : null),
            const SizedBox(height: 18),
            Center(
              child: _seconds > 0
                ? Text('Reenviar código em ${_seconds}s', style: const TextStyle(fontSize: 13, color: LinkUpColors.textMuted))
                : GestureDetector(
                    onTap: _startTimer,
                    child: Text('Reenviar código', style: TextStyle(color: accent, fontSize: 13.5, fontWeight: FontWeight.w700)),
                  ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text('Dica de demo: usa qualquer código de 6 dígitos (excepto 000000)',
                style: TextStyle(fontSize: 11, color: LinkUpColors.textDisabled, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
