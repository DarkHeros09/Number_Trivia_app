import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements INetworkInfo {
  final DataConnectionChecker connectionChecker;
  const NetworkInfoImpl({@required this.connectionChecker});
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
