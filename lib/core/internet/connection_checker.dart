import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isInternetConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internet;

  ConnectionCheckerImpl(this.internet);

  @override
  Future<bool> get isInternetConnected async =>
      await internet.hasInternetAccess;
}
