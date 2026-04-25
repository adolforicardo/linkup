import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Notificações',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Text('Limpar', style: TextStyle(color: LinkUpColors.green, fontWeight: FontWeight.w700, fontSize: 13)),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: notifications.length,
                itemBuilder: (_, i) {
                  final n = notifications[i];
                  return Container(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                    decoration: BoxDecoration(
                      color: n.unread ? LinkUpColors.surfaceTint : Colors.transparent,
                      border: const Border(bottom: BorderSide(color: LinkUpColors.border)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (n.unread) Container(
                          width: 6, height: 6, margin: const EdgeInsets.only(top: 8, right: 8),
                          decoration: const BoxDecoration(color: LinkUpColors.green, shape: BoxShape.circle),
                        ),
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(color: LinkUpColors.pillGreenBg, borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          child: Text(n.icon, style: const TextStyle(fontSize: 18)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(n.title, style: TextStyle(fontSize: 13.5, fontWeight: n.unread ? FontWeight.w700 : FontWeight.w600, height: 1.3)),
                              const SizedBox(height: 2),
                              Text(n.detail, style: const TextStyle(fontSize: 12, color: LinkUpColors.textSecondary, height: 1.4)),
                              const SizedBox(height: 4),
                              Text(n.time, style: const TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
