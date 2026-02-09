import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';
import 'package:neon_file_manager/features/storage/presentation/widgets/storage_chart.dart';
import 'package:neon_file_manager/features/storage/presentation/widgets/storage_meter.dart';
import 'package:neon_file_manager/features/storage/presentation/widgets/category_breakdown.dart';

class StorageDashboardPage extends ConsumerWidget {
  const StorageDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      appBar: AppBar(
        title: const Text('Storage Insights'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppTheme.pureBlack,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.darkGray,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.neonBlue.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.storage,
                        color: AppTheme.neonBlue,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Storage Overview',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'JetBrainsMono',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const StorageMeter(),
                  const SizedBox(height: 20),
                  const StorageChart(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const CategoryBreakdown(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.find_in_page,
                    title: 'Large Files',
                    subtitle: 'Find big files',
                    color: AppTheme.neonViolet,
                    onTap: () {
                      // Navigate to large files finder
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.content_copy,
                    title: 'Duplicates',
                    subtitle: 'Clean duplicates',
                    color: AppTheme.neonGreen,
                    onTap: () {
                      // Navigate to duplicate cleaner
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.delete_sweep,
                    title: 'Junk Cleaner',
                    subtitle: 'Remove junk',
                    color: AppTheme.neonRed,
                    onTap: () {
                      // Navigate to junk cleaner
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.sync,
                    title: 'Sync Status',
                    subtitle: 'View sync logs',
                    color: AppTheme.neonBlue,
                    onTap: () {
                      // Navigate to sync status
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.darkGray,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'JetBrainsMono',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: AppTheme.lightGray,
                fontSize: 12,
                fontFamily: 'JetBrainsMono',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
