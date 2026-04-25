import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<MessageData> _messages;
  final _ctrl = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _messages = [...messagesCh1];
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(MessageData('me', text, 'agora'));
      _ctrl.clear();
    });
    _scrollToBottom();
    Future.delayed(const Duration(milliseconds: 1100), () {
      if (!mounted) return;
      setState(() => _messages.add(const MessageData('them', 'Recebido! Vou rever e dou-te feedback ainda hoje.', 'agora')));
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = chats.firstWhere((x) => x.id == widget.chatId, orElse: () => chats.first);
    return Scaffold(
      backgroundColor: LinkUpColors.surfaceTint,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: LinkUpColors.border)),
              ),
              child: Row(
                children: [
                  LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
                  const SizedBox(width: 10),
                  LuAvatar(initials: c.avatar, bg: c.bg, size: 38, online: c.online),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(c.name.split(' · ').first, maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: -0.3),
                              ),
                            ),
                            if (c.verified) ...[
                              const SizedBox(width: 4),
                              const Icon(Icons.verified, size: 13, color: LinkUpColors.gold),
                            ],
                          ],
                        ),
                        Text(
                          c.online ? '● online agora' : 'visto há 3h',
                          style: TextStyle(
                            fontSize: 11,
                            color: c.online ? LinkUpColors.success : LinkUpColors.textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  LuIconBtn(icon: Icons.more_horiz, onPressed: () => LuBottomSheet.show(context, title: 'Conversa', actions: [
                    LuBottomSheetAction(icon: Icons.notifications_off_outlined, label: 'Silenciar', onTap: () => luSnack(context, 'Conversa silenciada por 8 horas.')),
                    LuBottomSheetAction(icon: Icons.archive_outlined, label: 'Arquivar', onTap: () { luSnack(context, 'Conversa arquivada.'); Navigator.pop(context); }),
                    LuBottomSheetAction(icon: Icons.search_rounded, label: 'Pesquisar nesta conversa', onTap: () => luSnack(context, 'Pesquisa na conversa.')),
                    LuBottomSheetAction(icon: Icons.report_outlined, label: 'Reportar', destructive: true, onTap: () => luSnack(context, 'Reporte enviado à equipa de moderação.')),
                  ])),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: _scroll,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(999)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock_outline, size: 11, color: LinkUpColors.textMuted),
                          SizedBox(width: 6),
                          Text('Conversas seguras dentro do LinkUp',
                            style: TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(999)),
                      child: const Text('Hoje', style: TextStyle(fontSize: 10.5, color: LinkUpColors.textMuted)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (final m in _messages) _bubble(m),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: LinkUpColors.border)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => LuBottomSheet.show(context, title: 'Anexar', actions: [
                      LuBottomSheetAction(icon: Icons.image_outlined, label: 'Foto / vídeo', sub: 'Galeria', onTap: () => luSnack(context, 'Galeria aberta.')),
                      LuBottomSheetAction(icon: Icons.insert_drive_file_outlined, label: 'Ficheiro', sub: 'PDF, DOCX, ZIP', onTap: () => luSnack(context, 'Selecciona um ficheiro.')),
                      LuBottomSheetAction(icon: Icons.account_balance_wallet_outlined, label: 'Cotação M-Pesa', onTap: () => luSnack(context, 'Cotação enviada.')),
                      LuBottomSheetAction(icon: Icons.description_outlined, label: 'Anexar contrato', onTap: () => luSnack(context, 'Contrato anexado.')),
                    ]),
                    child: Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.attach_file, size: 18, color: LinkUpColors.textSecondary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: LinkUpColors.surfaceTint,
                        border: Border.all(color: LinkUpColors.border),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _ctrl,
                              onSubmitted: (_) => _send(),
                              decoration: const InputDecoration(
                                hintText: 'Escreve uma mensagem…',
                                isDense: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: LinkUpColors.textMuted, fontSize: 14),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => luSnack(context, 'Mantém pressionado para gravar áudio.', icon: Icons.mic_rounded),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(Icons.mic_none_rounded, size: 18, color: LinkUpColors.textMuted),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _send,
                    child: Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(color: LinkUpColors.green, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.send_rounded, size: 17, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bubble(MessageData m) {
    final me = m.from == 'me';
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
              decoration: BoxDecoration(
                color: me ? LinkUpColors.green : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(me ? 16 : 4),
                  bottomRight: Radius.circular(me ? 4 : 16),
                ),
                border: me ? null : Border.all(color: LinkUpColors.border),
                boxShadow: [
                  BoxShadow(
                    color: me ? LinkUpColors.green.withValues(alpha: 0.18) : Colors.black.withValues(alpha: 0.03),
                    blurRadius: me ? 8 : 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(m.text, style: TextStyle(color: me ? Colors.white : LinkUpColors.textPrimary, fontSize: 13.5, height: 1.4)),
                  const SizedBox(height: 3),
                  Text(m.time, style: TextStyle(color: me ? Colors.white70 : LinkUpColors.textMuted, fontSize: 9.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
