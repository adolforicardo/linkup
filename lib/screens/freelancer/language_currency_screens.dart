import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selected = 'pt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Idioma',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: const Text(
                'Escolhe o idioma da app. Algumas conversas e documentos podem permanecer no idioma original.',
                style: TextStyle(fontSize: 12.5, color: LinkUpColors.textMuted, height: 1.45),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
                child: LuRadioList<String>(
                  selected: _selected,
                  onChanged: (v) {
                    setState(() => _selected = v);
                    luSnack(context, 'Idioma actualizado.');
                  },
                  items: [
                    for (final l in languages) LuRadioListItem(
                      value: l.code,
                      label: l.label,
                      sub: l.native,
                      icon: Icons.language,
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

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});
  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String _selected = 'MZN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Moeda',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: const Text(
                'Os valores na app são apresentados nesta moeda. As transacções continuam a ser processadas em MZN.',
                style: TextStyle(fontSize: 12.5, color: LinkUpColors.textMuted, height: 1.45),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
                child: LuRadioList<String>(
                  selected: _selected,
                  onChanged: (v) {
                    setState(() => _selected = v);
                    luSnack(context, 'Moeda actualizada.');
                  },
                  items: [
                    for (final c in currencies) LuRadioListItem(
                      value: c.code,
                      label: c.label,
                      sub: '${c.code} · ${c.symbol}',
                      icon: Icons.account_balance_wallet_outlined,
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
