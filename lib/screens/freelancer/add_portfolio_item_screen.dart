import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class AddPortfolioItemScreen extends StatefulWidget {
  const AddPortfolioItemScreen({super.key});
  @override
  State<AddPortfolioItemScreen> createState() => _AddPortfolioItemScreenState();
}

class _AddPortfolioItemScreenState extends State<AddPortfolioItemScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  String _category = 'Fintech';
  Color _cover = LinkUpColors.green;
  Color _accent = LinkUpColors.gold;

  @override
  void dispose() { _title.dispose(); _description.dispose(); super.dispose(); }

  bool get _canSubmit => _title.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                LuTopBar(
                  title: 'Novo trabalho',
                  leading: LuIconBtn(icon: Icons.close, onPressed: () => Navigator.pop(context)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 130),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LuSectionTitle('Pré-visualização'),
                        Container(
                          height: 160,
                          decoration: BoxDecoration(color: _cover, borderRadius: BorderRadius.circular(16)),
                          alignment: Alignment.center,
                          child: Text(
                            _title.text.isEmpty ? 'Aa' : _title.text.split(' ').first,
                            style: linkupSerif(size: 48, color: _accent),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const LuSectionTitle('Detalhes'),
                        LuInputField(label: 'Título', value: _title.text, onChanged: (v) { _title.text = v; setState(() {}); }, placeholder: 'App de mobile banking — Letshego'),
                        const SizedBox(height: 14),
                        const Text('Categoria', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6, runSpacing: 6,
                          children: [
                            for (final c in portfolioCategories)
                              GestureDetector(
                                onTap: () => setState(() => _category = c),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: _category == c ? LinkUpColors.pillGreenBg : Colors.white,
                                    border: Border.all(color: _category == c ? LinkUpColors.green : LinkUpColors.border),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(c, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _category == c ? LinkUpColors.green : LinkUpColors.textSecondary)),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text('Descrição', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _description,
                          maxLines: 4,
                          decoration: InputDecoration(
                            filled: true, fillColor: LinkUpColors.surfaceTint,
                            hintText: 'Descreve o desafio, a tua abordagem e o resultado…',
                            border: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: LinkUpColors.green), borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          style: const TextStyle(fontSize: 13.5, height: 1.5),
                        ),
                        const SizedBox(height: 18),
                        const LuSectionTitle('Aparência da capa'),
                        const Text('Cor de fundo', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                        const SizedBox(height: 8),
                        _colorPicker(_cover, (c) => setState(() => _cover = c)),
                        const SizedBox(height: 14),
                        const Text('Cor do texto', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: LinkUpColors.textSecondary)),
                        const SizedBox(height: 8),
                        _colorPicker(_accent, (c) => setState(() => _accent = c)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0, right: 0, bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xCCFFFFFF), Colors.white])),
                child: LuBtn('Adicionar ao portfólio',
                  full: true, size: BtnSize.lg, icon: Icons.check,
                  onPressed: _canSubmit ? () {
                    luSnack(context, '"${_title.text}" adicionado ao portfólio.');
                    Navigator.pop(context);
                  } : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorPicker(Color selected, ValueChanged<Color> onTap) {
    return Wrap(
      spacing: 10, runSpacing: 10,
      children: [
        for (final c in portfolioCovers) GestureDetector(
          onTap: () => onTap(c),
          child: Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: c,
              shape: BoxShape.circle,
              border: Border.all(color: c == selected ? LinkUpColors.navy : Colors.transparent, width: 3),
            ),
            child: c == selected ? const Icon(Icons.check, color: Colors.white, size: 18) : null,
          ),
        ),
      ],
    );
  }
}
