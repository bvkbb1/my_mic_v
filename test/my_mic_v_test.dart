import 'package:flutter_test/flutter_test.dart';
import 'package:my_mic_v/my_mic_v.dart';
import 'package:my_mic_v/my_mic_v_platform_interface.dart';
import 'package:my_mic_v/my_mic_v_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyMic_vPlatform
    with MockPlatformInterfaceMixin
    implements MyMic_vPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyMic_vPlatform initialPlatform = MyMic_vPlatform.instance;

  test('$MethodChannelMyMic_v is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyMic_v>());
  });

  test('getPlatformVersion', () async {
    MyMic_v myMic_vPlugin = MyMic_v();
    MockMyMic_vPlatform fakePlatform = MockMyMic_vPlatform();
    MyMic_vPlatform.instance = fakePlatform;

    expect(await myMic_vPlugin.getPlatformVersion(), '42');
  });
}
