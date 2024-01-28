import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'calander_platform_interface.dart';

/// An implementation of [CalanderPlatform] that uses method channels.
class MethodChannelCalander extends CalanderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('calander');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
