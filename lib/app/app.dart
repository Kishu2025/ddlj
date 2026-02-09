import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neon_file_manager/features/explorer/presentation/pages/explorer_page.dart';
import 'package:neon_file_manager/features/storage/presentation/pages/storage_dashboard_page.dart';
import 'package:neon_file_manager/features/transfers/presentation/pages/transfer_queue_page.dart';
import 'package:neon_file_manager/features/settings/presentation/pages/settings_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/explorer',
    routes: [
      GoRoute(
        path: '/explorer',
        builder: (context, state) => const ExplorerPage(),
      ),
      GoRoute(
        path: '/storage',
        builder: (context, state) => const StorageDashboardPage(),
      ),
      GoRoute(
        path: '/transfers',
        builder: (context, state) => const TransferQueuePage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}
