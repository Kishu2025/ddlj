import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class FileOperationsService {
  static Future<bool> copyFile(String sourcePath, String destinationPath) async {
    try {
      final sourceFile = File(sourcePath);
      final destinationFile = File(destinationPath);
      
      if (!await sourceFile.exists()) {
        return false;
      }
      
      // Create destination directory if it doesn't exist
      final destinationDir = destinationFile.parent;
      if (!await destinationDir.exists()) {
        await destinationDir.create(recursive: true);
      }
      
      // Check if destination file exists and handle conflict
      if (await destinationFile.exists()) {
        return false; // File already exists
      }
      
      await sourceFile.copy(destinationPath);
      return true;
    } catch (e) {
      print('Error copying file: $e');
      return false;
    }
  }

  static Future<bool> moveFile(String sourcePath, String destinationPath) async {
    try {
      final sourceFile = File(sourcePath);
      final destinationFile = File(destinationPath);
      
      if (!await sourceFile.exists()) {
        return false;
      }
      
      // Create destination directory if it doesn't exist
      final destinationDir = destinationFile.parent;
      if (!await destinationDir.exists()) {
        await destinationDir.create(recursive: true);
      }
      
      // Check if destination file exists and handle conflict
      if (await destinationFile.exists()) {
        return false; // File already exists
      }
      
      await sourceFile.rename(destinationPath);
      return true;
    } catch (e) {
      print('Error moving file: $e');
      return false;
    }
  }

  static Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting file: $e');
      return false;
    }
  }

  static Future<bool> deleteDirectory(String dirPath) async {
    try {
      final directory = Directory(dirPath);
      if (await directory.exists()) {
        await directory.delete(recursive: true);
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting directory: $e');
      return false;
    }
  }

  static Future<bool> renameFile(String oldPath, String newName) async {
    try {
      final oldFile = File(oldPath);
      if (!await oldFile.exists()) {
        return false;
      }
      
      final newPath = path.join(path.dirname(oldPath), newName);
      await oldFile.rename(newPath);
      return true;
    } catch (e) {
      print('Error renaming file: $e');
      return false;
    }
  }

  static Future<bool> createDirectory(String dirPath) async {
    try {
      final directory = Directory(dirPath);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      return true;
    } catch (e) {
      print('Error creating directory: $e');
      return false;
    }
  }

  static Future<String?> calculateFileChecksum(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return null;
      }
      
      final bytes = await file.readAsBytes();
      final digest = sha256.convert(bytes);
      return digest.toString();
    } catch (e) {
      print('Error calculating checksum: $e');
      return null;
    }
  }

  static Future<bool> areFilesIdentical(String path1, String path2) async {
    try {
      final file1 = File(path1);
      final file2 = File(path2);
      
      if (!await file1.exists() || !await file2.exists()) {
        return false;
      }
      
      // First compare file sizes
      final stat1 = await file1.stat();
      final stat2 = await file2.stat();
      
      if (stat1.size != stat2.size) {
        return false;
      }
      
      // Then compare checksums
      final checksum1 = await calculateFileChecksum(path1);
      final checksum2 = await calculateFileChecksum(path2);
      
      return checksum1 == checksum2;
    } catch (e) {
      print('Error comparing files: $e');
      return false;
    }
  }

  static Future<List<String>> findDuplicateFiles(String directoryPath) async {
    try {
      final directory = Directory(directoryPath);
      if (!await directory.exists()) {
        return [];
      }
      
      final files = await directory
          .list(recursive: true)
          .where((entity) => entity is File)
          .cast<File>()
          .toList();
      
      final checksumMap = <String, List<String>>{};
      
      for (final file in files) {
        try {
          final checksum = await calculateFileChecksum(file.path);
          if (checksum != null) {
            checksumMap.putIfAbsent(checksum, () => []).add(file.path);
          }
        } catch (e) {
          continue;
        }
      }
      
      final duplicates = <String>[];
      for (final entry in checksumMap.entries) {
        if (entry.value.length > 1) {
          duplicates.addAll(entry.value);
        }
      }
      
      return duplicates;
    } catch (e) {
      print('Error finding duplicates: $e');
      return [];
    }
  }

  static Future<List<String>> findLargeFiles(String directoryPath, int minSizeMB) async {
    try {
      final directory = Directory(directoryPath);
      if (!await directory.exists()) {
        return [];
      }
      
      final minSizeBytes = minSizeMB * 1024 * 1024;
      final largeFiles = <String>[];
      
      await for (final entity in directory.list(recursive: true)) {
        if (entity is File) {
          try {
            final stat = await entity.stat();
            if (stat.size >= minSizeBytes) {
              largeFiles.add(entity.path);
            }
          } catch (e) {
            continue;
          }
        }
      }
      
      return largeFiles;
    } catch (e) {
      print('Error finding large files: $e');
      return [];
    }
  }

  static Future<bool> compressFiles(List<String> filePaths, String archivePath) async {
    try {
      // This is a placeholder - you'd need to implement actual ZIP compression
      // using a package like 'archive' or 'flutter_archive'
      print('Compressing ${filePaths.length} files to $archivePath');
      
      // Create archive directory if it doesn't exist
      final archiveDir = File(archivePath).parent;
      if (!await archiveDir.exists()) {
        await archiveDir.create(recursive: true);
      }
      
      // TODO: Implement actual compression logic
      return true;
    } catch (e) {
      print('Error compressing files: $e');
      return false;
    }
  }

  static Future<bool> extractArchive(String archivePath, String destinationPath) async {
    try {
      // This is a placeholder - you'd need to implement actual ZIP extraction
      // using a package like 'archive' or 'flutter_archive'
      print('Extracting $archivePath to $destinationPath');
      
      // Create destination directory if it doesn't exist
      final destinationDir = Directory(destinationPath);
      if (!await destinationDir.exists()) {
        await destinationDir.create(recursive: true);
      }
      
      // TODO: Implement actual extraction logic
      return true;
    } catch (e) {
      print('Error extracting archive: $e');
      return false;
    }
  }
}
