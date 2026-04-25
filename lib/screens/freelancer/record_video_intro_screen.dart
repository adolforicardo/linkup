import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';

class RecordVideoIntroScreen extends StatefulWidget {
  const RecordVideoIntroScreen({super.key});

  @override
  State<RecordVideoIntroScreen> createState() => _RecordVideoIntroScreenState();
}

class _RecordVideoIntroScreenState extends State<RecordVideoIntroScreen> {
  bool _recording = false;
  bool _done = false;
  int _seconds = 0;
  Timer? _timer;

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }

  void _toggle() {
    if (_done) {
      setState(() { _done = false; _seconds = 0; });
      return;
    }
    if (_recording) {
      _timer?.cancel();
      setState(() { _recording = false; _done = true; });
    } else {
      setState(() { _recording = true; _seconds = 0; });
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _seconds++);
        if (_seconds >= 60) {
          _timer?.cancel();
          setState(() { _recording = false; _done = true; });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F0D),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.close, size: 19, color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                  if (_recording) Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: LinkUpColors.danger, borderRadius: BorderRadius.circular(999)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Text('REC ${_seconds.toString().padLeft(2, '0')}s', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 38),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 240, height: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _recording ? LinkUpColors.danger : LinkUpColors.gold, width: 3),
                        color: const Color(0xFF161A18),
                      ),
                      child: Icon(
                        _done ? Icons.check_rounded : Icons.person_outline,
                        size: 100, color: _done ? LinkUpColors.gold : Colors.white24,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      _done ? 'Boa! 60 segundos perfeitos.' : (_recording ? 'A gravar…' : 'Pronta para gravares?'),
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _done ? 'Podes voltar a gravar ou guardar para o teu perfil.' : 'Apresenta-te em 60 segundos. Olha para a câmara, sorri, fala devagar.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white60, fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: Column(
                children: [
                  if (!_done)
                    GestureDetector(
                      onTap: _toggle,
                      child: Container(
                        width: 78, height: 78,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _recording ? LinkUpColors.danger : Colors.white,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: Icon(_recording ? Icons.stop : Icons.fiber_manual_record, size: 32, color: _recording ? Colors.white : LinkUpColors.danger),
                      ),
                    )
                  else
                    Row(
                      children: [
                        Expanded(child: LuBtn('Gravar de novo', variant: BtnVariant.secondary, full: true, size: BtnSize.lg, onPressed: _toggle)),
                        const SizedBox(width: 8),
                        Expanded(child: LuBtn('Guardar', variant: BtnVariant.gold, full: true, size: BtnSize.lg, onPressed: () {
                          luSnack(context, 'Vídeo guardado no teu perfil.');
                          Navigator.pop(context);
                        })),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
