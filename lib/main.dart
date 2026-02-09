import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neon_file_manager/app/app.dart';
import 'package:neon_file_manager/core/theme/app_theme.dart';
import 'package:neon_file_manager/core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await StorageService.init();
  
  runApp(
    ProviderScope(
      child: NeonFileManager(),
    ),
  );
}

class NeonFileManager extends StatelessWidget {
  const NeonFileManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Neon File Manager',
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
