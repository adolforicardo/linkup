import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class CompanyProfileEditScreen extends StatefulWidget {
  const CompanyProfileEditScreen({super.key});

  @override
  State<CompanyProfileEditScreen> createState() => _CompanyProfileEditScreenState();
}

class _CompanyProfileEditScreenState extends State<CompanyProfileEditScreen> {
  late TextEditingController _name;
  late TextEditingController _industry;
  late TextEditingController _size;
  late TextEditingController _website;
  late TextEditingController _nuit;
  late TextEditingController _bio;

  @override
  void initState() {
    super.initState();
    final c = currentCompany;
    _name = TextEditingController(text: c.name);
    _industry = TextEditingController(text: c.industry);
    _size = TextEditingController(text: c.size);
    _website = TextEditingController(text: 'bancoherc.co.mz');
    _nuit = TextEditingController(text: '400123456');
    _bio = TextEditingController(text: 'Banco Hércules é uma referência em serviços financeiros em Moçambique. Trabalhamos com freelancers em projectos de transformação digital.');
  }

  @override
  void dispose() {
    _name.dispose(); _industry.dispose(); _size.dispose();
    _website.dispose(); _nuit.dispose(); _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = currentCompany;
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Editar perfil da empresa',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: [LuBtn('Guardar', variant: BtnVariant.navy, size: BtnSize.sm, onPressed: () {
                luSnack(context, 'Perfil actualizado.');
                Navigator.pop(context);
              })],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [LinkUpColors.navy, LinkUpColors.navyDark]),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              LuAvatar(initials: c.avatar, bg: LinkUpColors.navyDark, size: 66, ring: true),
                              Positioned(
                                right: 0, bottom: 0,
                                child: GestureDetector(
                                  onTap: () => LuBottomSheet.show(context, title: 'Logo da empresa', actions: [
                                    LuBottomSheetAction(icon: Icons.camera_alt_outlined, label: 'Tirar foto', onTap: () => luSnack(context, 'Câmara aberta.')),
                                    LuBottomSheetAction(icon: Icons.image_outlined, label: 'Galeria', onTap: () => luSnack(context, 'Galeria aberta.')),
                                    LuBottomSheetAction(icon: Icons.delete_outline, label: 'Remover', destructive: true, onTap: () => luSnack(context, 'Logo removido.')),
                                  ]),
                                  child: Container(
                                    width: 28, height: 28,
                                    decoration: BoxDecoration(
                                      color: LinkUpColors.gold,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: LinkUpColors.navy, width: 3),
                                    ),
                                    child: const Icon(Icons.edit, size: 12, color: LinkUpColors.navy),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(c.name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.4)),
                                const SizedBox(height: 2),
                                Text(c.industry, style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                                const SizedBox(height: 6),
                                const LuPill('Verificada Ubuntu', color: PillColor.gold, size: PillSize.sm, icon: Icons.verified),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const LuSectionTitle('Informação'),
                    LuInputField(label: 'Nome', value: _name.text, onChanged: (v) => _name.text = v, icon: Icons.business_outlined),
                    const SizedBox(height: 14),
                    LuInputField(label: 'Indústria', value: _industry.text, onChanged: (v) => _industry.text = v, icon: Icons.category_outlined),
                    const SizedBox(height: 14),
                    LuInputField(label: 'Dimensão', value: _size.text, onChanged: (v) => _size.text = v, icon: Icons.group_outlined),
                    const SizedBox(height: 14),
                    LuInputField(label: 'NUIT', value: _nuit.text, onChanged: (v) => _nuit.text = v, icon: Icons.shield_outlined),
                    const SizedBox(height: 14),
                    LuInputField(label: 'Website', value: _website.text, onChanged: (v) => _website.text = v, icon: Icons.language),
                    const SizedBox(height: 14),
                    const Text('Sobre a empresa', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _bio,
                      maxLines: 4,
                      decoration: InputDecoration(
                        filled: true, fillColor: LinkUpColors.surfaceTint,
                        border: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.navy), borderRadius: BorderRadius.circular(12)),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      style: const TextStyle(fontSize: 13.5, height: 1.5),
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
