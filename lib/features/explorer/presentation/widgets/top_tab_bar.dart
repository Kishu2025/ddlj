import 'package:flutter/material.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';

class TopTabBar extends StatelessWidget {
  final TabController controller;
  final int selectedIndex;

  const TopTabBar({
    super.key,
    required this.controller,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        labelColor: AppTheme.neonBlue,
        unselectedLabelColor: AppTheme.lightGray,
        indicatorColor: AppTheme.neonBlue,
        indicatorWeight: 2,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'JetBrainsMono',
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'JetBrainsMono',
        ),
        tabs: const [
          Tab(
            icon: Icon(Icons.photo_library, size: 20),
            text: 'Photos',
          ),
          Tab(
            icon: Icon(Icons.video_library, size: 20),
            text: 'Videos',
          ),
          Tab(
            icon: Icon(Icons.music_note, size: 20),
            text: 'Music',
          ),
          Tab(
            icon: Icon(Icons.description, size: 20),
            text: 'Documents',
          ),
          Tab(
            icon: Icon(Icons.android, size: 20),
            text: 'APKs',
          ),
          Tab(
            icon: Icons.folder, size: 20),
            text: 'All Files',
          ),
        ],
      ),
    );
  }
}
