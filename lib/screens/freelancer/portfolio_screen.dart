import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';
import 'add_portfolio_item_screen.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LinkUpColors.background,
      body: SafeArea(
        child: Column(
          children: [
            LuTopBar(
              title: 'Portfólio',
              leading: LuIconBtn(icon: Icons.chevron_left, onPressed: () => Navigator.pop(context)),
              actions: [LuIconBtn(icon: Icons.add, onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AddPortfolioItemScreen())))],
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9,
                children: [
                  for (final p in portfolio) LuCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 110,
                              decoration: BoxDecoration(color: p.cover, borderRadius: const BorderRadius.vertical(top: Radius.circular(18))),
                              alignment: Alignment.center,
                              child: Text(p.title.split(' ').first, style: linkupSerif(size: 32, color: p.accent)),
                            ),
                            Positioned(top: 8, left: 8, child: LuPill(p.tag, color: PillColor.gold, size: PillSize.sm)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(p.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, height: 1.3),
                          ),
                        ),
                      ],
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
}
