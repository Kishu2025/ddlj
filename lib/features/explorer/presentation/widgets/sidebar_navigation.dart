import 'package:flutter/material.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';

class SidebarNavigation extends StatelessWidget {
  final Function(int) onItemSelected;

  const SidebarNavigation({
    super.key,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: AppTheme.darkGray,
        border: Border(
          right: BorderSide(
            color: AppTheme.neonBlue.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.mediumGray,
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.neonBlue.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Icon(
              Icons.menu,
              color: AppTheme.neonBlue,
              size: 24,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _SidebarItem(
                  icon: Icons.star,
                  label: 'Favorites',
                  onTap: () => onItemSelected(0),
                ),
                _SidebarItem(
                  icon: Icons.history,
                  label: 'Recent',
                  onTap: () => onItemSelected(1),
                ),
                _SidebarItem(
                  icon: Icons.storage,
                  label: 'Storage',
                  onTap: () => onItemSelected(2),
                ),
                _SidebarItem(
                  icon: Icons.find_in_page,
                  label: 'Large Files',
                  onTap: () => onItemSelected(3),
                ),
                _SidebarItem(
                  icon: Icons.content_copy,
                  label: 'Duplicates',
                  onTap: () => onItemSelected(4),
                ),
                _SidebarItem(
                  icon: Icons.analytics,
                  label: 'Analyzer',
                  onTap: () => onItemSelected(5),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.mediumGray,
              border: Border(
                top: BorderSide(
                  color: AppTheme.neonBlue.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                _SidebarItem(
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () => onItemSelected(99),
                ),
                const SizedBox(height: 8),
                _SidebarItem(
                  icon: Icons.info,
                  label: 'About',
                  onTap: () => onItemSelected(100),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.pureBlack,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.neonBlue.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: AppTheme.neonBlue,
            size: 20,
          ),
        ),
      ),
    );
  }
}
