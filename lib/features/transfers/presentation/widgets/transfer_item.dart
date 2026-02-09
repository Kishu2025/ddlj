import 'package:flutter/material.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';

enum TransferStatus {
  queued,
  active,
  paused,
  completed,
  failed,
}

class TransferItem extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final double progress;
  final TransferStatus status;
  final String? speed;

  const TransferItem({
    super.key,
    required this.fileName,
    required this.fileSize,
    required this.progress,
    required this.status,
    this.speed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkGray,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getStatusColor().withOpacity(0.3),
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
                  color: _getStatusColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  _getStatusIcon(),
                  color: _getStatusColor(),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                    Text(
                      fileSize,
                      style: TextStyle(
                        color: AppTheme.lightGray,
                        fontSize: 12,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ],
                ),
              ),
              if (speed != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      speed!,
                      style: TextStyle(
                        color: AppTheme.neonGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                    Text(
                      '${(progress * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: _getStatusColor(),
                        fontSize: 12,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: _getStatusColor(),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _getStatusText(),
                    style: TextStyle(
                      color: _getStatusColor(),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JetBrainsMono',
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (status == TransferStatus.active || status == TransferStatus.completed) ...[
            const SizedBox(height: 12),
            Container(
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: AppTheme.mediumGray,
              ),
              child: FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: LinearGradient(
                      colors: [
                        _getStatusColor(),
                        _getStatusColor().withOpacity(0.7),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getStatusColor().withOpacity(0.5),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          if (status == TransferStatus.active) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    // Pause transfer
                  },
                  icon: Icon(
                    Icons.pause,
                    color: AppTheme.neonViolet,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Cancel transfer
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppTheme.neonRed,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case TransferStatus.queued:
        return AppTheme.lightGray;
      case TransferStatus.active:
        return AppTheme.neonBlue;
      case TransferStatus.paused:
        return AppTheme.neonViolet;
      case TransferStatus.completed:
        return AppTheme.neonGreen;
      case TransferStatus.failed:
        return AppTheme.neonRed;
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case TransferStatus.queued:
        return Icons.schedule;
      case TransferStatus.active:
        return Icons.file_download;
      case TransferStatus.paused:
        return Icons.pause_circle;
      case TransferStatus.completed:
        return Icons.check_circle;
      case TransferStatus.failed:
        return Icons.error;
    }
  }

  String _getStatusText() {
    switch (status) {
      case TransferStatus.queued:
        return 'QUEUED';
      case TransferStatus.active:
        return 'ACTIVE';
      case TransferStatus.paused:
        return 'PAUSED';
      case TransferStatus.completed:
        return 'COMPLETED';
      case TransferStatus.failed:
        return 'FAILED';
    }
  }
}
