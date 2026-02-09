import 'package:flutter/material.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';

class StorageChart extends StatelessWidget {
  const StorageChart({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Images', 'size': 32.5, 'color': AppTheme.neonGreen},
      {'name': 'Videos', 'size': 28.3, 'color': AppTheme.neonViolet},
      {'name': 'Music', 'size': 12.1, 'color': Colors.orange},
      {'name': 'Documents', 'size': 8.7, 'color': Colors.blue},
      {'name': 'APKs', 'size': 2.8, 'color': Colors.green},
      {'name': 'Other', 'size': 0.8, 'color': AppTheme.lightGray},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Storage by Category',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'JetBrainsMono',
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: _PieChart(categories: categories),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 3,
                child: _CategoryLegend(categories: categories),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PieChart extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const _PieChart({required this.categories});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(160, 160),
      painter: _PieChartPainter(categories),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> categories;

  _PieChartPainter(this.categories);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    
    final total = categories.fold<double>(
      0,
      (sum, category) => sum + (category['size'] as double),
    );
    
    double startAngle = -pi / 2;
    
    for (final category in categories) {
      final sweepAngle = (category['size'] as double) / total * 2 * pi;
      
      final paint = Paint()
        ..color = category['color'] as Color
        ..style = PaintingStyle.fill;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      
      // Add neon glow effect
      final glowPaint = Paint()
        ..color = (category['color'] as Color).withOpacity(0.3)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        glowPaint,
      );
      
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CategoryLegend extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const _CategoryLegend({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categories.map((category) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: category['color'] as Color,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: (category['color'] as Color).withOpacity(0.5),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category['name'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
              ),
              Text(
                '${category['size']} GB',
                style: TextStyle(
                  color: (category['color'] as Color),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'JetBrainsMono',
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

import 'dart:math';
