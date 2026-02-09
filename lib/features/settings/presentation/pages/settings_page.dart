import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppTheme.pureBlack,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SettingsSection(
              title: 'Appearance',
              icon: Icons.palette,
              color: AppTheme.neonBlue,
              children: [
                _SettingsItem(
                  title: 'Theme',
                  subtitle: 'Dark mode (AMOLED)',
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Theme settings
                  },
                ),
                _SettingsItem(
                  title: 'Accent Color',
                  subtitle: 'Neon Blue',
                  trailing: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppTheme.neonBlue,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                  ),
                  onTap: () {
                    // Color picker
                  },
                ),
                _SettingsItem(
                  title: 'Pure Black Mode',
                  subtitle: 'AMOLED friendly',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // Toggle pure black
                    },
                    activeColor: AppTheme.neonBlue,
                  ),
                  onTap: () {
                    // Toggle pure black
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            _SettingsSection(
              title: 'File Operations',
              icon: Icons.file_copy,
              color: AppTheme.neonViolet,
              children: [
                _SettingsItem(
                  title: 'Default Action',
                  subtitle: 'Copy on long press',
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Default action settings
                  },
                ),
                _SettingsItem(
                  title: 'Show Hidden Files',
                  subtitle: 'Display system files',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      // Toggle hidden files
                    },
                    activeColor: AppTheme.neonViolet,
                  ),
                  onTap: () {
                    // Toggle hidden files
                  },
                ),
                _SettingsItem(
                  title: 'Confirm Deletions',
                  subtitle: 'Ask before deleting',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // Toggle confirm deletions
                    },
                    activeColor: AppTheme.neonViolet,
                  ),
                  onTap: () {
                    // Toggle confirm deletions
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            _SettingsSection(
              title: 'Sync & Backup',
              icon: Icons.sync,
              color: AppTheme.neonGreen,
              children: [
                _SettingsItem(
                  title: 'Auto Sync',
                  subtitle: 'Every 6 hours',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // Toggle auto sync
                    },
                    activeColor: AppTheme.neonGreen,
                  ),
                  onTap: () {
                    // Toggle auto sync
                  },
                ),
                _SettingsItem(
                  title: 'Sync Rules',
                  subtitle: 'Configure folder rules',
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Sync rules configuration
                  },
                ),
                _SettingsItem(
                  title: 'Cloud Storage',
                  subtitle: 'Connected: Google Drive',
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Cloud storage settings
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            _SettingsSection(
              title: 'Performance',
              icon: Icons.speed,
              color: Colors.orange,
              children: [
                _SettingsItem(
                  title: 'Transfer Threads',
                  subtitle: '4 concurrent',
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Transfer threads settings
                  },
                ),
                _SettingsItem(
                  title: 'Cache Size',
                  subtitle: '512 MB',
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Cache size settings
                  },
                ),
                _SettingsItem(
                  title: 'Hardware Acceleration',
                  subtitle: 'Enabled',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // Toggle hardware acceleration
                    },
                    activeColor: Colors.orange,
                  ),
                  onTap: () {
                    // Toggle hardware acceleration
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            _SettingsSection(
              title: 'About',
              icon: Icons.info,
              color: AppTheme.lightGray,
              children: [
                _SettingsItem(
                  title: 'Version',
                  subtitle: '1.0.0',
                  trailing: null,
                  onTap: null,
                ),
                _SettingsItem(
                  title: 'Developer',
                  subtitle: 'Neon Labs',
                  trailing: null,
                  onTap: null,
                ),
                _SettingsItem(
                  title: 'Check for Updates',
                  subtitle: 'Last checked: Never',
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Check for updates
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkGray,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.mediumGray,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(
                  color: color.withOpacity(0.3),
                  width: 1,
                ),
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
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsItem({
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.mediumGray,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
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
                  const SizedBox(height: 2),
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
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
