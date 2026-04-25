import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../../data.dart';
import 'home_screen.dart';

class SearchScreen extends StatefulWidget {
  final void Function(String) onJob;
  const SearchScreen({super.key, required this.onJob});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';
  String _filter = 'all';
  bool _showFilters = false;
  double _budget = 50;
  final _selectedSkills = <String>{'UI/UX'};
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  List<JobData> _filtered() {
    return jobs.where((j) {
      if (_query.isNotEmpty &&
          !j.title.toLowerCase().contains(_query.toLowerCase()) &&
          !j.company.toLowerCase().contains(_query.toLowerCase())) return false;
      if (_filter == 'urgent') return j.urgent;
      if (_filter == 'match') return j.match >= 85;
      if (_filter == 'remote') return j.location.toLowerCase().contains('remoto');
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered();
    final filters = <(String, String, int)>[
      ('all', 'Tudo', jobs.length),
      ('match', 'Melhor match', 3),
      ('urgent', 'Urgente', jobs.where((j) => j.urgent).length),
      ('remote', 'Remoto', 2),
    ];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(child: Text('Pesquisar', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: -0.4))),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: LinkUpColors.border),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, size: 17, color: LinkUpColors.textMuted),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _ctrl,
                              onChanged: (v) => setState(() => _query = v),
                              decoration: const InputDecoration(
                                hintText: 'Designer, frontend, marketing…',
                                isDense: true,
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: LinkUpColors.textMuted, fontSize: 14),
                              ),
                            ),
                          ),
                          if (_query.isNotEmpty)
                            GestureDetector(
                              onTap: () { _ctrl.clear(); setState(() => _query = ''); },
                              child: const Icon(Icons.close, size: 16, color: LinkUpColors.textMuted),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  LuIconBtn(
                    icon: Icons.tune_rounded,
                    bg: Colors.white,
                    active: _showFilters,
                    onPressed: () => setState(() => _showFilters = !_showFilters),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 6),
                  itemBuilder: (_, i) {
                    final f = filters[i];
                    final on = _filter == f.$1;
                    return GestureDetector(
                      onTap: () => setState(() => _filter = f.$1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: on ? LinkUpColors.green : Colors.white,
                          border: Border.all(color: on ? LinkUpColors.green : LinkUpColors.border),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          children: [
                            Text(f.$2, style: TextStyle(color: on ? Colors.white : LinkUpColors.textPrimary, fontSize: 12.5, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 4),
                            Text('${f.$3}', style: TextStyle(color: (on ? Colors.white : LinkUpColors.textPrimary).withValues(alpha: 0.6), fontSize: 11)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (_showFilters) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: LinkUpColors.border),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Orçamento mínimo · ${(_budget * 10).round()}k MZN',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: LinkUpColors.textSecondary)),
                      Slider(
                        value: _budget,
                        min: 0, max: 100,
                        activeColor: LinkUpColors.green,
                        onChanged: (v) => setState(() => _budget = v),
                      ),
                      const SizedBox(height: 4),
                      const Text('Skills', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: LinkUpColors.textSecondary)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 5, runSpacing: 6,
                        children: [
                          for (final s in ['UI/UX', 'React', 'Marketing', 'Tradução', 'Contabilidade', 'Vídeo'])
                            GestureDetector(
                              onTap: () => setState(() {
                                if (_selectedSkills.contains(s)) _selectedSkills.remove(s);
                                else _selectedSkills.add(s);
                              }),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: _selectedSkills.contains(s) ? LinkUpColors.pillGreenBg : Colors.white,
                                  border: Border.all(color: _selectedSkills.contains(s) ? LinkUpColors.green : LinkUpColors.border),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  s,
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: _selectedSkills.contains(s) ? LinkUpColors.green : LinkUpColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
                  child: Text(
                    '${results.length} oportunidades · ordenadas por match',
                    style: const TextStyle(fontSize: 12.5, color: LinkUpColors.textSecondary, fontWeight: FontWeight.w600),
                  ),
                ),
                if (results.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: Text('Nenhum resultado.', style: TextStyle(color: LinkUpColors.textMuted))),
                  )
                else
                  for (final j in results) Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: JobCard(job: j, onTap: () => widget.onJob(j.id)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
