import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageService {
  static late Directory _appDocumentsDir;
  static late Directory _appTempDir;

  static Future<void> init() async {
    _appDocumentsDir = await getApplicationDocumentsDirectory();
    _appTempDir = await getTemporaryDirectory();
  }

  static Directory get appDocumentsDir => _appDocumentsDir;
  static Directory get appTempDir => _appTempDir;

  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
    return true;
  }

  static Future<bool> requestManageExternalStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    }
    return true;
  }

  static Future<List<Directory>> getStorageDirectories() async {
    final List<Directory> directories = [];
    
    if (Platform.isAndroid) {
      directories.add(_appDocumentsDir);
      
      try {
        final externalStorage = await getExternalStorageDirectory();
        if (externalStorage != null) {
          directories.add(externalStorage);
        }
        
        final List<Directory>? externalStorages = await getExternalStorageDirectories();
        if (externalStorages != null) {
          directories.addAll(externalStorages);
        }
      } catch (e) {
        print('Error accessing external storage: $e');
      }
    } else if (Platform.isWindows) {
      directories.add(Directory.current);
      
      try {
        final homeDir = Platform.environment['USERPROFILE'];
        if (homeDir != null) {
          directories.add(Directory(homeDir));
        }
        
        final drives = ['C:', 'D:', 'E:', 'F:'];
        for (final drive in drives) {
          try {
            final driveDir = Directory(drive + r'\');
            if (await driveDir.exists()) {
              directories.add(driveDir);
            }
          } catch (e) {
            continue;
          }
        }
      } catch (e) {
        print('Error accessing Windows drives: $e');
      }
    }
    
    return directories;
  }

  static Future<BigInt> getDirectorySize(Directory dir) async {
    try {
      final files = await dir.list(recursive: true).toList();
      BigInt totalSize = BigInt.zero;
      
      for (final file in files) {
        if (file is File) {
          try {
            final stat = await file.stat();
            totalSize += BigInt.from(stat.size);
          } catch (e) {
            continue;
          }
        }
      }
      
      return totalSize;
    } catch (e) {
      return BigInt.zero;
    }
  }

  static Future<BigInt> getFreeSpace(Directory dir) async {
    try {
      final stat = await dir.stat();
      if (stat.type == FileSystemEntityType.directory) {
        return BigInt.from(await dir.stat().then((s) => s.size));
      }
    } catch (e) {
      return BigInt.zero;
    }
    return BigInt.zero;
  }

  static String formatFileSize(BigInt bytes) {
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int unitIndex = 0;
    double size = bytes.toDouble();

    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }

    return '${size.toStringAsFixed(unitIndex == 0 ? 0 : 2)} ${units[unitIndex]}';
  }
}
