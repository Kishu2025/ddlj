import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';
import 'package:neon_file_manager/core/services/storage_service.dart';
import 'package:neon_file_manager/features/explorer/domain/models/file_item.dart';

class FilePane extends ConsumerStatefulWidget {
  final bool isLeftPane;
  final Function(FileItem) onFileSelected;

  const FilePane({
    super.key,
    required this.isLeftPane,
    required this.onFileSelected,
  });

  @override
  ConsumerState<FilePane> createState() => _FilePaneState();
}

class _FilePaneState extends ConsumerState<FilePane> {
  List<FileItem> _files = [];
  String _currentPath = '/';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final directories = await StorageService.getStorageDirectories();
      if (directories.isNotEmpty) {
        final currentDir = directories.first;
        _currentPath = currentDir.path;
        await _loadDirectoryContents(currentDir);
      }
    } catch (e) {
      print('Error loading files: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadDirectoryContents(Directory directory) async {
    try {
      final entities = await directory.list().toList();
      final files = <FileItem>[];

      for (final entity in entities) {
        try {
          final stat = await entity.stat();
          final isDirectory = entity is Directory;
          final fileName = entity.path.split('/').last;
          
          files.add(FileItem(
            name: fileName.isEmpty ? entity.path : fileName,
            path: entity.path,
            isDirectory: isDirectory,
            size: isDirectory ? BigInt.zero : BigInt.from(stat.size),
            lastModified: stat.modified,
            type: _getFileType(fileName, isDirectory),
          ));
        } catch (e) {
          continue;
        }
      }

      files.sort((a, b) {
        if (a.isDirectory != b.isDirectory) {
          return a.isDirectory ? -1 : 1;
        }
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      setState(() {
        _files = files;
      });
    } catch (e) {
      print('Error loading directory contents: $e');
    }
  }

  FileType _getFileType(String fileName, bool isDirectory) {
    if (isDirectory) return FileType.directory;
    
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'webp':
        return FileType.image;
      case 'mp4':
      case 'avi':
      case 'mov':
      case 'mkv':
      case 'wmv':
        return FileType.video;
      case 'mp3':
      case 'wav':
      case 'flac':
      case 'aac':
      case 'ogg':
        return FileType.audio;
      case 'pdf':
        return FileType.pdf;
      case 'txt':
      case 'md':
        return FileType.text;
      case 'zip':
      case 'rar':
      case '7z':
      case 'tar':
      case 'gz':
        return FileType.archive;
      case 'apk':
        return FileType.apk;
      case 'doc':
      case 'docx':
      case 'xls':
      case 'xlsx':
      case 'ppt':
      case 'pptx':
        return FileType.document;
      default:
        return FileType.unknown;
    }
  }

  IconData _getFileIcon(FileType type) {
    switch (type) {
      case FileType.directory:
        return Icons.folder;
      case FileType.image:
        return Icons.image;
      case FileType.video:
        return Icons.video_file;
      case FileType.audio:
        return Icons.audio_file;
      case FileType.pdf:
        return Icons.picture_as_pdf;
      case FileType.text:
        return Icons.text_snippet;
      case FileType.archive:
        return Icons.archive;
      case FileType.apk:
        return Icons.android;
      case FileType.document:
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileColor(FileType type) {
    switch (type) {
      case FileType.directory:
        return AppTheme.neonBlue;
      case FileType.image:
        return AppTheme.neonGreen;
      case FileType.video:
        return AppTheme.neonViolet;
      case FileType.audio:
        return Colors.orange;
      case FileType.pdf:
        return Colors.red;
      case FileType.text:
        return Colors.blue;
      case FileType.archive:
        return Colors.purple;
      case FileType.apk:
        return Colors.green;
      case FileType.document:
        return Colors.blueAccent;
      default:
        return AppTheme.lightGray;
    }
  }

  void _onFileTap(FileItem file) {
    if (file.isDirectory) {
      final directory = Directory(file.path);
      _loadDirectoryContents(directory);
      setState(() {
        _currentPath = file.path;
      });
    } else {
      widget.onFileSelected(file);
    }
  }

  Future<void> _navigateToParent() async {
    try {
      final currentDir = Directory(_currentPath);
      final parentDir = currentDir.parent;
      if (parentDir.path != currentDir.path) {
        await _loadDirectoryContents(parentDir);
        setState(() {
          _currentPath = parentDir.path;
        });
      }
    } catch (e) {
      print('Error navigating to parent: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: widget.isLeftPane ? AppTheme.neonBlue : AppTheme.neonViolet,
              strokeWidth: 2,
            ),
            const SizedBox(height: 16),
            Text(
              'Loading files...',
              style: TextStyle(
                color: widget.isLeftPane ? AppTheme.neonBlue : AppTheme.neonViolet,
                fontFamily: 'JetBrainsMono',
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.mediumGray,
            border: Border(
              bottom: BorderSide(
                color: (widget.isLeftPane ? AppTheme.neonBlue : AppTheme.neonViolet).withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: _currentPath != '/' ? _navigateToParent : null,
                icon: Icon(
                  Icons.arrow_upward,
                  color: _currentPath != '/' 
                      ? (widget.isLeftPane ? AppTheme.neonBlue : AppTheme.neonViolet)
                      : AppTheme.lightGray,
                  size: 20,
                ),
              ),
              Expanded(
                child: Text(
                  _currentPath,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'JetBrainsMono',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _files.length,
            itemBuilder: (context, index) {
              final file = _files[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _getFileColor(file.type).withOpacity(0.3),
                    width: 0.5,
                  ),
                ),
                child: ListTile(
                  dense: true,
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getFileColor(file.type).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      _getFileIcon(file.type),
                      color: _getFileColor(file.type),
                      size: 20,
                    ),
                  ),
                  title: Text(
                    file.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'JetBrainsMono',
                    ),
                  ),
                  subtitle: file.isDirectory
                      ? null
                      : Text(
                          StorageService.formatFileSize(file.size),
                          style: TextStyle(
                            color: AppTheme.lightGray,
                            fontSize: 12,
                            fontFamily: 'JetBrainsMono',
                          ),
                        ),
                  trailing: file.isDirectory
                      ? Icon(
                          Icons.chevron_right,
                          color: _getFileColor(file.type),
                          size: 16,
                        )
                      : null,
                  onTap: () => _onFileTap(file),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
