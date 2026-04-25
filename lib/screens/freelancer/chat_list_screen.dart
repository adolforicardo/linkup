import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class ChatListScreen extends StatefulWidget {
  final void Function(String) onChat;
  const ChatListScreen({super.key, required this.onChat});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    final list = _filter == 'unread' ? chats.where((c) => c.unread > 0).toList() : chats;
    final unreadCount = chats.where((c) => c.unread > 0).length;
    return Column(
      children: [
        LuTopBar(
          title: 'Mensagens',
          large: true,
          actions: [LuIconBtn(icon: Icons.search, onPressed: () {})],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Row(
            children: [
              _filterBtn('all', 'Todas'),
              const SizedBox(width: 6),
              _filterBtn('unread', 'Não lidas · $unreadCount'),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 110),
            itemCount: list.length,
            itemBuilder: (_, i) {
              final c = list[i];
              return GestureDetector(
                onTap: () => widget.onChat(c.id),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      top: i == 0 ? const BorderSide(color: LinkUpColors.border) : BorderSide.none,
                      bottom: const BorderSide(color: LinkUpColors.border),
                    ),
                  ),
                  child: Row(
                    children: [
                      LuAvatar(initials: c.avatar, bg: c.bg, size: 48, online: c.online),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          c.name.split(' · ').first,
                                          maxLines: 1, overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: -0.3, color: LinkUpColors.navy),
                                        ),
                                      ),
                                      if (c.verified) ...[
                                        const SizedBox(width: 4),
                                        const Icon(Icons.verified, size: 12, color: LinkUpColors.gold),
                                      ],
                                    ],
                                  ),
                                ),
                                Text(c.time, style: TextStyle(
                                  fontSize: 11,
                                  color: c.unread > 0 ? LinkUpColors.green : LinkUpColors.textMuted,
                                  fontWeight: c.unread > 0 ? FontWeight.w700 : FontWeight.w500,
                                )),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(c.name.contains(' · ') ? c.name.split(' · ').last : '',
                              style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(c.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: c.unread > 0 ? LinkUpColors.textPrimary : LinkUpColors.textMuted,
                                      fontWeight: c.unread > 0 ? FontWeight.w600 : FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (c.unread > 0) Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(color: LinkUpColors.green, borderRadius: BorderRadius.circular(10)),
                                  constraints: const BoxConstraints(minWidth: 18),
                                  alignment: Alignment.center,
                                  child: Text('${c.unread}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _filterBtn(String key, String label) {
    final on = _filter == key;
    return GestureDetector(
      onTap: () => setState(() => _filter = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: on ? LinkUpColors.green : Colors.white,
          border: Border.all(color: on ? LinkUpColors.green : LinkUpColors.border),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(label, style: TextStyle(color: on ? Colors.white : LinkUpColors.textPrimary, fontSize: 12.5, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
