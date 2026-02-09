enum FileType {
  directory,
  image,
  video,
  audio,
  pdf,
  text,
  archive,
  apk,
  document,
  unknown,
}

class FileItem {
  final String name;
  final String path;
  final bool isDirectory;
  final BigInt size;
  final DateTime lastModified;
  final FileType type;

  FileItem({
    required this.name,
    required this.path,
    required this.isDirectory,
    required this.size,
    required this.lastModified,
    required this.type,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FileItem &&
        other.path == path &&
        other.name == name &&
        other.isDirectory == isDirectory &&
        other.size == size &&
        other.lastModified == lastModified &&
        other.type == type;
  }

  @override
  int get hashCode {
    return path.hashCode ^
        name.hashCode ^
        isDirectory.hashCode ^
        size.hashCode ^
        lastModified.hashCode ^
        type.hashCode;
  }

  @override
  String toString() {
    return 'FileItem(name: $name, path: $path, isDirectory: $isDirectory, size: $size, type: $type)';
  }

  FileItem copyWith({
    String? name,
    String? path,
    bool? isDirectory,
    BigInt? size,
    DateTime? lastModified,
    FileType? type,
  }) {
    return FileItem(
      name: name ?? this.name,
      path: path ?? this.path,
      isDirectory: isDirectory ?? this.isDirectory,
      size: size ?? this.size,
      lastModified: lastModified ?? this.lastModified,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'path': path,
      'isDirectory': isDirectory,
      'size': size.toString(),
      'lastModified': lastModified.toIso8601String(),
      'type': type.toString(),
    };
  }

  factory FileItem.fromMap(Map<String, dynamic> map) {
    return FileItem(
      name: map['name'],
      path: map['path'],
      isDirectory: map['isDirectory'],
      size: BigInt.parse(map['size']),
      lastModified: DateTime.parse(map['lastModified']),
      type: FileType.values.firstWhere(
        (e) => e.toString() == map['type'],
        orElse: () => FileType.unknown,
      ),
    );
  }
}
