import 'package:flutter/material.dart';
import '../../theme.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'applications_screen.dart';
import 'chat_list_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'job_detail_screen.dart';
import 'company_profile_screen.dart';
import 'notifications_screen.dart';
import 'wallet_screen.dart';
import 'portfolio_screen.dart';
import 'reviews_screen.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';

class FreelancerShell extends StatefulWidget {
  const FreelancerShell({super.key});
  @override
  State<FreelancerShell> createState() => _FreelancerShellState();
}

class _FreelancerShellState extends State<FreelancerShell> {
  int _tab = 0;
  final _tabs = const [
    _TabItem(Icons.home_rounded, 'Início'),
    _TabItem(Icons.search_rounded, 'Procurar'),
    _TabItem(Icons.work_outline_rounded, 'Candidatu.'),
    _TabItem(Icons.chat_bubble_outline_rounded, 'Mensagens', badge: '3'),
    _TabItem(Icons.person_outline_rounded, 'Perfil'),
  ];

  void _push(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(
        onJob: (id) => _push(JobDetailScreen(jobId: id)),
        onCompany: (id) => _push(CompanyProfileScreen(companyId: id)),
        onSearch: () => setState(() => _tab = 1),
        onNotifications: () => _push(const NotificationsScreen()),
      ),
      SearchScreen(onJob: (id) => _push(JobDetailScreen(jobId: id))),
      ApplicationsScreen(onJob: (id) => _push(JobDetailScreen(jobId: id))),
      ChatListScreen(onChat: (id) => _push(ChatScreen(chatId: id))),
      ProfileScreen(
        onEdit: () => _push(const EditProfileScreen()),
        onPortfolio: () => _push(const PortfolioScreen()),
        onReviews: () => _push(const ReviewsScreen()),
        onSettings: () => _push(const SettingsScreen()),
        onWallet: () => _push(const WalletScreen()),
      ),
    ];

    return Stack(
      children: [
        Positioned.fill(
          child: IndexedStack(index: _tab, children: pages),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _bottomTabBar(LinkUpColors.green),
        ),
      ],
    );
  }

  Widget _bottomTabBar(Color accent) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 10, 8, 10 + MediaQuery.of(context).padding.bottom * 0.6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        border: const Border(top: BorderSide(color: LinkUpColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < _tabs.length; i++) _tabBtn(i, _tabs[i], accent),
        ],
      ),
    );
  }

  Widget _tabBtn(int index, _TabItem t, Color accent) {
    final active = _tab == index;
    final color = active ? accent : LinkUpColors.textMuted;
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
                if (t.badge != null)
                  Positioned(
                    top: -3,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: LinkUpColors.danger,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(minWidth: 14),
                      alignment: Alignment.center,
                      child: Text(
                        t.badge!,
                        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              t.label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: color,
                letterSpacing: -0.1,
              ),
            ),
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
