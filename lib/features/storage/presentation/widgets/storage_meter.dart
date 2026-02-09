import 'package:flutter/material.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';

class StorageMeter extends StatelessWidget {
  const StorageMeter({super.key});

  @override
  Widget build(BuildContext context) {
    final totalSpace = 128.0; // GB
    final usedSpace = 85.2; // GB
    final freeSpace = totalSpace - usedSpace;
    final usagePercentage = (usedSpace / totalSpace) * 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Device Storage',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'JetBrainsMono',
              ),
            ),
            Text(
              '${usagePercentage.toStringAsFixed(1)}%',
              style: TextStyle(
                color: usagePercentage > 80 ? AppTheme.neonRed : AppTheme.neonBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'JetBrainsMono',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                AppTheme.darkGray,
                AppTheme.mediumGray,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border: Border.all(
              color: AppTheme.neonBlue.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: usagePercentage / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: usagePercentage > 80
                            ? [AppTheme.neonRed, AppTheme.neonRed.withOpacity(0.7)]
                            : [AppTheme.neonBlue, AppTheme.neonViolet],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (usagePercentage > 80 ? AppTheme.neonRed : AppTheme.neonBlue).withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _StorageInfo(
              label: 'Used',
              value: '${usedSpace.toStringAsFixed(1)} GB',
              color: usagePercentage > 80 ? AppTheme.neonRed : AppTheme.neonBlue,
            ),
            _StorageInfo(
              label: 'Free',
              value: '${freeSpace.toStringAsFixed(1)} GB',
              color: AppTheme.neonGreen,
            ),
            _StorageInfo(
              label: 'Total',
              value: '${totalSpace.toStringAsFixed(1)} GB',
              color: AppTheme.lightGray,
            ),
          ],
        ),
      ],
    );
  }
}

class _StorageInfo extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StorageInfo({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppTheme.lightGray,
            fontSize: 12,
            fontFamily: 'JetBrainsMono',
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'JetBrainsMono',
          ),
        ),
      ],
    );
  }
}
