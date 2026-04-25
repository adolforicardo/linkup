import 'package:flutter/material.dart';
import '../../theme.dart';
import 'dashboard_screen.dart';
import 'search_freelancers_screen.dart';
import 'jobs_management_screen.dart';
import 'pipeline_screen.dart';
import 'post_job_screen.dart';
import 'freelancer_detail_screen.dart';
import 'notifications_screen.dart';
import 'profile_tab.dart';
import 'rate_freelancer_screen.dart';
import 'contracts_screen.dart';
import '../freelancer/chat_list_screen.dart';
import '../freelancer/chat_screen.dart';
import '../freelancer/settings_screen.dart';
import '../../shell.dart';

class CompanyShell extends StatefulWidget {
  const CompanyShell({super.key});

  @override
  State<CompanyShell> createState() => _CompanyShellState();
}

class _CompanyShellState extends State<CompanyShell> {
  int _tab = 0;
  static const _tabs = [
    _TabItem(Icons.dashboard_outlined, 'Painel'),
    _TabItem(Icons.search_rounded, 'Talento'),
    _TabItem(Icons.work_outline_rounded, 'Vagas'),
    _TabItem(Icons.chat_bubble_outline_rounded, 'Mensagens', badge: '5'),
    _TabItem(Icons.business_rounded, 'Empresa'),
  ];

  void _push(Widget page) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      CompanyDashboardScreen(
        onJobs: () => setState(() => _tab = 2),
        onSearch: () => setState(() => _tab = 1),
        onPipeline: () => _push(const PipelineScreen()),
        onPost: () => _push(const PostJobScreen()),
        onNotifications: () => _push(const CompanyNotificationsScreen()),
      ),
      SearchFreelancersScreen(onFreelancer: (id) => _push(FreelancerDetailScreen(freelancerId: id))),
      JobsManagementScreen(onPost: () => _push(const PostJobScreen()), onPipeline: () => _push(const PipelineScreen())),
      ChatListScreen(onChat: (id) => _push(ChatScreen(chatId: id))),
      CompanyProfileTab(
        onContracts: () => _push(const ContractsScreen()),
        onRate: () => _push(const RateFreelancerScreen()),
        onSettings: () => _push(const SettingsScreen(role: LinkUpRole.company)),
      ),
    ];

    return Stack(
      children: [
        Positioned.fill(child: IndexedStack(index: _tab, children: pages)),
        Positioned(left: 0, right: 0, bottom: 0, child: _bottomTabBar()),
      ],
    );
  }

  Widget _bottomTabBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 10, 8, 10 + MediaQuery.of(context).padding.bottom * 0.6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        border: const Border(top: BorderSide(color: LinkUpColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < _tabs.length; i++) _tabBtn(i, _tabs[i]),
        ],
      ),
    );
  }

  Widget _tabBtn(int index, _TabItem t) {
    final active = _tab == index;
    final color = active ? LinkUpColors.navy : LinkUpColors.textMuted;
    return GestureDetector(
      onTap: () => setState(() => _tab = index),
      child: Container(
        constraints: const BoxConstraints(minWidth: 56),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(t.icon, size: 22, color: color),
                if (t.badge != null) Positioned(
                  top: -3, right: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(color: LinkUpColors.danger, borderRadius: BorderRadius.circular(8)),
                    constraints: const BoxConstraints(minWidth: 14),
                    alignment: Alignment.center,
                    child: Text(t.badge!, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(t.label, style: TextStyle(fontSize: 10.5, fontWeight: active ? FontWeight.w700 : FontWeight.w500, color: color, letterSpacing: -0.1)),
          ],
        ),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final String label;
  final String? badge;
  const _TabItem(this.icon, this.label, {this.badge});
}
