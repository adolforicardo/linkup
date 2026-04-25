import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String? _expanded;
  String _category = 'Todos';

  @override
  Widget build(BuildContext context) {
    final categories = ['Todos', ...{for (final f in faqArticles) f.category}];
    final filtered = _category == 'Todos' ? faqArticles : faqArticles.where((f) => f.category == _category).toList();
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Suporte LinkUp',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LuSectionTitle('Falar connosco'),
                    Column(
                      children: [
                        for (final c in supportChannels) Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: LuCard(
                            onTap: () => luSnack(context, 'A abrir ${c.label}…'),
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Container(
                                  width: 38, height: 38,
                                  decoration: BoxDecoration(color: LinkUpColors.pillGreenBg, borderRadius: BorderRadius.circular(10)),
                                  child: Icon(c.icon, size: 18, color: LinkUpColors.green),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(c.label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                                      const SizedBox(height: 2),
                                      Text(c.detail, style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                                    ],
                                  ),
                                ),
                                LuPill(c.tag, color: c.tag == 'online' ? PillColor.green : PillColor.neutral, size: PillSize.sm),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const LuSectionTitle('Perguntas frequentes'),
                    SizedBox(
                      height: 32,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 6),
                        itemBuilder: (_, i) {
                          final on = _category == categories[i];
                          return GestureDetector(
                            onTap: () => setState(() => _category = categories[i]),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                              decoration: BoxDecoration(
                                color: on ? LinkUpColors.green : Colors.white,
                                border: Border.all(color: on ? LinkUpColors.green : LinkUpColors.border),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(categories[i], style: TextStyle(color: on ? Colors.white : LinkUpColors.textPrimary, fontSize: 12.5, fontWeight: FontWeight.w600)),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (final f in filtered) Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _expanded = _expanded == f.id ? null : f.id),
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: LinkUpColors.border), borderRadius: BorderRadius.circular(14)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(f.question, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, height: 1.35)),
                                  ),
                                  Icon(_expanded == f.id ? Icons.remove : Icons.add, size: 18, color: LinkUpColors.textMuted),
                                ],
                              ),
                              if (_expanded == f.id) ...[
                                const SizedBox(height: 8),
                                Text(f.answer, style: const TextStyle(fontSize: 13, color: LinkUpColors.textSecondary, height: 1.55)),
                              ],
                            ],
                          ),
                        ),
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
