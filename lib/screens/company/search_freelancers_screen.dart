import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';

class SearchFreelancersScreen extends StatefulWidget {
  final void Function(String) onFreelancer;
  const SearchFreelancersScreen({super.key, required this.onFreelancer});

  @override
  State<SearchFreelancersScreen> createState() => _SearchFreelancersScreenState();
}

class _SearchFreelancersScreenState extends State<SearchFreelancersScreen> {
  String _query = '';
  String _sort = 'match';
  bool _verified = false;
  bool _available = false;
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  List<FreelancerCardData> _list() {
    var l = [...freelancers];
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      l = l.where((f) =>
          f.name.toLowerCase().contains(q) ||
          f.title.toLowerCase().contains(q) ||
          f.skills.any((s) => s.toLowerCase().contains(q))).toList();
    }
    if (_verified) l = l.where((f) => f.verified).toList();
    if (_available) l = l.where((f) => f.available).toList();
    if (_sort == 'match') l.sort((a, b) => b.match.compareTo(a.match));
    if (_sort == 'rating') l.sort((a, b) => b.rating.compareTo(a.rating));
    if (_sort == 'rate') l.sort((a, b) => a.rate.compareTo(b.rate));
    return l;
  }

  @override
  Widget build(BuildContext context) {
    final list = _list();
    return Column(
      children: [
        const LuTopBar(title: 'Pesquisar talento'),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: LinkUpColors.border), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 17, color: LinkUpColors.textMuted),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        onChanged: (v) => setState(() => _query = v),
                        decoration: const InputDecoration(
                          hintText: 'Nome, skill, área…',
                          isDense: true,
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: LinkUpColors.textMuted, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final s in const [('match', 'Top match'), ('rating', 'Melhor avaliado'), ('rate', 'Tarifa')])
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: _sortBtn(s.$1, s.$2),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: _toggleChip(
                        'Verificado',
                        _verified,
                        () => setState(() => _verified = !_verified),
                        icon: Icons.verified, accent: LinkUpColors.gold, accentBg: LinkUpColors.cream, accentFg: LinkUpColors.goldDark,
                      ),
                    ),
                    _toggleChip(
                      '● Disponível',
                      _available,
                      () => setState(() => _available = !_available),
                      accent: LinkUpColors.green, accentBg: LinkUpColors.pillGreenBg, accentFg: LinkUpColors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text('${list.length} freelancers encontrados',
                    style: const TextStyle(fontSize: 12, color: LinkUpColors.textSecondary, fontWeight: FontWeight.w600),
                  ),
                ),
                if (list.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: Text('Nenhum freelancer encontrado.', style: TextStyle(color: LinkUpColors.textMuted))),
                  )
                else
                  for (int i = 0; i < list.length; i++) Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: FreelancerSummaryCard(f: list[i], rank: i + 1, onTap: () => widget.onFreelancer(list[i].id)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _sortBtn(String key, String label) {
    final on = _sort == key;
    return GestureDetector(
      onTap: () => setState(() => _sort = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
          color: on ? LinkUpColors.navy : Colors.white,
          border: Border.all(color: on ? LinkUpColors.navy : LinkUpColors.border),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(label, style: TextStyle(color: on ? Colors.white : LinkUpColors.textPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _toggleChip(String label, bool on, VoidCallback onTap, {IconData? icon, required Color accent, required Color accentBg, required Color accentFg}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
          color: on ? accentBg : Colors.white,
          border: Border.all(color: on ? accent : LinkUpColors.border),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 11, color: on ? accentFg : LinkUpColors.textSecondary),
              const SizedBox(width: 4),
            ],
            Text(label, style: TextStyle(color: on ? accentFg : LinkUpColors.textPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class FreelancerSummaryCard extends StatelessWidget {
  final FreelancerCardData f;
  final int rank;
  final VoidCallback? onTap;
  const FreelancerSummaryCard({super.key, required this.f, required this.rank, this.onTap});

  @override
  Widget build(BuildContext context) {
    return LuCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              LuAvatar(initials: f.avatar, bg: f.bg, size: 48, online: f.available),
              if (rank <= 3) Positioned(
                top: -4, left: -4,
                child: Container(
                  width: 18, height: 18,
                  decoration: const BoxDecoration(color: LinkUpColors.gold, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text('$rank', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: LinkUpColors.navy)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(f.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, letterSpacing: -0.3),
                                ),
                              ),
                              if (f.verified) ...[
                                const SizedBox(width: 4),
                                const Icon(Icons.verified, size: 13, color: LinkUpColors.gold),
                              ],
                            ],
                          ),
                          const SizedBox(height: 1),
                          Text(f.title, style: const TextStyle(fontSize: 12, color: LinkUpColors.textSecondary)),
                        ],
                      ),
                    ),
                    LuPill('${f.match}%', color: PillColor.green, size: PillSize.sm, icon: Icons.auto_awesome),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    LuStars(value: f.rating, size: 11),
                    const SizedBox(width: 6),
                    Text('· ${f.reviews} reviews · ${f.city}',
                      style: const TextStyle(fontSize: 11, color: LinkUpColors.textMuted, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(spacing: 4, runSpacing: 4, children: [for (final s in f.skills.take(3)) LuPill(s, color: PillColor.neutral, size: PillSize.sm)]),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${_format(f.rate)} MZN/h',
                      style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: LinkUpColors.navy),
                    ),
                    LuPill(f.level, color: PillColor.gold, size: PillSize.sm),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _format(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}
