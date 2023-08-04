import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:next_starter/common/network/network_info.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {
  @override
  Future<bool> get isConnected => Future.value(true);

  @override
  Stream<InternetConnectionStatus> getStatus() {
    return Stream.value(InternetConnectionStatus.connected);
  }
}
