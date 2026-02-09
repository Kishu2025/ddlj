import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';
import 'package:neon_file_manager/features/explorer/presentation/widgets/dual_pane_layout.dart';
import 'package:neon_file_manager/features/explorer/presentation/widgets/sidebar_navigation.dart';
import 'package:neon_file_manager/features/explorer/presentation/widgets/top_tab_bar.dart';

class ExplorerPage extends ConsumerStatefulWidget {
  const ExplorerPage({super.key});

  @override
  ConsumerState<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends ConsumerState<ExplorerPage> 
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppTheme.darkGray,
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.neonBlue.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: TopTabBar(
              controller: _tabController,
              selectedIndex: _selectedTabIndex,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SidebarNavigation(
                  onItemSelected: (index) {
                    // Handle sidebar selection
                  },
                ),
                Expanded(
                  child: DualPaneLayout(
                    leftPaneTitle: 'Phone Storage',
                    rightPaneTitle: 'External Storage',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
