import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  late List<TeamMember> _members;

  @override
  void initState() {
    super.initState();
    _members = List<TeamMember>.from(teamMembers);
  }

  void _showInvite() {
    final emailCtrl = TextEditingController();
    String role = 'Recruiter';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(sheetCtx).viewInsets.bottom),
        child: StatefulBuilder(
          builder: (_, setSheet) => Container(
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: LinkUpColors.borderStrong, borderRadius: BorderRadius.circular(2)))),
                const SizedBox(height: 14),
                const Text('Convidar membro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.4)),
                const SizedBox(height: 4),
                const Text('Vamos enviar um convite por email com o link de acesso.', style: TextStyle(fontSize: 12.5, color: LinkUpColors.textMuted)),
                const SizedBox(height: 16),
                LuInputField(label: 'Email', value: emailCtrl.text, onChanged: (v) => emailCtrl.text = v, icon: Icons.alternate_email, type: TextInputType.emailAddress, placeholder: 'membro@empresa.com'),
                const SizedBox(height: 14),
                const Text('Papel', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                const SizedBox(height: 6),
                ...teamRoles.entries.map((e) => GestureDetector(
                  onTap: () => setSheet(() => role = e.key),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 22, height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: role == e.key ? LinkUpColors.navy : LinkUpColors.textDisabled, width: 2),
                          ),
                          child: role == e.key
                            ? Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: LinkUpColors.navy, shape: BoxShape.circle)))
                            : null,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.key, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
                              Text(e.value, style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: 16),
                LuBtn('Enviar convite', variant: BtnVariant.navy, full: true, size: BtnSize.lg, icon: Icons.send_rounded,
                  onPressed: () {
                    Navigator.pop(sheetCtx);
                    luSnack(context, 'Convite enviado para ${emailCtrl.text.isEmpty ? "o email" : emailCtrl.text}.');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMemberOptions(TeamMember m) {
    if (m.isOwner) {
      luSnack(context, 'Não podes alterar o owner.', icon: Icons.lock_outline);
      return;
    }
    LuBottomSheet.show(context, title: m.name, actions: [
      LuBottomSheetAction(icon: Icons.swap_horiz_rounded, label: 'Mudar papel',
        sub: 'Actualmente: ${m.role}',
        onTap: () => luSnack(context, 'Papel actualizado.'),
      ),
      LuBottomSheetAction(icon: Icons.message_outlined, label: 'Enviar mensagem', onTap: () => luSnack(context, 'A abrir conversa…')),
      LuBottomSheetAction(icon: Icons.person_remove_outlined, label: 'Remover da equipa', destructive: true,
        onTap: () async {
          final ok = await LuConfirmDialog.show(context,
            title: 'Remover ${m.name}?',
            message: 'Vai perder acesso imediato à conta da empresa. Esta acção pode ser desfeita.',
            confirmLabel: 'Remover', destructive: true,
          );
          if (ok) {
            setState(() => _members.removeWhere((x) => x.id == m.id));
            if (mounted) luSnack(context, '${m.name} removido.');
          }
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Equipa & permissões',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: [LuIconBtn(icon: Icons.person_add_alt_1_outlined, onPressed: _showInvite, bg: LinkUpColors.navy, color: Colors.white)],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: LinkUpColors.pillNavyBg, borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.group_rounded, size: 22, color: LinkUpColors.navy),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${_members.length} membros activos', style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 1),
                                const Text('Plano Empresa · até 10 membros incluídos', style: TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const LuSectionTitle('Membros'),
                    for (final m in _members) Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: LuCard(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            LuAvatar(initials: m.avatar, bg: m.bg, size: 44),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(child: Text(m.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700))),
                                      if (m.isOwner) ...[
                                        const SizedBox(width: 6),
                                        const LuPill('owner', color: PillColor.gold, size: PillSize.sm),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 1),
                                  Text(m.email, style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textMuted)),
                                  const SizedBox(height: 6),
                                  LuPill(m.role, color: switch (m.role) {
                                    'Admin' => PillColor.navy,
                                    'Recruiter' => PillColor.green,
                                    'Finanças' => PillColor.gold,
                                    _ => PillColor.neutral,
                                  }, size: PillSize.sm),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _showMemberOptions(m),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.more_horiz, size: 20, color: LinkUpColors.textMuted),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const LuSectionTitle('Papéis'),
                    Container(
                      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: LinkUpColors.border), borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: [
                          for (int i = 0; i < teamRoles.length; i++) ...[
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.check_circle_rounded, size: 16, color: LinkUpColors.green),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(teamRoles.keys.elementAt(i), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                                        const SizedBox(height: 2),
                                        Text(teamRoles.values.elementAt(i), style: const TextStyle(fontSize: 11.5, color: LinkUpColors.textSecondary, height: 1.4)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (i < teamRoles.length - 1) const Divider(height: 1, color: LinkUpColors.border, indent: 14, endIndent: 14),
                          ],
                        ],
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
