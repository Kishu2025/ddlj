import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';
import 'package:neon_file_manager/core/services/file_operations_service.dart';

class FileOperationsDialog extends ConsumerStatefulWidget {
  final String filePath;
  final String fileName;
  final bool isDirectory;

  const FileOperationsDialog({
    super.key,
    required this.filePath,
    required this.fileName,
    required this.isDirectory,
  });

  @override
  ConsumerState<FileOperationsDialog> createState() => _FileOperationsDialogState();
}

class _FileOperationsDialogState extends ConsumerState<FileOperationsDialog> {
  final TextEditingController _renameController = TextEditingController();
  bool _isRenaming = false;

  @override
  void initState() {
    super.initState();
    _renameController.text = widget.fileName;
  }

  @override
  void dispose() {
    _renameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.darkGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppTheme.neonBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  widget.isDirectory ? Icons.folder : Icons.insert_drive_file,
                  color: AppTheme.neonBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.fileName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JetBrainsMono',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_isRenaming) ...[
              Text(
                'Rename to:',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'JetBrainsMono',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _renameController,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'JetBrainsMono',
                ),
                decoration: InputDecoration(
                  hintText: 'Enter new name',
                  hintStyle: TextStyle(
                    color: AppTheme.lightGray,
                    fontFamily: 'JetBrainsMono',
                  ),
                  filled: true,
                  fillColor: AppTheme.pureBlack,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppTheme.neonBlue.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppTheme.neonBlue,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isRenaming = false;
                        _renameController.text = widget.fileName;
                      });
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppTheme.lightGray,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _renameFile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.neonBlue,
                      foregroundColor: AppTheme.pureBlack,
                    ),
                    child: const Text(
                      'Rename',
                      style: TextStyle(
                        fontFamily: 'JetBrainsMono',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              _OperationButton(
                icon: Icons.edit,
                title: 'Rename',
                subtitle: 'Change file name',
                color: AppTheme.neonBlue,
                onTap: () {
                  setState(() {
                    _isRenaming = true;
                  });
                },
              ),
              const SizedBox(height: 12),
              _OperationButton(
                icon: Icons.copy,
                title: 'Copy',
                subtitle: 'Duplicate file',
                color: AppTheme.neonGreen,
                onTap: () {
                  Navigator.of(context).pop();
                  _showCopyDialog();
                },
              ),
              const SizedBox(height: 12),
              _OperationButton(
                icon: Icons.cut,
                title: 'Move',
                subtitle: 'Move to different location',
                color: AppTheme.neonViolet,
                onTap: () {
                  Navigator.of(context).pop();
                  _showMoveDialog();
                },
              ),
              const SizedBox(height: 12),
              _OperationButton(
                icon: Icons.delete,
                title: 'Delete',
                subtitle: 'Permanently remove',
                color: AppTheme.neonRed,
                onTap: () {
                  Navigator.of(context).pop();
                  _showDeleteConfirmation();
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: AppTheme.lightGray,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _renameFile() async {
    final newName = _renameController.text.trim();
    if (newName.isEmpty || newName == widget.fileName) {
      return;
    }

    final success = await FileOperationsService.renameFile(widget.filePath, newName);
    
    if (mounted) {
      if (success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'File renamed successfully',
              style: const TextStyle(fontFamily: 'JetBrainsMono'),
            ),
            backgroundColor: AppTheme.neonGreen,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to rename file',
              style: const TextStyle(fontFamily: 'JetBrainsMono'),
            ),
            backgroundColor: AppTheme.neonRed,
          ),
        );
      }
    }
  }

  void _showCopyDialog() {
    // TODO: Implement copy dialog
    showDialog(
      context: context,
      builder: (context) => _LocationDialog(
        title: 'Copy File',
        action: 'Copy',
        onLocationSelected: (destination) async {
          final success = await FileOperationsService.copyFile(
            widget.filePath,
            destination,
          );
          
          if (mounted) {
            Navigator.of(context).pop();
            if (success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'File copied successfully',
                    style: const TextStyle(fontFamily: 'JetBrainsMono'),
                  ),
                  backgroundColor: AppTheme.neonGreen,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Failed to copy file',
                    style: const TextStyle(fontFamily: 'JetBrainsMono'),
                  ),
                  backgroundColor: AppTheme.neonRed,
                ),
              );
            }
          }
        },
      ),
    );
  }

  void _showMoveDialog() {
    // TODO: Implement move dialog
    showDialog(
      context: context,
      builder: (context) => _LocationDialog(
        title: 'Move File',
        action: 'Move',
        onLocationSelected: (destination) async {
          final success = await FileOperationsService.moveFile(
            widget.filePath,
            destination,
          );
          
          if (mounted) {
            Navigator.of(context).pop();
            if (success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'File moved successfully',
                    style: const TextStyle(fontFamily: 'JetBrainsMono'),
                  ),
                  backgroundColor: AppTheme.neonGreen,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Failed to move file',
                    style: const TextStyle(fontFamily: 'JetBrainsMono'),
                  ),
                  backgroundColor: AppTheme.neonRed,
                ),
              );
            }
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.darkGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppTheme.neonRed.withOpacity(0.3),
            width: 1,
          ),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning,
              color: AppTheme.neonRed,
              size: 24,
            ),
            const SizedBox(width: 12),
            const Text(
              'Confirm Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'JetBrainsMono',
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${widget.fileName}"? This action cannot be undone.',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'JetBrainsMono',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppTheme.lightGray,
                fontFamily: 'JetBrainsMono',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final success = widget.isDirectory
                  ? await FileOperationsService.deleteDirectory(widget.filePath)
                  : await FileOperationsService.deleteFile(widget.filePath);
              
              if (mounted) {
                Navigator.of(context).pop();
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'File deleted successfully',
                        style: const TextStyle(fontFamily: 'JetBrainsMono'),
                      ),
                      backgroundColor: AppTheme.neonGreen,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Failed to delete file',
                        style: const TextStyle(fontFamily: 'JetBrainsMono'),
                      ),
                      backgroundColor: AppTheme.neonRed,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.neonRed,
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Delete',
              style: TextStyle(
                fontFamily: 'JetBrainsMono',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OperationButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _OperationButton({
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
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
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
            Icon(
              Icons.chevron_right,
              color: color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationDialog extends StatelessWidget {
  final String title;
  final String action;
  final Function(String) onLocationSelected;

  const _LocationDialog({
    required this.title,
    required this.action,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.darkGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppTheme.neonBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'JetBrainsMono',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Select destination location:',
              style: TextStyle(
                color: AppTheme.lightGray,
                fontSize: 14,
                fontFamily: 'JetBrainsMono',
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppTheme.pureBlack,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.neonBlue.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Center(
                child: Text(
                  'Location picker\n(To be implemented)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.lightGray,
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppTheme.lightGray,
                      fontFamily: 'JetBrainsMono',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Get selected location
                    onLocationSelected('/path/to/destination');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.neonBlue,
                    foregroundColor: AppTheme.pureBlack,
                  ),
                  child: Text(
                    action,
                    style: const TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontWeight: FontWeight.w600,
                    ),
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
