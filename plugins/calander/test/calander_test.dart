import 'package:flutter_test/flutter_test.dart';
import 'package:calander/calander.dart';
import 'package:calander/calander_platform_interface.dart';
import 'package:calander/calander_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCalanderPlatform
    with MockPlatformInterfaceMixin
    implements CalanderPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CalanderPlatform initialPlatform = CalanderPlatform.instance;

  test('$MethodChannelCalander is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCalander>());
  });

  test('getPlatformVersion', () async {
    Calander calanderPlugin = Calander();
    MockCalanderPlatform fakePlatform = MockCalanderPlatform();
    CalanderPlatform.instance = fakePlatform;

    expect(await calanderPlugin.getPlatformVersion(), '42');
  });
}
