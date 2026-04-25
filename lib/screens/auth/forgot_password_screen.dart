import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../shell.dart';
import 'auth_scaffold.dart';
import 'otp_verify_screen.dart';
import 'reset_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final LinkUpRole role;
  const ForgotPasswordScreen({super.key, required this.role});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _email = TextEditingController();
  bool _sent = false;
  bool _busy = false;

  @override
  void dispose() { _email.dispose(); super.dispose(); }

  Future<void> _send() async {
    if (_email.text.trim().isEmpty) return;
    setState(() => _busy = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() { _busy = false; _sent = true; });
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.role == LinkUpRole.freelancer ? LinkUpColors.green : LinkUpColors.navy;
    final btnVariant = widget.role == LinkUpRole.freelancer ? BtnVariant.primary : BtnVariant.navy;
    return AuthScaffold(
      role: widget.role,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 32),
        child: _sent ? _doneState(accent, btnVariant) : _formState(accent, btnVariant),
      ),
    );
  }

  Widget _formState(Color accent, BtnVariant variant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 72, height: 72,
          decoration: BoxDecoration(color: LinkUpColors.cream, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: const Icon(Icons.lock_reset_rounded, size: 36, color: LinkUpColors.gold),
        ),
        const SizedBox(height: 18),
        Text('Esqueceste-te?', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.85, color: accent)),
        const SizedBox(height: 6),
        const Text(
          'Sem problema. Introduz o teu email e enviamos-te um código de recuperação em segundos.',
          style: TextStyle(fontSize: 14, color: LinkUpColors.textSecondary, height: 1.45),
        ),
        const SizedBox(height: 24),
        LuInputField(label: 'Email', value: _email.text, onChanged: (v) { _email.text = v; setState(() {}); },
          icon: Icons.alternate_email, type: TextInputType.emailAddress, placeholder: 'tu@email.com'),
        const SizedBox(height: 22),
        _busy
          ? Container(
              height: 50, alignment: Alignment.center,
              decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(14)),
              child: const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)),
            )
          : LuBtn('Enviar código', variant: variant, full: true, size: BtnSize.lg, icon: Icons.send_rounded, onPressed: _send),
      ],
    );
  }

  Widget _doneState(Color accent, BtnVariant variant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 72, height: 72,
          decoration: const BoxDecoration(color: LinkUpColors.pillGreenBg, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: const Icon(Icons.mark_email_read_outlined, size: 36, color: LinkUpColors.green),
        ),
        const SizedBox(height: 18),
        Text('Verifica o email', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.85, color: accent)),
        const SizedBox(height: 6),
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 14, color: LinkUpColors.textSecondary, height: 1.5),
            children: [
              const TextSpan(text: 'Enviámos um código de 6 dígitos para '),
              TextSpan(text: _email.text, style: const TextStyle(fontWeight: FontWeight.w700, color: LinkUpColors.textPrimary)),
              const TextSpan(text: '. Confere a caixa de entrada e o spam.'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        LuBtn('Já recebi o código', variant: variant, full: true, size: BtnSize.lg, icon: Icons.arrow_forward_rounded,
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (_) => OtpVerifyScreen(
              role: widget.role, email: _email.text,
              purpose: OtpPurpose.resetPassword,
              onSuccess: () => Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (_) => ResetPasswordScreen(role: widget.role),
              )),
            ),
          )),
        ),
        const SizedBox(height: 14),
        Center(
          child: GestureDetector(
            onTap: () => setState(() => _sent = false),
            child: Text('Reenviar código', style: TextStyle(color: accent, fontSize: 13, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }
}
