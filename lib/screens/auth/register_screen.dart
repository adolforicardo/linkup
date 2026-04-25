import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../shell.dart';
import 'auth_scaffold.dart';
import 'login_screen.dart';
import 'otp_verify_screen.dart';

class RegisterScreen extends StatefulWidget {
  final LinkUpRole role;
  final VoidCallback onSuccess;
  final VoidCallback onBack;
  const RegisterScreen({super.key, required this.role, required this.onSuccess, required this.onBack});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _step = 0;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  // freelancer
  final _title = TextEditingController();
  final _city = TextEditingController(text: 'Maputo');
  final _rate = TextEditingController(text: '4500');

  // company
  final _companyName = TextEditingController();
  final _nuit = TextEditingController();
  String _industry = 'Serviços Financeiros';
  String _size = '11–50';

  bool _accepted = false;
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _title.dispose();
    _city.dispose();
    _rate.dispose();
    _companyName.dispose();
    _nuit.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _busy = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _busy = false);
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (_) => OtpVerifyScreen(
        role: widget.role,
        email: _email.text.isEmpty ? 'tu@email.com' : _email.text,
        purpose: OtpPurpose.verifyAccount,
        onSuccess: widget.onSuccess,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.role == LinkUpRole.freelancer ? LinkUpColors.green : LinkUpColors.navy;
    final btnVariant = widget.role == LinkUpRole.freelancer ? BtnVariant.primary : BtnVariant.navy;
    return AuthScaffold(
      role: widget.role,
      onBack: () {
        if (_step > 0) setState(() => _step--);
        else widget.onBack();
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 3; i++) ...[
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: i <= _step ? accent : LinkUpColors.border,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      if (i < 2) const SizedBox(width: 4),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'PASSO ${_step + 1} DE 3',
                  style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted, fontWeight: FontWeight.w700, letterSpacing: 1.0),
                ),
                const SizedBox(height: 14),
                Text(_titleForStep,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.7, color: accent),
                ),
                const SizedBox(height: 4),
                Text(_subtitleForStep,
                  style: const TextStyle(fontSize: 13.5, color: LinkUpColors.textSecondary, height: 1.4),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 130),
              child: _stepBody(accent),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: _busy
                ? Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(14)),
                    child: const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)),
                  )
                : LuBtn(
                    _step < 2 ? 'Continuar' : 'Criar conta',
                    variant: btnVariant, full: true, size: BtnSize.lg,
                    icon: _step < 2 ? Icons.arrow_forward_rounded : Icons.check,
                    onPressed: _canContinue ? () {
                      if (_step < 2) setState(() => _step++);
                      else _submit();
                    } : null,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  String get _titleForStep {
    if (_step == 0) return 'Cria a tua conta';
    if (_step == 1) {
      return widget.role == LinkUpRole.freelancer ? 'Conta-nos sobre ti' : 'Conta-nos sobre a empresa';
    }
    return 'Quase lá';
  }

  String get _subtitleForStep {
    if (_step == 0) return 'Começa pelo essencial. Demora < 30 segundos.';
    if (_step == 1) {
      return widget.role == LinkUpRole.freelancer
        ? 'Estes dados ajudam-nos a sugerir vagas que combinam contigo.'
        : 'Estes dados ajudam-nos a sugerir o talento certo.';
    }
    return 'Confirma os termos para finalizar o registo.';
  }

  bool get _canContinue {
    if (_step == 0) return _name.text.isNotEmpty && _email.text.isNotEmpty && _password.text.length >= 6;
    if (_step == 1) {
      if (widget.role == LinkUpRole.freelancer) return _title.text.isNotEmpty;
      return _companyName.text.isNotEmpty && _nuit.text.length >= 8;
    }
    return _accepted;
  }

  Widget _stepBody(Color accent) {
    if (_step == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuInputField(label: 'Nome completo', value: _name.text, onChanged: (v) { _name.text = v; setState(() {}); }, icon: Icons.person_outline, placeholder: 'Aida Macuácua'),
          const SizedBox(height: 14),
          LuInputField(label: 'Email', value: _email.text, onChanged: (v) { _email.text = v; setState(() {}); }, icon: Icons.alternate_email, type: TextInputType.emailAddress, placeholder: 'tu@email.com'),
          const SizedBox(height: 14),
          LuPasswordField(label: 'Palavra-passe', controller: _password, placeholder: 'Mínimo 6 caracteres'),
          const SizedBox(height: 8),
          LuPasswordStrength(password: _password.text),
          const SizedBox(height: 18),
          Row(
            children: [
              const Expanded(child: Divider(color: LinkUpColors.border, thickness: 1)),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('ou', style: TextStyle(color: LinkUpColors.textMuted, fontSize: 11.5, fontWeight: FontWeight.w600))),
              const Expanded(child: Divider(color: LinkUpColors.border, thickness: 1)),
            ],
          ),
          const SizedBox(height: 14),
          LuSocialBtn(provider: SocialProvider.google, onPressed: () async {
            await Future.delayed(const Duration(milliseconds: 1200));
            if (!mounted) return;
            widget.onSuccess();
          }),
          const SizedBox(height: 22),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (_) => LoginScreen(role: widget.role, onSuccess: widget.onSuccess, onBack: widget.onBack),
              )),
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(fontSize: 13.5, color: LinkUpColors.textSecondary),
                  children: [
                    const TextSpan(text: 'Já tens conta? '),
                    TextSpan(text: 'Iniciar sessão →', style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    if (_step == 1) {
      if (widget.role == LinkUpRole.freelancer) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LuInputField(label: 'Título profissional', value: _title.text, onChanged: (v) { _title.text = v; setState(() {}); }, icon: Icons.badge_outlined, placeholder: 'Designer de produto sénior'),
            const SizedBox(height: 14),
            LuInputField(label: 'Cidade', value: _city.text, onChanged: (v) => _city.text = v, icon: Icons.location_on_outlined),
            const SizedBox(height: 14),
            LuInputField(label: 'Tarifa horária (MZN)', value: _rate.text, onChanged: (v) => _rate.text = v, icon: Icons.account_balance_wallet_outlined, type: TextInputType.number),
            const SizedBox(height: 14),
            const Text('Áreas em que trabalhas', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6, runSpacing: 6,
              children: [
                for (final s in const ['Design', 'Desenvolvimento', 'Marketing', 'Tradução', 'Contabilidade', 'Vídeo', 'Foto', 'Consultoria'])
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: LinkUpColors.border), borderRadius: BorderRadius.circular(999)),
                    child: Text(s, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                  ),
              ],
            ),
          ],
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuInputField(label: 'Nome da empresa', value: _companyName.text, onChanged: (v) { _companyName.text = v; setState(() {}); }, icon: Icons.business_outlined, placeholder: 'Banco Hércules'),
          const SizedBox(height: 14),
          LuInputField(label: 'NUIT', value: _nuit.text, onChanged: (v) { _nuit.text = v; setState(() {}); }, icon: Icons.shield_outlined, type: TextInputType.number, placeholder: '400 123 456'),
          const SizedBox(height: 14),
          const Text('Indústria', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6, runSpacing: 6,
            children: [
              for (final s in const ['Serviços Financeiros', 'Tecnologia', 'Agricultura', 'Saúde', 'Telecom', 'Retalho', 'Educação', 'Outro'])
                GestureDetector(
                  onTap: () => setState(() => _industry = s),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: _industry == s ? LinkUpColors.pillNavyBg : Colors.white,
                      border: Border.all(color: _industry == s ? LinkUpColors.navy : LinkUpColors.border),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(s, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _industry == s ? LinkUpColors.navy : LinkUpColors.textSecondary)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          const Text('Dimensão', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final s in const ['1–10', '11–50', '51–250', '250+']) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _size = s),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        color: _size == s ? LinkUpColors.pillNavyBg : Colors.white,
                        border: Border.all(color: _size == s ? LinkUpColors.navy : LinkUpColors.border),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(s, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
                if (s != '250+') const SizedBox(width: 6),
              ],
            ],
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: LinkUpColors.border), borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Resumo', style: TextStyle(fontSize: 11, color: LinkUpColors.textMuted, fontWeight: FontWeight.w700, letterSpacing: 0.88)),
              const SizedBox(height: 8),
              _kv('Nome', _name.text.isEmpty ? '—' : _name.text),
              _kv('Email', _email.text.isEmpty ? '—' : _email.text),
              if (widget.role == LinkUpRole.freelancer) ...[
                _kv('Título', _title.text.isEmpty ? '—' : _title.text),
                _kv('Cidade', _city.text),
                _kv('Tarifa', '${_rate.text} MZN/h'),
              ] else ...[
                _kv('Empresa', _companyName.text.isEmpty ? '—' : _companyName.text),
                _kv('NUIT', _nuit.text.isEmpty ? '—' : _nuit.text),
                _kv('Indústria', _industry),
                _kv('Dimensão', '$_size colaboradores'),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => setState(() => _accepted = !_accepted),
          behavior: HitTestBehavior.opaque,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 22, height: 22,
                decoration: BoxDecoration(
                  color: _accepted ? accent : Colors.transparent,
                  border: Border.all(color: _accepted ? accent : LinkUpColors.borderStrong, width: 2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: _accepted ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 13, color: LinkUpColors.textSecondary, height: 1.45),
                    children: [
                      const TextSpan(text: 'Aceito os '),
                      TextSpan(text: 'Termos & Condições', style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
                      const TextSpan(text: ' e a '),
                      TextSpan(text: 'Política de Privacidade', style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
                      const TextSpan(text: ' do LinkUp.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _kv(String k, String v) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 90, child: Text(k, style: const TextStyle(fontSize: 12, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600))),
        Expanded(child: Text(v, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: LinkUpColors.navy))),
      ],
    ),
  );
}
