import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../shell.dart';
import 'auth_scaffold.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final LinkUpRole role;
  final VoidCallback onSuccess;
  final VoidCallback onBack;
  const LoginScreen({super.key, required this.role, required this.onSuccess, required this.onBack});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(text: widgetDefaultEmail());
  final _password = TextEditingController(text: '••••••••');
  bool _busy = false;
  String? _error;

  static String widgetDefaultEmail() => 'aida.macuacua@gmail.com';

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn({bool google = false}) async {
    if (!google && _email.text.trim().isEmpty) {
      setState(() => _error = 'Introduz um email válido.');
      return;
    }
    setState(() { _busy = true; _error = null; });
    await Future.delayed(Duration(milliseconds: google ? 1400 : 800));
    if (!mounted) return;
    setState(() => _busy = false);
    widget.onSuccess();
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.role == LinkUpRole.freelancer ? LinkUpColors.green : LinkUpColors.navy;
    final btnVariant = widget.role == LinkUpRole.freelancer ? BtnVariant.primary : BtnVariant.navy;
    return AuthScaffold(
      role: widget.role,
      onBack: widget.onBack,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bem-vinda de volta',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.85, color: accent),
            ),
            const SizedBox(height: 6),
            const Text('Entra na tua conta para continuares.',
              style: TextStyle(fontSize: 14, color: LinkUpColors.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 24),
            LuInputField(label: 'Email', value: _email.text, onChanged: (v) => _email.text = v, icon: Icons.alternate_email, type: TextInputType.emailAddress, placeholder: 'tu@email.com'),
            const SizedBox(height: 14),
            LuPasswordField(label: 'Palavra-passe', controller: _password, placeholder: '••••••••'),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (_) => ForgotPasswordScreen(role: widget.role),
                )),
                child: Text('Esqueci-me da palavra-passe',
                  style: TextStyle(color: accent, fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: LinkUpColors.dangerBg, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, size: 18, color: LinkUpColors.dangerFg),
                    const SizedBox(width: 8),
                    Expanded(child: Text(_error!, style: const TextStyle(fontSize: 12.5, color: LinkUpColors.dangerFg, fontWeight: FontWeight.w600))),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 18),
            _busy
              ? Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(14)),
                  child: const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)),
                )
              : LuBtn('Entrar', variant: btnVariant, full: true, size: BtnSize.lg, icon: Icons.arrow_forward_rounded, onPressed: _signIn),
            const SizedBox(height: 18),
            Row(
              children: [
                const Expanded(child: Divider(color: LinkUpColors.border, thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('ou', style: TextStyle(color: LinkUpColors.textMuted, fontSize: 11.5, fontWeight: FontWeight.w600, letterSpacing: 0.4)),
                ),
                const Expanded(child: Divider(color: LinkUpColors.border, thickness: 1)),
              ],
            ),
            const SizedBox(height: 14),
            LuSocialBtn(provider: SocialProvider.google, onPressed: _busy ? null : () => _signIn(google: true)),
            const SizedBox(height: 26),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (_) => RegisterScreen(role: widget.role, onSuccess: widget.onSuccess, onBack: widget.onBack),
                )),
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 13.5, color: LinkUpColors.textSecondary),
                    children: [
                      const TextSpan(text: 'Não tens conta? '),
                      TextSpan(text: 'Criar conta →', style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
