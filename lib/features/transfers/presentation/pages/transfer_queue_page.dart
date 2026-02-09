import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';
import 'package:neon_file_manager/features/transfers/presentation/widgets/transfer_item.dart';

class TransferQueuePage extends ConsumerWidget {
  const TransferQueuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      appBar: AppBar(
        title: const Text('Transfer Queue'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppTheme.pureBlack,
        actions: [
          IconButton(
            onPressed: () {
              // Clear completed transfers
            },
            icon: Icon(
              Icons.clear_all,
              color: AppTheme.neonBlue,
            ),
          ),
          IconButton(
            onPressed: () {
              // Pause all transfers
            },
            icon: Icon(
              Icons.pause,
              color: AppTheme.neonViolet,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.darkGray,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.neonBlue.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TransferStat(
                  label: 'Active',
                  value: '3',
                  color: AppTheme.neonBlue,
                ),
                _TransferStat(
                  label: 'Queued',
                  value: '7',
                  color: AppTheme.neonViolet,
                ),
                _TransferStat(
                  label: 'Completed',
                  value: '24',
                  color: AppTheme.neonGreen,
                ),
                _TransferStat(
                  label: 'Speed',
                  value: '12.5 MB/s',
                  color: Colors.orange,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return TransferItem(
                  fileName: 'video_${index + 1}.mp4',
                  fileSize: '125.3 MB',
                  progress: index == 0 ? 0.75 : index == 1 ? 0.45 : 0.0,
                  status: index == 0 ? TransferStatus.active : 
                          index == 1 ? TransferStatus.active :
                          TransferStatus.queued,
                  speed: index == 0 ? '8.2 MB/s' : index == 1 ? '4.3 MB/s' : null,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [AppTheme.neonBlue, AppTheme.neonViolet],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.neonBlue.withOpacity(0.5),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            // Add new transfer
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            'Add Transfer',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'JetBrainsMono',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _TransferStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _TransferStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'JetBrainsMono',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppTheme.lightGray,
            fontSize: 12,
            fontFamily: 'JetBrainsMono',
          ),
        ),
      ],
    );
  }
}

enum TransferStatus {
  queued,
  active,
  paused,
  completed,
  failed,
}
