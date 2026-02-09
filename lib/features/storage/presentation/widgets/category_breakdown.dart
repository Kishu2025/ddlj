import 'package:flutter/material.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';

class CategoryBreakdown extends StatelessWidget {
  const CategoryBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.darkGray,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.neonViolet.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.category,
                color: AppTheme.neonViolet,
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'Category Breakdown',
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
          _CategoryItem(
            icon: Icons.image,
            title: 'Images',
            count: '1,247 files',
            size: '32.5 GB',
            percentage: 38.2,
            color: AppTheme.neonGreen,
          ),
          const SizedBox(height: 16),
          _CategoryItem(
            icon: Icons.video_file,
            title: 'Videos',
            count: '89 files',
            size: '28.3 GB',
            percentage: 33.2,
            color: AppTheme.neonViolet,
          ),
          const SizedBox(height: 16),
          _CategoryItem(
            icon: Icons.music_note,
            title: 'Music',
            count: '432 files',
            size: '12.1 GB',
            percentage: 14.2,
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          _CategoryItem(
            icon: Icons.description,
            title: 'Documents',
            count: '156 files',
            size: '8.7 GB',
            percentage: 10.2,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          _CategoryItem(
            icon: Icons.android,
            title: 'APKs',
            count: '23 files',
            size: '2.8 GB',
            percentage: 3.3,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          _CategoryItem(
            icon: Icons.folder,
            title: 'Other',
            count: '89 files',
            size: '0.8 GB',
            percentage: 0.9,
            color: AppTheme.lightGray,
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String count;
  final String size;
  final double percentage;
  final Color color;

  const _CategoryItem({
    required this.icon,
    required this.title,
    required this.count,
    required this.size,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.pureBlack,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                    Text(
                      count,
                      style: TextStyle(
                        color: AppTheme.lightGray,
                        fontSize: 12,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    size,
                    style: TextStyle(
                      color: color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JetBrainsMono',
                    ),
                  ),
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: color.withOpacity(0.8),
                      fontSize: 12,
                      fontFamily: 'JetBrainsMono',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: AppTheme.mediumGray,
            ),
            child: FractionallySizedBox(
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
