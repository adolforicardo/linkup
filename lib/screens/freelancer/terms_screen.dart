import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Termos & Condições',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: [LuIconBtn(icon: Icons.download_rounded, onPressed: () => luSnack(context, 'Documento exportado em PDF.'))],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: LinkUpColors.cream, borderRadius: BorderRadius.circular(12)),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 16, color: LinkUpColors.goldDark),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Última actualização: 15 de Março de 2026 · v2.4',
                              style: TextStyle(fontSize: 12, color: Color(0xFF5C4710), fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    for (final s in termsSections) Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: LinkUpColors.navy, letterSpacing: -0.4)),
                          const SizedBox(height: 8),
                          Text(s.body, style: const TextStyle(fontSize: 13.5, color: LinkUpColors.textSecondary, height: 1.6)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Para questões sobre estes termos, contacta legal@linkup.co.mz.',
                        style: TextStyle(fontSize: 12, color: LinkUpColors.textMuted, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
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
}
