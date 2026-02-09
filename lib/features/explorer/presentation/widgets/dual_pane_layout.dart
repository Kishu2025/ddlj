import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';
import 'package:neon_file_manager/features/explorer/presentation/widgets/file_pane.dart';

class DualPaneLayout extends ConsumerStatefulWidget {
  final String leftPaneTitle;
  final String rightPaneTitle;

  const DualPaneLayout({
    super.key,
    required this.leftPaneTitle,
    required this.rightPaneTitle,
  });

  @override
  ConsumerState<DualPaneLayout> createState() => _DualPaneLayoutState();
}

class _DualPaneLayoutState extends ConsumerState<DualPaneLayout> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrDesktop = screenWidth > 768;

    if (isTabletOrDesktop) {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.darkGray,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.neonBlue.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.mediumGray,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: AppTheme.neonBlue.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.storage,
                          color: AppTheme.neonBlue,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.leftPaneTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'JetBrainsMono',
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.neonBlue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppTheme.neonBlue,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'LOCAL',
                            style: TextStyle(
                              color: AppTheme.neonBlue,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'JetBrainsMono',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FilePane(
                      isLeftPane: true,
                      onFileSelected: (file) {
                        // Handle file selection
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.neonBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.neonBlue,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.compare_arrows,
                    color: AppTheme.neonBlue,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.neonViolet.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.neonViolet,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.sync,
                    color: AppTheme.neonViolet,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.darkGray,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.neonViolet.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.mediumGray,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: AppTheme.neonViolet.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sd_storage,
                          color: AppTheme.neonViolet,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.rightPaneTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'JetBrainsMono',
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.neonViolet.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppTheme.neonViolet,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'EXTERNAL',
                            style: TextStyle(
                              color: AppTheme.neonViolet,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'JetBrainsMono',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FilePane(
                      isLeftPane: false,
                      onFileSelected: (file) {
                        // Handle file selection
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.darkGray,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.neonBlue.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.mediumGray,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.neonBlue.withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.storage,
                    color: AppTheme.neonBlue,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.leftPaneTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'JetBrainsMono',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FilePane(
                isLeftPane: true,
                onFileSelected: (file) {
                  // Handle file selection
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
