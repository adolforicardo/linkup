import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _name;
  late TextEditingController _title;
  late TextEditingController _rate;
  late TextEditingController _bio;

  @override
  void initState() {
    super.initState();
    final u = currentFreelancer;
    _name = TextEditingController(text: u.name);
    _title = TextEditingController(text: u.title);
    _rate = TextEditingController(text: '4500');
    _bio = TextEditingController(text: u.bio);
  }

  @override
  void dispose() {
    _name.dispose();
    _title.dispose();
    _rate.dispose();
    _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final u = currentFreelancer;
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Editar perfil',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: [
                LuBtn('Guardar', size: BtnSize.sm, onPressed: () => Navigator.pop(context)),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            LuAvatar(initials: u.avatar, bg: u.avatarBg, size: 88),
                            Positioned(
                              right: 0, bottom: 0,
                              child: Container(
                                width: 30, height: 30,
                                decoration: BoxDecoration(
                                  color: LinkUpColors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 3),
                                ),
                                child: const Icon(Icons.edit, size: 13, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    LuInputField(label: 'Nome completo', value: _name.text, onChanged: (v) => _name.text = v),
                    const SizedBox(height: 14),
                    LuInputField(label: 'Título profissional', value: _title.text, onChanged: (v) => _title.text = v),
                    const SizedBox(height: 14),
                    LuInputField(label: 'Tarifa horária (MZN)', value: _rate.text, onChanged: (v) => _rate.text = v, icon: Icons.account_balance_wallet_outlined),
                    const SizedBox(height: 14),
                    const Text('Bio', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _bio,
                      maxLines: 4,
                      decoration: InputDecoration(
                        filled: true, fillColor: LinkUpColors.surfaceTint,
                        border: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.green), borderRadius: BorderRadius.circular(12)),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      style: const TextStyle(fontSize: 13.5, height: 1.5),
                    ),
                    const SizedBox(height: 14),
                    const Text('Vídeo de apresentação', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                    const SizedBox(height: 6),
                    LuCard(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: LinkUpColors.pillGreenBg, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.videocam_outlined, color: LinkUpColors.green, size: 20),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Apresenta-te em 60s', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                                Text('Aumenta as tuas chances em 3×', style: TextStyle(fontSize: 11, color: LinkUpColors.textMuted)),
                              ],
                            ),
                          ),
                          LuBtn('Gravar', variant: BtnVariant.secondary, size: BtnSize.sm, onPressed: () {}),
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
