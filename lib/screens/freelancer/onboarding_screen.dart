import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onLogin;
  const OnboardingScreen({super.key, required this.onLogin});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;

  static const _slides = [
    (tag: 'Bem-vinda', title: 'Liga-te às\nmelhores oportunidades', body: 'Encontra projectos que combinam com as tuas competências em todo o país.', accent: LinkUpColors.green),
    (tag: 'Construído com confiança', title: 'Empresas\nverificadas pela Ubuntu', body: 'Cada empresa passa por verificação. Tu trabalhas, tu recebes — sem surpresas.', accent: LinkUpColors.gold),
    (tag: 'Pronta', title: 'Tudo num só sítio.', body: 'Conversas, propostas, contratos e pagamentos no LinkUp.', accent: LinkUpColors.navy),
  ];

  @override
  Widget build(BuildContext context) {
    final s = _slides[_step];
    return Container(
      color: LinkUpColors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          children: [
            Row(
              children: [
                LuLogoMark(background: s.accent),
                const SizedBox(width: 8),
                const LuWordmark(fontSize: 16),
                const Spacer(),
                GestureDetector(
                  onTap: widget.onLogin,
                  child: const Text('Saltar', style: TextStyle(color: LinkUpColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: s.accent,
                borderRadius: BorderRadius.circular(24),
                gradient: RadialGradient(
                  center: const Alignment(-0.4, -0.6),
                  radius: 1.0,
                  colors: [Colors.white.withValues(alpha: 0.15), Colors.transparent],
                ),
              ),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      '0${_step + 1} / 0${_slides.length}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 10,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const Center(child: LuLogoMark(size: 120, background: Colors.transparent)),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Align(
              alignment: Alignment.centerLeft,
              child: LuPill(s.tag, color: PillColor.gold),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: Text(
                s.title,
                style: const TextStyle(fontSize: 30, height: 1.05, fontWeight: FontWeight.w800, letterSpacing: -0.9, color: LinkUpColors.navy),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(s.body, style: const TextStyle(fontSize: 15, height: 1.5, color: LinkUpColors.textSecondary)),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < _slides.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == _step ? 24 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i == _step ? LinkUpColors.green : LinkUpColors.textDisabled,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            if (_step < _slides.length - 1)
              LuBtn('Continuar', variant: BtnVariant.primary, full: true, size: BtnSize.lg, icon: Icons.arrow_forward_rounded, onPressed: () => setState(() => _step++))
            else
              Column(
                children: [
                  LuBtn('Criar conta', variant: BtnVariant.primary, full: true, size: BtnSize.lg, onPressed: widget.onLogin),
                  const SizedBox(height: 10),
                  LuBtn('Já tenho conta', variant: BtnVariant.secondary, full: true, size: BtnSize.lg, onPressed: widget.onLogin),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
