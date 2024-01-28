import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'calander_method_channel.dart';

abstract class CalanderPlatform extends PlatformInterface {
  /// Constructs a CalanderPlatform.
  CalanderPlatform() : super(token: _token);

  static final Object _token = Object();

  static CalanderPlatform _instance = MethodChannelCalander();

  /// The default instance of [CalanderPlatform] to use.
  ///
  /// Defaults to [MethodChannelCalander].
  static CalanderPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CalanderPlatform] when
  /// they register themselves.
  static set instance(CalanderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
