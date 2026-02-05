import 'package:get_it/get_it.dart';

import '/core/network/app_network_manager.dart';
import '/core/logger/app_logger.dart';

final getIt = GetIt.instance;

/// Sets up dependency injection for the application.
Future<void> setupInjection() async {
  /// Network
  getIt.registerSingleton<AppNetworkManager>(AppNetworkManager());

  /// Logger
  getIt.registerSingleton<AppLogger>(AppLogger());
}
